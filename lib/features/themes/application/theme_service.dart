import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/data/abstract_repositories/auth_repository.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/themes/data/abstract_repositories/theme_repository.dart';
import 'package:luciapp/features/themes/domain/enums/theme_mode.dart';
import 'package:luciapp/features/themes/domain/models/theme_settings.dart';
import 'package:luciapp/main.dart';

class ThemeService {
  final IThemeRepository _themeRepository;
  final IAuthRepository _authRepository;

  ThemeService(
      {required IThemeRepository themeRepository,
      required IAuthRepository authRepository})
      : _themeRepository = themeRepository,
        _authRepository = authRepository;

  Future<ThemeSettings> getOrCreateUserThemeSettings(UserId userId) async {
    final userThemeSettings =
        await _themeRepository.getUserThemeSettings(userId);

    if (userThemeSettings == null) {
      return await _themeRepository.createUserThemeSettings(
        userId,
        ThemeSettings.initial(userId),
      );
    } else {
      return userThemeSettings;
    }
  }

  Future<AppThemeMode> getCurrentTheme() async {
    final userId = _authRepository.userId;

    if (userId == null) {
      return _fromEnabledValues(false, false);
    }

    final userThemeSettings = await getOrCreateUserThemeSettings(userId);

    final isDarkModeEnabled = userThemeSettings.isDarkModeEnabled;
    final isHCModeEnabled = userThemeSettings.isHCModeEnabled;

    return _fromEnabledValues(isDarkModeEnabled, isHCModeEnabled);
  }

  Future<AppThemeMode> toggleDarkMode() async {
    final userId = _authRepository.userId;

    if (userId == null) {
      return _fromEnabledValues(false, false);
    }

    final userThemeSettings = await getOrCreateUserThemeSettings(userId);

    final isDarkModeEnabled = userThemeSettings.isDarkModeEnabled;

    final updatedSettings =
        userThemeSettings.copyWithDarkMode(!isDarkModeEnabled);

    await _themeRepository.updateUserThemeSettings(userId, updatedSettings);

    return getCurrentTheme();
  }

  Future<AppThemeMode> toggleHCMode() async {
    final userId = _authRepository.userId;

    if (userId == null) {
      return _fromEnabledValues(false, false);
    }

    final userThemeSettings = await getOrCreateUserThemeSettings(userId);

    final isHCModeEnabled = userThemeSettings.isHCModeEnabled;

    final updatedSettings =
        userThemeSettings.copyWithDarkMode(!isHCModeEnabled);

    await _themeRepository.updateUserThemeSettings(userId, updatedSettings);

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
  return ThemeService(
    themeRepository: ref.watch(themeRepositoryProvider),
    authRepository: ref.watch(authRepositoryProvider),
  );
});
