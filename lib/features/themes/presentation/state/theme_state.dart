import 'package:luciapp/features/themes/domain/enums/app_theme_mode.dart';

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

  ThemeState({
    required this.isDarkModeEnabled,
    required this.isHCModeEnabled,
  });

  ThemeState.light()
      : isDarkModeEnabled = false,
        isHCModeEnabled = false;

  @override
  bool operator ==(covariant ThemeState other) =>
      identical(this, other) ||
      (isDarkModeEnabled == other.isDarkModeEnabled &&
          isHCModeEnabled == other.isHCModeEnabled);

  @override
  int get hashCode => Object.hash(isDarkModeEnabled, isHCModeEnabled);
}
