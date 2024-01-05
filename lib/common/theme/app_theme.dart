import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    fontFamily: 'Nunito',
    colorScheme: ColorScheme(
      brightness: Brightness.light,

      primary: const Color(0xff4074cf),
      onPrimary: Colors.white,

      secondary: const Color(0xffffac0e), // ribbon
      onSecondary: const Color(0xff0e0e0e),

      tertiary: Colors.teal,
      onTertiary: Colors.white,

      error: const Color(0xffe6202d),
      onError: Colors.white,

      primaryContainer: Colors.white,
      onPrimaryContainer: const Color(0xff0e0e0e),

      surface: Colors.white,
      onSurface: const Color(0xff0e0e0e),

      background: Colors.white, // dialog background
      onBackground: const Color(0xff0e0e0e),

      surfaceVariant: Colors.grey.shade300,
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStatePropertyAll(3),
      ),
    ),
    scaffoldBackgroundColor: const Color(0xffF2F5FC),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.grey.shade700),
      ),
    ),
    shadowColor: Colors.black.withOpacity(.3),
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.white,
      foregroundColor: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.grey[600],
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      shadowColor: Colors.black,
    ),
    cardTheme: const CardTheme(
      elevation: 13,
      shadowColor: Colors.black,
    ),
  );
}
