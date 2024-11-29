import 'package:shared_preferences/shared_preferences.dart';

class SpData {
  static late SharedPreferences _preferences;
  static const String userid = " ";
    SpData._init();
   static SpData get instance => SpData._init();
   sharedSet() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setprafdata(String key, String value) async {  
    await _preferences.setString(key, value);
  }

  static String getprafdata(String key) {
    return _preferences.getString(key).toString();
  }

  static removeprafdata(String key) async {
    await _preferences.remove(key);
  }
}

