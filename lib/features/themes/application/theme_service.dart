import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/themes/data/abstract_repositories/theme_repository.dart';
import 'package:luciapp/features/themes/data/repositories/sqlite_theme_repository.dart';
import 'package:luciapp/features/themes/domain/enums/theme_mode.dart';

class ThemeService {
  final IThemeRepository _themeRepository;

  ThemeService({required IThemeRepository themeRepository})
      : _themeRepository = themeRepository;

  Future<AppThemeMode> getCurrentTheme() async {
    final isDarkModeEnabled = await _themeRepository.isDarkModeEnabled();
    final isHCModeEnabled = await _themeRepository.isHCModeEnabled();
    return _fromEnabledValues(isDarkModeEnabled, isHCModeEnabled);
  }

  Future<AppThemeMode> toggleDarkMode() async {
    final isDarkModeEnabled = await _themeRepository.isDarkModeEnabled();
    await _themeRepository.updateDarkMode(!isDarkModeEnabled);
    return getCurrentTheme();
  }

  Future<AppThemeMode> toggleHCMode() async {
    final isHCModeEnabled = await _themeRepository.isHCModeEnabled();
    await _themeRepository.updateHCMode(!isHCModeEnabled);
    return getCurrentTheme();
  }

  AppThemeMode _fromEnabledValues(
      bool isDarkModeEnabled, bool isHCModeEnabled) {
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
}

final themeServiceProvider = Provider<ThemeService>((ref) {
  return ThemeService(themeRepository: SqLiteThemeRepository());
});
