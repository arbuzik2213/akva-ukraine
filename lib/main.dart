import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'providers/app_state.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appState = AppState();
  await appState.init();

  runApp(
    ChangeNotifierProvider.value(
      value: appState,
      child: const AquaApp(),
    ),
  );
}

class AquaApp extends StatelessWidget {
  const AquaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    // Determine active locale
    Locale activeLocale = const Locale('uk', '');
    if (state.languageCode != 'system') {
      activeLocale = Locale(state.languageCode, '');
    }

    return MaterialApp(
      title: 'Є Вода',
      debugShowCheckedModeBanner: false,
      theme: state.themeData,
      locale: activeLocale,
      supportedLocales: const [
        Locale('uk', ''),
        Locale('en', ''),
        Locale('es', ''),
        Locale('pl', ''),
        Locale('de', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomeScreen(),
    );
  }
}
