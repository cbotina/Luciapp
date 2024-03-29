import 'package:flutter/material.dart';
import 'package:luciapp/common/themes/color_schemes/light_color_scheme.dart';

const displaySmallSize = 32.0;
const bodyMediumSize = 14.0;

final lightTheme = ThemeData(
  fontFamily: 'Nunito',
  colorScheme: lightColorScheme,
  textTheme: const TextTheme(
    // bodyMedium: TextStyle(
    //   fontSize: bodyMediumSize,
    //   height: bodyMediumSize * 1.5,
    //   letterSpacing: bodyMediumSize * 0.12,
    //   wordSpacing: bodyMediumSize * 0.16,
    // ),

    /// otros tipos de texto ...
    ///
    displaySmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: displaySmallSize,
      fontFamily: 'Roboto',
      // height: displaySmallSize * 1.5,
      // letterSpacing: displaySmallSize * 0.12,
      // wordSpacing: displaySmallSize * 0.16,
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
  scaffoldBackgroundColor: lightColorScheme.background,
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
