import 'package:flutter/material.dart';

class CustomStyles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(

      scaffoldBackgroundColor: isDarkTheme ? const Color(0xff0f4400) : const Color(
          0xFFCAFFEB),
      primaryColor: Colors.greenAccent,
      colorScheme: ColorScheme.fromSeed(
        seedColor:
        isDarkTheme ? const Color(0xff00621a) : const Color(0xFF5CFF86),
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ),
      cardColor: isDarkTheme ? const Color(0xff21692f) : const Color(0xFFF2FDFD),
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
    );
  }
}