import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/data/abstract_repositories/auth_repository.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/themes/data/abstract_repositories/theme_repository.dart';
import 'package:luciapp/features/themes/domain/enums/theme_mode.dart';
import 'package:luciapp/features/themes/domain/models/theme_settings.dart';
import 'package:luciapp/features/themes/presentation/state/theme_state.dart';
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
      return await _themeRepository
          .createUserThemeSettings(ThemeSettings.initial(userId));
    } else {
      return userThemeSettings;
    }
  }

  Future<ThemeState> getCurrentTheme() async {
    final userId = _authRepository.userId;

    if (userId == null) {
      return ThemeState.light();
    }

    final userThemeSettings = await getOrCreateUserThemeSettings(userId);

    final isDarkModeEnabled = userThemeSettings.isDarkModeEnabled;
    final isHCModeEnabled = userThemeSettings.isHCModeEnabled;

    return ThemeState(
      isDarkModeEnabled: isDarkModeEnabled,
      isHCModeEnabled: isHCModeEnabled,
    );
  }

  Future<ThemeState> toggleDarkMode() async {
    final userId = _authRepository.userId;

    if (userId == null) {
      return ThemeState.light();
    }

    final userThemeSettings = await getOrCreateUserThemeSettings(userId);

    final isDarkModeEnabled = userThemeSettings.isDarkModeEnabled;

    final updatedSettings =
        userThemeSettings.copyWithDarkMode(!isDarkModeEnabled);

    await _themeRepository.updateUserThemeSettings(updatedSettings);

    return getCurrentTheme();
  }

  Future<ThemeState> toggleHCMode() async {
    final userId = _authRepository.userId;

    if (userId == null) {
      return ThemeState.light();
    }

    final userThemeSettings = await getOrCreateUserThemeSettings(userId);

    final isHCModeEnabled = userThemeSettings.isHCModeEnabled;

    final updatedSettings = userThemeSettings.copyWithHCMode(!isHCModeEnabled);

    await _themeRepository.updateUserThemeSettings(updatedSettings);

    return getCurrentTheme();
  }
}

final themeServiceProvider = Provider<ThemeService>((ref) {
  return ThemeService(
    themeRepository: ref.watch(themeRepositoryProvider),
    authRepository: ref.watch(authRepositoryProvider),
  );
});
