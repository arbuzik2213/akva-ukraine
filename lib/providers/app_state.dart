import 'package:flutter/material.dart';
import '../localization/app_strings.dart';
import '../models/location_schedule.dart';
import '../services/notification_service.dart';
import '../theme/app_theme.dart';

class AppState extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();

  AppAppearance _appearance = AppAppearance.black; // Screenshot uses pure black OLED
  AppAccentColor _accentColor = AppAccentColor.yellow; // Screenshot default
  int _selectedIconIndex = 0;
  String _widgetStyle = 'theme'; // 'theme', 'transparent', 'colored'
  String _languageCode = 'system'; // Default: 'Як у системі'

  bool _notifyEmergency = true;
  bool _notifyBefore = false;
  bool _showTomorrow = true;

  List<LocationSchedule> _locations = [
    LocationSchedule(
      id: 'loc_1',
      label: 'ДІМ',
      queue: 'черга 15.1',
      statusText: 'Вода є',
      hasWater: true,
      nextEventTimeText: 'вимкнуть о 16:00',
      address: 'вул. Голего Миколи, 7В • Київ',
      cityId: 'kyiv_city',
      // 24 hours schedule: water cuts off at 16:00 - 20:00 (hours 16, 17, 18, 19)
      hourlyWaterStatus: [
        true, true, true, true, true, true, true, true,
        true, true, true, true, true, true, true, true,
        false, false, false, false, true, true, true, true,
      ],
    ),
    LocationSchedule(
      id: 'loc_2',
      label: 'СЕЛО',
      queue: 'черга 1.2',
      statusText: 'Вода є',
      hasWater: true,
      nextEventTimeText: 'вимкнуть о 17:00',
      address: 'вул. Марчуків, 45 • Житомирська обла...',
      cityId: 'zhytomyr_obl',
      // water cuts off at 17:00 - 21:00
      hourlyWaterStatus: [
        true, true, true, true, true, true, true, true,
        true, true, true, true, true, true, true, true,
        true, false, false, false, false, true, true, true,
      ],
    ),
  ];

  AppAppearance get appearance => _appearance;
  AppAccentColor get accentColor => _accentColor;
  int get selectedIconIndex => _selectedIconIndex;
  String get widgetStyle => _widgetStyle;
  String get languageCode => _languageCode;
  bool get notifyEmergency => _notifyEmergency;
  bool get notifyBefore => _notifyBefore;
  bool get showTomorrow => _showTomorrow;
  List<LocationSchedule> get locations => _locations;

  String tr(String key) => AppStrings.get(key, _languageCode);

  ThemeData get themeData {
    switch (_appearance) {
      case AppAppearance.light:
        return AppTheme.lightTheme(_accentColor);
      case AppAppearance.dark:
        return AppTheme.darkTheme(_accentColor);
      case AppAppearance.black:
      case AppAppearance.auto:
        return AppTheme.blackTheme(_accentColor);
    }
  }

  Future<void> init() async {
    await _notificationService.initialize();
  }

  void setAppearance(AppAppearance app) {
    _appearance = app;
    notifyListeners();
  }

  void setAccentColor(AppAccentColor color) {
    _accentColor = color;
    notifyListeners();
  }

  void setSelectedIconIndex(int index) {
    _selectedIconIndex = index;
    notifyListeners();
  }

  void setWidgetStyle(String style) {
    _widgetStyle = style;
    notifyListeners();
  }

  void setLanguageCode(String code) {
    if (AppStrings.supportedLanguages.contains(code)) {
      _languageCode = code;
      notifyListeners();
    }
  }

  void setNotifyEmergency(bool val) {
    _notifyEmergency = val;
    notifyListeners();
  }

  void setNotifyBefore(bool val) {
    _notifyBefore = val;
    notifyListeners();
  }

  void setShowTomorrow(bool val) {
    _showTomorrow = val;
    notifyListeners();
  }

  void addLocation(LocationSchedule loc) {
    _locations.add(loc);
    notifyListeners();
  }

  void removeLocation(String id) {
    _locations.removeWhere((l) => l.id == id);
    notifyListeners();
  }

  void clearSavedSchedules() {
    // Keeps locations, refreshes their schedule timestamps
    notifyListeners();
  }

  Future<void> triggerTestAlert() async {
    await _notificationService.showNotification(
      id: 777,
      title: 'Є Вода: Сповіщення за графіком',
      body: 'Увага! За 30 хвилин (о 16:00) за адресою вул. Голего Миколи, 7В заплановано вимкнення водопостачання.',
    );
  }
}
