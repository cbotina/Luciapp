import 'package:flutter/material.dart';

const _lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  primary: Color(0xff4074cf),
  onPrimary: Colors.white,

  secondary: Color(0xffffac0e), // ribbon
  onSecondary: Color(0xff0e0e0e),

  tertiary: Colors.teal,
  onTertiary: Colors.white,

  error: Color(0xffe6202d),
  onError: Colors.white,

  primaryContainer: Colors.white,
  onPrimaryContainer: Color(0xff0e0e0e),

  surface: Colors.white,
  onSurface: Color(0xff0e0e0e),

  background: Colors.white, // dialog background
  onBackground: Color(0xff0e0e0e),

  surfaceVariant: Color.fromARGB(255, 224, 224, 224),
);

class AppTheme {
  static final lightTheme = ThemeData(
    fontFamily: 'Nunito',
    colorScheme: _lightColorScheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(3),
        overlayColor: const MaterialStatePropertyAll(
          Colors.blueAccent,
        ),
        backgroundColor: MaterialStatePropertyAll(
          _lightColorScheme.primary,
        ),
        foregroundColor: MaterialStatePropertyAll(
          _lightColorScheme.onPrimary,
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
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
    cardTheme: CardTheme(
      elevation: 13,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
