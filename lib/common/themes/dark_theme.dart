import 'package:flutter/material.dart';
import 'package:luciapp/common/themes/color_schemes/dark_color_scheme.dart';
import 'package:luciapp/common/themes/color_schemes/light_color_scheme.dart';

final darkTheme = ThemeData(
  fontFamily: 'Nunito',
  colorScheme: darkColorScheme,
  textTheme: const TextTheme(
    displaySmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 32,
      fontFamily: 'Roboto',
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
  scaffoldBackgroundColor: darkColorScheme.background,
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          MaterialStatePropertyAll(Color.fromARGB(255, 207, 207, 207)),
    ),
  ),
  shadowColor: Colors.black.withOpacity(.3),
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: darkColorScheme.surface,
    foregroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Color(0xffA1C4FF)),
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
