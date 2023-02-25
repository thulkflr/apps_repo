import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences pref;

  static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<bool> setBooleanValue(String key, bool value) async {
    return await pref.setBool(key, value);
  }

  static dynamic getBooleanValue(key) {
    return pref.get(key);
  }

  static Future<bool> saveData({required String key, dynamic value}) {
    if (value is String) return pref.setString(key, value);
    if (value is int) return pref.setInt(key, value);
    if (value is bool) return pref.setBool(key, value);

    return pref.setDouble(key, value);
  }

  static Future<bool> removeDATA(String key) async{
   return await pref.remove(key);
  }
}
