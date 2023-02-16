import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences pref;

  static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<bool> setBooleanValue(String key, bool value) async {
    return await pref.setBool(key, value);
  }

  static bool? getBooleanValue(key) {
    return pref.getBool(key);
  }
}
