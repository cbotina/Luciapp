import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/data/abstract_repositories/auth_repository.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/themes/data/abstract_repositories/theme_settings_repository.dart';
import 'package:luciapp/features/themes/domain/models/user_theme_settings.dart';
import 'package:luciapp/features/themes/presentation/state/theme_state.dart';
import 'package:luciapp/main.dart';

class ThemeService {
  final IThemeSettingsReposiroty _themeSettingsRepository;
  final IAuthRepository _authRepository;

  ThemeService({
    required IThemeSettingsReposiroty themeSettingsRepository,
    required IAuthRepository authRepository,
  })  : _themeSettingsRepository = themeSettingsRepository,
        _authRepository = authRepository;

  Future<ThemeState> getCurrentThemeState() async {
    final userId = _authRepository.userId;

    if (userId == null) {
      return const ThemeState.light();
    }

    final userThemeSettings = await getOrCreateUserThemeSettings(userId);

    return ThemeState.fromUserThemeSettings(userThemeSettings);
  }

  Future<ThemeState> toggleDarkMode() async {
    final userId = _authRepository.userId;

    if (userId == null) {
      return const ThemeState.light();
    }

    final userThemeSettings = await getOrCreateUserThemeSettings(userId);

    final isDarkModeEnabled = userThemeSettings.isDarkModeEnabled;

    final updatedSettings =
        userThemeSettings.copyWithDarkMode(!isDarkModeEnabled);

    await _themeSettingsRepository.update(updatedSettings);

    return getCurrentThemeState();
  }

  Future<ThemeState> toggleHCMode() async {
    final userId = _authRepository.userId;

    if (userId == null) {
      return const ThemeState.light();
    }

    final userThemeSettings = await getOrCreateUserThemeSettings(userId);

    final isHCModeEnabled = userThemeSettings.isHCModeEnabled;

    final updatedSettings = userThemeSettings.copyWithHCMode(!isHCModeEnabled);

    await _themeSettingsRepository.update(updatedSettings);

    return getCurrentThemeState();
  }

  Future<UserThemeSettings> getOrCreateUserThemeSettings(UserId userId) async {
    final userThemeSettings = await _themeSettingsRepository.get(userId);

    if (userThemeSettings == null) {
      return await _themeSettingsRepository
          .create(UserThemeSettings.initial(userId));
    } else {
      return userThemeSettings;
    }
  }
}

final themeServiceProvider = Provider<ThemeService>((ref) {
  return ThemeService(
    themeSettingsRepository: ref.watch(themeRepositoryProvider),
    authRepository: ref.watch(authRepositoryProvider),
  );
});
