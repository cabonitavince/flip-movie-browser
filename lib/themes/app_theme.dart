import 'package:flutter/material.dart';
import 'package:movie_browser/utils/constants.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppConstants.primaryColor,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    appBarTheme: _appBarTheme,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: _elevatedButtonStyle,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppConstants.primaryColor,
    scaffoldBackgroundColor: AppConstants.secondaryColor,
    appBarTheme: _appBarTheme,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: _elevatedButtonStyle,
    ),
  );

  static final ButtonStyle _elevatedButtonStyle = ButtonStyle(
    iconSize: WidgetStateProperty.all<double>(30),
    backgroundColor: WidgetStateProperty.all(AppConstants.primaryColor),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
    padding: WidgetStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    ),
    textStyle: WidgetStateProperty.all<TextStyle>(
      const TextStyle(
        color: Colors.white,
      ),
    ),
  );

  static final AppBarTheme _appBarTheme = const AppBarTheme(
    backgroundColor: AppConstants.secondaryColor,
    foregroundColor: Colors.white,
  );
}
