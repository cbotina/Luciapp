import 'package:flutter/material.dart';

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color.fromARGB(255, 139, 173, 234),
  onPrimary: Color.fromARGB(255, 0, 0, 0),
  secondary: Color.fromARGB(255, 240, 200, 124), // ribbon
  onSecondary: Color(0xff0e0e0e),
  tertiary: Color.fromARGB(255, 132, 255, 243),
  onTertiary: Colors.black,
  error: Color(0xffe6202d),
  onError: Colors.white,
  primaryContainer: Colors.white,
  onPrimaryContainer: Color.fromARGB(255, 245, 245, 245),

  secondaryContainer: Colors.white, // google
  onSecondaryContainer: Color.fromARGB(255, 18, 18, 18),
  tertiaryContainer: Color(0xff486CB4), //facebook
  onTertiaryContainer: Colors.white,

  surface: Color(0xff26264E),
  onSurface: Color.fromARGB(255, 255, 255, 255), // en containers
  // surfaceTint: Color.fromARGB(255, 255, 255, 255),
  background: Color(0xff141432), // dialog background
  onBackground: Color(0xff0e0e0e),
  surfaceVariant: Color(0xff1D1D42),
  scrim: Colors.transparent,

  outline: Colors.transparent,
);
