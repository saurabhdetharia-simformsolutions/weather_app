import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  final SharedPreferences sharedPreferences;

  SecureStorage({required this.sharedPreferences});

  Future<void> setString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  String getString(String key) {
    final value = sharedPreferences.getString(key);
    return value ?? "";
  }

  Future<void> setBoolean(String key, bool value) async {
    await sharedPreferences.setBool(key, value);
  }

  bool getBoolean(String key, [bool? defaultValue]) {
    final bool? value = sharedPreferences.getBool(key);
    return value ?? defaultValue ?? false;
  }
}
