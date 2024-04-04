import 'package:flutter/material.dart';

const hcLightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color.fromARGB(255, 0, 89, 255),
  onPrimary: Color.fromARGB(255, 255, 255, 255),
  secondary: Color.fromARGB(255, 255, 166, 0), // ribbon
  onSecondary: Color(0xff0e0e0e),
  tertiary: Color.fromARGB(255, 0, 255, 76),
  onTertiary: Color.fromARGB(255, 0, 0, 0),
  error: Color.fromARGB(255, 255, 0, 17),
  onError: Colors.white,
  primaryContainer: Color.fromARGB(255, 255, 255, 255),
  onPrimaryContainer: Color.fromARGB(255, 0, 0, 0),

  secondaryContainer: Colors.white,
  onSecondaryContainer: Colors.black,

  tertiaryContainer: Colors.white,
  onTertiaryContainer: Colors.black, // gris

  surface: Color.fromARGB(255, 255, 255, 255),
  onSurface: Color.fromARGB(255, 0, 0, 0), // en containers
  surfaceTint: Colors.black,
  background: Color.fromARGB(255, 255, 255, 255), // dialog background
  onBackground: Color.fromARGB(255, 0, 0, 0),
  surfaceVariant: Color.fromARGB(255, 0, 0, 0),
  scrim: Colors.black,
);
