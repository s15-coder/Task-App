import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesApp {
  static final PreferencesApp _instance = PreferencesApp._privateConstructor();
  factory PreferencesApp() => _instance;
  PreferencesApp._privateConstructor();

  late SharedPreferences _preferences;
  Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String? getToken() {
    return _preferences.getString('token');
  }

  Future<bool> setToken(String token) {
    return _preferences.setString('token', token);
  }

  Future<bool> removeToken() {
    return _preferences.remove('token');
  }

  Future setThemeMode(ThemeMode value) {
    late String themeString = '';
    switch (value) {
      case ThemeMode.system:
        themeString = 'system';
        break;
      case ThemeMode.light:
        themeString = 'light';
        break;
      case ThemeMode.dark:
        themeString = 'dark';
        break;
    }
    return _preferences.setString('theme_mode', themeString);
  }

  ThemeMode getThemeMode() {
    final themeString = _preferences.getString('theme_mode') ?? "system";
    switch (themeString) {
      case 'system':
        return ThemeMode.system;
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}
