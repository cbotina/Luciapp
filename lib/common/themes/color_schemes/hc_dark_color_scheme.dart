import 'package:flutter/material.dart';

const hcDarkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.cyanAccent,
  onPrimary: Color.fromARGB(255, 0, 0, 0),
  secondary: Color.fromARGB(255, 255, 169, 9), // ribbon
  onSecondary: Color(0xff0e0e0e),
  tertiary: Color.fromARGB(255, 0, 255, 42),
  onTertiary: Colors.black,
  error: Color(0xffe6202d),
  onError: Colors.white,
  primaryContainer: Colors.white,
  onPrimaryContainer: Color.fromARGB(255, 222, 222, 222),

  secondaryContainer: Colors.black,
  onSecondaryContainer: Colors.white,

  tertiaryContainer: Colors.black,
  onTertiaryContainer: Colors.white,

  surface: Color.fromARGB(255, 0, 0, 0),
  onSurface: Color.fromARGB(255, 255, 255, 255), // en containers
  surfaceTint: Colors.white, // icons png

  background: Color.fromARGB(255, 0, 0, 0), // dialog background
  onBackground: Color.fromARGB(255, 255, 255, 255),
  surfaceVariant: Color.fromARGB(255, 255, 255, 255),
  scrim: Colors.white,

  outline: Colors.white,
);
