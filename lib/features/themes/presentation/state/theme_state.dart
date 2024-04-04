import 'package:flutter/foundation.dart' show immutable;
import 'package:luciapp/features/themes/domain/enums/app_theme_mode.dart';
import 'package:luciapp/features/themes/domain/models/user_theme_settings.dart';

@immutable
class ThemeState {
  final bool isDarkModeEnabled;
  final bool isHCModeEnabled;

  AppThemeMode get appThemeMode {
    if (isDarkModeEnabled && isHCModeEnabled) {
      return AppThemeMode.hcDark;
    } else if (isDarkModeEnabled && !isHCModeEnabled) {
      return AppThemeMode.dark;
    } else if (!isDarkModeEnabled && isHCModeEnabled) {
      return AppThemeMode.hcLight;
    } else {
      return AppThemeMode.light;
    }
  }

  const ThemeState({
    required this.isDarkModeEnabled,
    required this.isHCModeEnabled,
  });

  const ThemeState.light()
      : isDarkModeEnabled = false,
        isHCModeEnabled = false;

  ThemeState copyWithIsDarkModeEnabled(bool isDarkModeEnabled) => ThemeState(
        isDarkModeEnabled: isDarkModeEnabled,
        isHCModeEnabled: isHCModeEnabled,
      );

  ThemeState copyWithIsHCModeEnabled(bool isHCModeEnabled) => ThemeState(
        isDarkModeEnabled: isDarkModeEnabled,
        isHCModeEnabled: isHCModeEnabled,
      );

  ThemeState.fromUserThemeSettings(UserThemeSettings userThemeSettings)
      : isDarkModeEnabled = userThemeSettings.isDarkModeEnabled,
        isHCModeEnabled = userThemeSettings.isHCModeEnabled;

  @override
  bool operator ==(Object other) =>
      other is ThemeState &&
      isDarkModeEnabled == other.isDarkModeEnabled &&
      isHCModeEnabled == other.isHCModeEnabled;

  @override
  int get hashCode => Object.hash(isDarkModeEnabled, isHCModeEnabled);
}
