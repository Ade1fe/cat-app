import 'package:flutter/material.dart';

class ThemeClass {
  static Color lightPrimaryColor = _hexToColor('#f1f1f1');
  static Color darkPrimaryColor = _hexToColor('#480032');
  static Color secondPrimary = _hexToColor('#FF8B6A');
  static Color bgTxtFieldLight = _hexToColor('#ddd');
  static Color bgTxtFieldDark = _hexToColor('#000');
  static Color bgColorDark = _hexToColor('#000');
  static Color bgColorLight = _hexToColor('#f1f1f1');
  static Color mainColor = _hexToColor('#303F9F');

  static ThemeData lightTheme = ThemeData(
    primaryColor: lightPrimaryColor,
    scaffoldBackgroundColor: bgColorLight,
    iconTheme: const IconThemeData(color: Colors.black87),
    colorScheme: const ColorScheme.light().copyWith(
      primary: lightPrimaryColor,
      secondary: secondPrimary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: bgTxtFieldLight,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: darkPrimaryColor,
    scaffoldBackgroundColor: bgColorDark,
    iconTheme: const IconThemeData(color: Colors.white70),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: darkPrimaryColor,
      secondary: secondPrimary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: bgTxtFieldDark,
    ),
  );

  static Color _hexToColor(String hex) {
    final hexCode = hex.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
