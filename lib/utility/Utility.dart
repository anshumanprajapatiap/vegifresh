import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/darkThemeProvider.dart';

class Utility {
  BuildContext context;
  Utility(this.context);
  bool get getTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;
  Color get color => getTheme ? Colors.white : Colors.black;
  Size get getScreenSize => MediaQuery.of(context).size;
}