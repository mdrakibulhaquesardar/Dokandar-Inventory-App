import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_config.dart';

class AppThemeConfig extends GetxService {
  // Light Theme Colors - These can be customized via AppConfig.themeColors
  Color get primaryColor => Color(AppConfig.themeColors['primary'] as int);
  Color get secondaryColor => Color(AppConfig.themeColors['secondary'] as int);
  Color get accentColor => Color(AppConfig.themeColors['secondary'] as int);
  Color get backgroundColor =>
      Color(AppConfig.themeColors['background'] as int);
  Color get surfaceColor => Color(AppConfig.themeColors['surface'] as int);
  Color get errorColor => Color(AppConfig.themeColors['error'] as int);
  Color get successColor => const Color(0xFF4CAF50);
  Color get warningColor => const Color(0xFFFFC107);
  Color get infoColor => Color(AppConfig.themeColors['primary'] as int);

  // Dark Theme Colors
  static const Color darkPrimaryColor = Color(0xFF1565C0);
  static const Color darkSecondaryColor = Color(0xFF0288D1);
  static const Color darkAccentColor = Color(0xFF0097A7);
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkSurfaceColor = Color(0xFF1E1E1E);
  static const Color darkErrorColor = Color(0xFFCF6679);
  static const Color darkSuccessColor = Color(0xFF81C784);
  static const Color darkWarningColor = Color(0xFFFFD54F);
  static const Color darkInfoColor = Color(0xFF64B5F6);

  // Text Colors
  static const Color textPrimaryColor = Color(0xFF212121);
  static const Color textSecondaryColor = Color(0xFF757575);
  static const Color darkTextPrimaryColor = Color(0xFFE0E0E0);
  static const Color darkTextSecondaryColor = Color(0xFFB0B0B0);

  // Border Colors
  static const Color borderColor = Color(0xFFE0E0E0);
  static const Color darkBorderColor = Color(0xFF424242);

  // Get current theme colors based on theme mode
  Color getPrimaryColor(bool isDarkMode) =>
      isDarkMode ? darkPrimaryColor : primaryColor;
  Color getSecondaryColor(bool isDarkMode) =>
      isDarkMode ? darkSecondaryColor : secondaryColor;
  Color getAccentColor(bool isDarkMode) =>
      isDarkMode ? darkAccentColor : accentColor;
  Color getBackgroundColor(bool isDarkMode) =>
      isDarkMode ? darkBackgroundColor : backgroundColor;
  Color getSurfaceColor(bool isDarkMode) =>
      isDarkMode ? darkSurfaceColor : surfaceColor;
  Color getErrorColor(bool isDarkMode) =>
      isDarkMode ? darkErrorColor : errorColor;
  Color getSuccessColor(bool isDarkMode) =>
      isDarkMode ? darkSuccessColor : successColor;
  Color getWarningColor(bool isDarkMode) =>
      isDarkMode ? darkWarningColor : warningColor;
  Color getInfoColor(bool isDarkMode) => isDarkMode ? darkInfoColor : infoColor;
  Color getTextPrimaryColor(bool isDarkMode) =>
      isDarkMode ? darkTextPrimaryColor : textPrimaryColor;
  Color getTextSecondaryColor(bool isDarkMode) =>
      isDarkMode ? darkTextSecondaryColor : textSecondaryColor;
  Color getBorderColor(bool isDarkMode) =>
      isDarkMode ? darkBorderColor : borderColor;

  // Get theme data
  ThemeData getLightTheme() {
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
        onPrimary: Color(AppConfig.themeColors['onPrimary'] as int),
        onSecondary: Color(AppConfig.themeColors['onSecondary'] as int),
        onSurface: Color(AppConfig.themeColors['onSurface'] as int),
        onError: Color(AppConfig.themeColors['onError'] as int),
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        // Use the surface color defined in AppConfig, which is now
        // slightly different from background, so cards are visible
        // in light mode similar to dark mode.
        color: surfaceColor,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            color: borderColor,
            width: 0.6,
          ),
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textPrimaryColor),
        bodyMedium: TextStyle(color: textSecondaryColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
    );
  }

  ThemeData getDarkTheme() {
    return ThemeData(
      primaryColor: darkPrimaryColor,
      colorScheme: ColorScheme.dark(
        primary: darkPrimaryColor,
        secondary: darkSecondaryColor,
        surface: darkSurfaceColor,
        error: darkErrorColor,
      ),
      scaffoldBackgroundColor: darkBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: darkPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: darkSurfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: darkTextPrimaryColor),
        bodyMedium: TextStyle(color: darkTextSecondaryColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkPrimaryColor),
        ),
      ),
    );
  }
}
