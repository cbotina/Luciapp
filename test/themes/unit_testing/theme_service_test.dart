import 'package:flutter_test/flutter_test.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/themes/application/theme_service.dart';
import 'package:luciapp/features/themes/domain/models/user_theme_settings.dart';
import 'package:luciapp/features/themes/presentation/state/theme_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../common/mocks/mock_auth_repository.dart';
import '../mocks/mock_theme_settings_repository.dart';

void main() {
  late MockThemeSettingsRepository mockThemeSettingsRepository;
  late MockAuthRepository mockAuthRepository;
  late User user;
  late UserThemeSettings existingUserThemeSettings;

  setUp(() {
    mockThemeSettingsRepository = MockThemeSettingsRepository();
    mockAuthRepository = MockAuthRepository();
    user = User(
      userId: '1234',
      name: 'Bob',
      age: 21,
      gender: Gender.male,
    );

    existingUserThemeSettings = UserThemeSettings(
      isDarkModeEnabled: true,
      isHCModeEnabled: true,
      userId: user.userId,
    );
  });

  group("ThemeService", () {
    test("Get existing theme settings", () async {
      when(() => mockThemeSettingsRepository.get(user.userId)).thenAnswer(
        (invocation) => Future.value(existingUserThemeSettings),
      );

      final service = ThemeService(
        themeSettingsRepository: mockThemeSettingsRepository,
        authRepository: mockAuthRepository,
      );

      final result = await service.getOrCreateUserThemeSettings(user.userId);

      expect(result, existingUserThemeSettings);
    });

    test("Theme settings doesn't exist", () async {
      when(() => mockThemeSettingsRepository.get(user.userId)).thenAnswer(
        (invocation) => Future.value(null),
      );

      final defaultSettings = UserThemeSettings.initial(user.userId);

      when(() => mockThemeSettingsRepository.create(defaultSettings))
          .thenAnswer((invocation) => Future.value(defaultSettings));

      final service = ThemeService(
        themeSettingsRepository: mockThemeSettingsRepository,
        authRepository: mockAuthRepository,
      );

      final result = await service.getOrCreateUserThemeSettings(user.userId);

      expect(result, defaultSettings);
    });

    test("Get Current Theme state when user is not authenticated", () async {
      when(() => mockAuthRepository.userId).thenAnswer(
        (invocation) => null,
      );

      final service = ThemeService(
        themeSettingsRepository: mockThemeSettingsRepository,
        authRepository: mockAuthRepository,
      );

      final result = await service.getCurrentThemeState();

      expect(result, ThemeState.light());
    });

    test("Get Current Theme state when user is  authenticated", () async {
      when(() => mockAuthRepository.userId).thenAnswer(
        (invocation) => user.userId,
      );

      when(() => mockThemeSettingsRepository.get(user.userId)).thenAnswer(
        (invocation) => Future.value(existingUserThemeSettings),
      );

      final service = ThemeService(
        themeSettingsRepository: mockThemeSettingsRepository,
        authRepository: mockAuthRepository,
      );

      final result = await service.getCurrentThemeState();

      expect(
        result,
        ThemeState.fromUserThemeSettings(existingUserThemeSettings),
      );
    });

    test("Toggle Dark Mode", () async {
      final updatedSettings = existingUserThemeSettings
          .copyWithDarkMode(!existingUserThemeSettings.isDarkModeEnabled);

      final answers = [
        (_) => Future.value(existingUserThemeSettings),
        (_) => Future.value(updatedSettings),
      ];

      when(() => mockAuthRepository.userId).thenAnswer(
        (invocation) => user.userId,
      );

      when(() => mockThemeSettingsRepository.get(user.userId)).thenAnswer(
        (invocation) => answers.removeAt(0)(invocation),
      );

      when(() => mockThemeSettingsRepository.update(updatedSettings))
          .thenAnswer(
        (invocation) => Future.value(true),
      );

      final service = ThemeService(
        themeSettingsRepository: mockThemeSettingsRepository,
        authRepository: mockAuthRepository,
      );

      final result = await service.toggleDarkMode();

      expect(result, ThemeState.fromUserThemeSettings(updatedSettings));
    });

    test("Toggle HC Mode", () async {
      final updatedSettings = existingUserThemeSettings
          .copyWithHCMode(!existingUserThemeSettings.isHCModeEnabled);

      final answers = [
        (_) => Future.value(existingUserThemeSettings),
        (_) => Future.value(updatedSettings),
      ];

      when(() => mockAuthRepository.userId).thenAnswer(
        (invocation) => user.userId,
      );

      when(() => mockThemeSettingsRepository.get(user.userId)).thenAnswer(
        (invocation) => answers.removeAt(0)(invocation),
      );

      when(() => mockThemeSettingsRepository.update(updatedSettings))
          .thenAnswer(
        (invocation) => Future.value(true),
      );

      final service = ThemeService(
        themeSettingsRepository: mockThemeSettingsRepository,
        authRepository: mockAuthRepository,
      );

      final result = await service.toggleHCMode();

      expect(result, ThemeState.fromUserThemeSettings(updatedSettings));
    });
  });
}
