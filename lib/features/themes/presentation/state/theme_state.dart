import 'package:luciapp/features/themes/domain/enums/theme_mode.dart';

class ThemeState {
  final AppThemeMode themeMode;

  ThemeState({
    required this.themeMode,
  });

  ThemeState.light() : themeMode = AppThemeMode.light;

  ThemeState copyWithIsLoading(bool isLoading) =>
      ThemeState(themeMode: themeMode);

  @override
  bool operator ==(covariant ThemeState other) =>
      identical(this, other) || (themeMode == other.themeMode);

  @override
  int get hashCode => Object.hash(themeMode, null);
}
