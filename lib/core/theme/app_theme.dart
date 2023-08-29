import 'package:flutter/material.dart';

import 'package:sw_finder/core/config/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      hintColor: Colors.black,
      navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: backgroundColor2,
        backgroundColor: backgroundColor,
      ));

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    hintColor: Colors.white,
  );
}
