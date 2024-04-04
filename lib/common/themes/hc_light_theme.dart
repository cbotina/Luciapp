import 'package:flutter/material.dart';
import 'package:luciapp/common/themes/color_schemes/hc_light_color_scheme.dart';

final hcLightTheme = ThemeData(
  fontFamily: 'Nunito',
  colorScheme: hcLightColorScheme,
  textTheme: const TextTheme(
    displaySmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 32,
      fontFamily: 'Roboto',
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: const MaterialStatePropertyAll(3),
      overlayColor: const MaterialStatePropertyAll(
        Color.fromARGB(255, 54, 54, 54),
      ),
      backgroundColor: const MaterialStatePropertyAll(
        Color.fromARGB(255, 0, 0, 0),
      ),
      foregroundColor: MaterialStatePropertyAll(
        hcLightColorScheme.onPrimary,
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
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      elevation: const MaterialStatePropertyAll(0),
      backgroundColor: const MaterialStatePropertyAll(
        Color.fromARGB(255, 255, 255, 255),
      ),
      foregroundColor:
          const MaterialStatePropertyAll(Color.fromARGB(255, 0, 0, 0)),
      overlayColor: const MaterialStatePropertyAll(Colors.white),
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
  scaffoldBackgroundColor: hcLightColorScheme.background,
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStatePropertyAll(Colors.black),
    ),
  ),
  shadowColor: Colors.transparent,
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: hcLightColorScheme.surface,
    foregroundColor: Colors.black,
    iconTheme: const IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 3,
    shadowColor: Colors.black,
  ),
  cardTheme: CardTheme(
    elevation: 0,
    shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
);
