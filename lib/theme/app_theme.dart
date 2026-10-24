import 'package:flutter/material.dart';

enum AppAppearance {
  auto,
  light,
  dark,
  black,
}

enum AppAccentColor {
  yellow,
  orange,
  green,
  blue,
  purple,
  pink,
}

class AppTheme {
  static Color getAccentColor(AppAccentColor color) {
    switch (color) {
      case AppAccentColor.yellow:
        return const Color(0xFFFFB800);
      case AppAccentColor.orange:
        return const Color(0xFFFF9500);
      case AppAccentColor.green:
        return const Color(0xFF34C759);
      case AppAccentColor.blue:
        return const Color(0xFF007AFF);
      case AppAccentColor.purple:
        return const Color(0xFFAF52DE);
      case AppAccentColor.pink:
        return const Color(0xFFFF2D55);
    }
  }

  // Pure OLED Black (as in screenshot)
  static ThemeData blackTheme(AppAccentColor accent) {
    final primary = getAccentColor(accent);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF000000),
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: primary,
        surface: const Color(0xFF141416),
        onSurface: Colors.white,
      ),
      cardColor: const Color(0xFF161618),
      dividerColor: const Color(0xFF242426),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF000000),
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.w800,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }

  // Dark Theme
  static ThemeData darkTheme(AppAccentColor accent) {
    final primary = getAccentColor(accent);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0C0C0E),
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: primary,
        surface: const Color(0xFF1A1A1E),
        onSurface: Colors.white,
      ),
      cardColor: const Color(0xFF1C1C20),
      dividerColor: const Color(0xFF2A2A2E),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0C0C0E),
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.w800,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }

  // Light Theme
  static ThemeData lightTheme(AppAccentColor accent) {
    final primary = getAccentColor(accent);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF2F2F7),
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: primary,
        surface: Colors.white,
        onSurface: const Color(0xFF000000),
      ),
      cardColor: Colors.white,
      dividerColor: const Color(0xFFE5E5EA),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF2F2F7),
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.w800,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }
}
