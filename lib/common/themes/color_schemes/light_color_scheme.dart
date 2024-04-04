import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
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
  onPrimaryContainer: Color.fromARGB(255, 97, 97, 97),

  secondaryContainer: Colors.white, // google
  onSecondaryContainer: Color.fromARGB(255, 18, 18, 18),
  tertiaryContainer: Color(0xff486CB4), //facebook
  onTertiaryContainer: Colors.white,

  surfaceTint: null,
  surface: Colors.white,
  onSurface: Color(0xff0e0e0e), // en containers
  background: Color(0xffF2F5FC), // dialog background
  onBackground: Color(0xff0e0e0e),
  surfaceVariant: Color.fromARGB(255, 176, 176, 176),
  outline: Colors.transparent,
  scrim: Colors.transparent,
);
