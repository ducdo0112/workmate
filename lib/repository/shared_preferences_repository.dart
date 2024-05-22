import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String keyUUID = 'keyUUID';
  static const String keyEmail = 'keyEmail';
  static const String keyStatus = 'keyStatus';

  static Future<void> setStringType(String key, String input) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(key, input);
  }

  static Future<String> getStringType(String key) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key) ?? '';
  }

  static Future<void> setIntType(String key, int input) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt(key, input);
  }

  static Future<int> getIntType(String key) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt(key) ?? 0;
  }

  static Future<void> setBoolType(String key, bool input) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool(key, input);
  }

  static Future<bool> getBoolType(String key) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(key) ?? false;
  }
}
