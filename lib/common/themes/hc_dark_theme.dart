import 'package:flutter/material.dart';
import 'package:luciapp/common/themes/color_schemes/hc_dark_color_scheme.dart';
import 'package:luciapp/common/themes/color_schemes/light_color_scheme.dart';

final hcDarkTheme = ThemeData(
  fontFamily: 'Nunito',
  colorScheme: hcDarkColorScheme,
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
        Colors.blueAccent,
      ),
      backgroundColor: MaterialStatePropertyAll(
        lightColorScheme.primary,
      ),
      foregroundColor: MaterialStatePropertyAll(
        lightColorScheme.onPrimary,
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
      backgroundColor: MaterialStatePropertyAll(
        Colors.blue.shade100,
      ),
      foregroundColor: MaterialStatePropertyAll(lightColorScheme.primary),
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
  scaffoldBackgroundColor: hcDarkColorScheme.background,
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          MaterialStatePropertyAll(Color.fromARGB(255, 207, 207, 207)),
    ),
  ),
  shadowColor: Colors.black.withOpacity(.3),
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: hcDarkColorScheme.surface,
    foregroundColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white),
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
    surfaceTintColor: hcDarkColorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
);
