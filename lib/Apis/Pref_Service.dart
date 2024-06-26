import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper{
  static String islogin = "islogin";
  static String userid = "userid";
  static SharedPreferences? _prefs;
  static Future<SharedPreferences?> prefLoad() async{
    _prefs??= await SharedPreferences.getInstance();
    return _prefs;
  }
  static void setString(String key, String value) {
    _prefs?.setString(key, value);
  }
  static String? getString(String key, {String? def}) {
    String? val;
    val ??= _prefs?.getString(key);
    val ??= def;
    return val;
  }
  static void setBool(String key,bool value){
    _prefs?.setBool(key, value);
  }
  static bool? getBool(String key, {bool? def}) {
    bool? val;
    val ??= _prefs?.getBool(key);
    val ??= def;
    return val;
  }
}