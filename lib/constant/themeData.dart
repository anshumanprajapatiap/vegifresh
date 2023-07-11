import 'package:flutter/material.dart';

class CustomStyles {
  static ThemeData themeData(bool isDarkTheme, bool _useMaterial3, BuildContext context) {
    return ThemeData(
      useMaterial3: _useMaterial3,

       scaffoldBackgroundColor: isDarkTheme ? const Color(0xff073300) : const Color(
           0xFFFFFDFB),
      primaryColor: isDarkTheme ? Color(0xf01420d) : Color(0xf059400),
      colorScheme: ColorScheme.fromSeed(
        seedColor:
        isDarkTheme ? const Color(0xff00621a) : const Color(0xFF34864C),
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ),
      // secondaryHeaderColor: isDarkTheme ? const Color(0xffffffff) : const Color(0xFF34864C),
      cardColor: isDarkTheme ? const Color(0xff002107) : const Color(0xFFF4FFF0),
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
    );
  }
}