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
}
