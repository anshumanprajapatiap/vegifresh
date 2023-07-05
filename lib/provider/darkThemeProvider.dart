import 'package:flutter/cupertino.dart';
import 'package:vegifresh/provider/darkThemePref.dart';

class DarkThemeProvider with ChangeNotifier{
  DarkThemePref darkThemePref = DarkThemePref();
  bool _darkTheme = false;
  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool val){
    _darkTheme = val;
    darkThemePref.setDarkTheme(val);
    notifyListeners();
  }
}