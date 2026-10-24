import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/notification_setting.dart';

class StorageService {
  static const String _keyThemeMode = 'app_theme_mode';
  static const String _keyLanguage = 'app_language_code';
  static const String _keyCityId = 'app_selected_city_id';
  static const String _keyStreet = 'app_selected_street';
  
  static const String _keyAlert10 = 'notif_alert_10';
  static const String _keyAlert30 = 'notif_alert_30';
  static const String _keyAlert1H = 'notif_alert_1h';
  static const String _keyAlertRestore = 'notif_alert_restore';
  static const String _keySound = 'notif_sound';
  static const String _keyVibration = 'notif_vibration';

  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_keyThemeMode);
    if (value == 'light') return ThemeMode.light;
    if (value == 'dark') return ThemeMode.dark;
    return ThemeMode.system;
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    String value = 'system';
    if (mode == ThemeMode.light) value = 'light';
    if (mode == ThemeMode.dark) value = 'dark';
    await prefs.setString(_keyThemeMode, value);
  }

  Future<String> getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage) ?? 'uk';
  }

  Future<void> saveLanguageCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, code);
  }

  Future<String> getSelectedCityId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyCityId) ?? 'kyiv';
  }

  Future<void> saveSelectedCityId(String cityId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyCityId, cityId);
  }

  Future<String> getSelectedStreet() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyStreet) ?? 'вул. Хрещатик, 24';
  }

  Future<void> saveSelectedStreet(String street) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyStreet, street);
  }

  Future<NotificationSetting> getNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return NotificationSetting(
      alert10Min: prefs.getBool(_keyAlert10) ?? true,
      alert30Min: prefs.getBool(_keyAlert30) ?? true,
      alert1Hour: prefs.getBool(_keyAlert1H) ?? false,
      alertOnRestore: prefs.getBool(_keyAlertRestore) ?? true,
      soundEnabled: prefs.getBool(_keySound) ?? true,
      vibrationEnabled: prefs.getBool(_keyVibration) ?? true,
    );
  }

  Future<void> saveNotificationSettings(NotificationSetting settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyAlert10, settings.alert10Min);
    await prefs.setBool(_keyAlert30, settings.alert30Min);
    await prefs.setBool(_keyAlert1H, settings.alert1Hour);
    await prefs.setBool(_keyAlertRestore, settings.alertOnRestore);
    await prefs.setBool(_keySound, settings.soundEnabled);
    await prefs.setBool(_keyVibration, settings.vibrationEnabled);
  }
}
