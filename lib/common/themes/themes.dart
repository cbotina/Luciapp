import 'package:flutter/material.dart';
import 'package:luciapp/common/themes/dark_theme.dart';
import 'package:luciapp/common/themes/hc_dark_theme.dart';
import 'package:luciapp/common/themes/hc_light_theme.dart';
import 'package:luciapp/common/themes/light_theme.dart';
import 'package:luciapp/features/themes/domain/enums/app_theme_mode.dart';

Map<AppThemeMode, ThemeData> themes = {
  AppThemeMode.light: lightTheme,
  AppThemeMode.dark: darkTheme,
  AppThemeMode.hcDark: hcDarkTheme,
  AppThemeMode.hcLight: hcLightTheme,
};
