import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePref {
  static const THEME_STATUS = 'THEMESTATUS';
  setDarkTheme(bool val) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(THEME_STATUS, val);
  }

  Future<bool> getTheme() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(THEME_STATUS) ?? false;
  }
}