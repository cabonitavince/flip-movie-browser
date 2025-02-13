import 'package:flutter/material.dart';
import 'package:movie_browser/utils/constants.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppConstants.primaryColor,
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      appBarTheme: _appBarTheme,
      iconTheme: _iconTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: _elevatedButtonStyle,
      ),
      inputDecorationTheme: inputDecorationTheme);

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppConstants.primaryColor,
      scaffoldBackgroundColor: AppConstants.secondaryColor,
      appBarTheme: _appBarTheme,
      iconTheme: _iconTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: _elevatedButtonStyle,
      ),
      inputDecorationTheme: inputDecorationTheme);

  static final IconThemeData _iconTheme =
      const IconThemeData(color: AppConstants.primaryColor, size: 30);

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

  static final AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: AppConstants.secondaryColor,
    foregroundColor: AppConstants.primaryColor,
    iconTheme: _iconTheme,
  );

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.withValues(alpha: 0.1),
    iconColor: Colors.white,
    hoverColor: const Color(0xFFDDDDDD),
    suffixIconColor: AppConstants.primaryColor,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide.none,
    ),
    // Remove error border
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide.none,
    ),
    hintStyle: const TextStyle(color: Colors.white),
    labelStyle: const TextStyle(color: Colors.white),
    prefixStyle: const TextStyle(color: Colors.white),
    suffixStyle: const TextStyle(color: Colors.white),
    errorStyle: const TextStyle(color: Colors.red),
  );
}
