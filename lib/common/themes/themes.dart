import 'package:flutter/material.dart';
import 'package:luciapp/common/themes/dark_theme.dart';
import 'package:luciapp/common/themes/high_contrast_dark_theme.dart';
import 'package:luciapp/common/themes/high_contrast_light_theme.dart';
import 'package:luciapp/common/themes/light_theme.dart';
import 'package:luciapp/features/themes/domain/enums/theme_mode.dart';

Map<AppThemeMode, ThemeData> themes = {
  AppThemeMode.light: lightTheme,
  AppThemeMode.dark: darkTheme,
  AppThemeMode.hcDark: hcDarkTheme,
  AppThemeMode.hcLight: hcLightTheme,
};
