import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/constants/widget_keys.dart';
import 'package:luciapp/features/auth/application/auth_service.dart';
import 'package:luciapp/features/auth/data/providers/is_logged_in_provider.dart';
import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/font_size/domain/models/user_font_settings.dart';
import 'package:luciapp/features/font_size/presentation/controllers/font_size_controller.dart';
import 'package:luciapp/features/themes/application/theme_service.dart';
import 'package:luciapp/features/themes/domain/enums/app_theme_mode.dart';
import 'package:luciapp/features/themes/presentation/controllers/theme_controller.dart';
import 'package:luciapp/features/themes/presentation/state/theme_state.dart';
import 'package:luciapp/main.dart';
import 'package:mocktail/mocktail.dart';

import '../../auth/mocks/mock_auth_controller.dart';
import '../../auth/mocks/mock_auth_service.dart';
import '../../common/mocks/mock_auth_repository.dart';
import '../../common/robot/testing_robot.dart';
import '../../themes/mocks/mock_theme_service.dart';
import '../../themes/mocks/mock_theme_settings_repository.dart';
import '../mocks/mock_font_settings_repository.dart';
import '../mocks/mock_font_size_service.dart';

void main() {
  late final User testUser;
  late final MockAuthRepository mockAuthRepository;
  late final MockAuthController mockAuthController;
  late final MockAuthService mockAuthService;
  late final MockThemeService mockThemeService;
  late final MockFontSizeService mockFontSizeService;
  late final MockThemeSettingsRepository mockThemeSettingsRepository;

  late bool darkmode;
  late bool hcmode;

  setUpAll(() async {
    mockAuthService = MockAuthService();
    mockThemeService = MockThemeService();
    mockAuthRepository = MockAuthRepository();
    mockFontSizeService = MockFontSizeService();
    mockThemeSettingsRepository = MockThemeSettingsRepository();

    when(() => mockAuthService.login(AuthMethod.facebook)).thenAnswer(
      (_) => Future.value(AuthResult.success),
    );

    // when(() => mockThemeSettingsRepository.get('1234')).thenAnswer(
    //   (invocation) {
    //     return Future.delayed?(UserFontSettings.initial('1234'));
    //   },
    // );

    when(mockThemeService.toggleHCMode).thenAnswer((_) {
      hcmode = !hcmode;
      return Future.value(
          ThemeState(isDarkModeEnabled: darkmode, isHCModeEnabled: hcmode));
    });

    when(mockThemeService.getCurrentThemeState).thenAnswer(
      (_) => Future.value(
        ThemeState(
          isDarkModeEnabled: darkmode,
          isHCModeEnabled: hcmode,
        ),
      ),
    );

    when(() => mockAuthService.getUserId()).thenReturn('1234');
  });

  final overrides = [
    authServiceProvider.overrideWith((ref) => mockAuthService),
    themeServiceProvider.overrideWith((ref) => mockThemeService),
    authRepositoryProvider.overrideWith((ref) => mockAuthRepository),
  ];

  group("IntegrationTest", () {
    testWidgets("First", (WidgetTester tester) async {
      darkmode = false;
      hcmode = true;

      await tester.pumpWidget(
        ProviderScope(
          overrides: overrides,
          child: const MyApp(),
        ),
      );

      final container = ProviderScope.containerOf(
        tester.element(find.byType(MyApp)),
      );

      final robot = TestingRobot(tester: tester);

      await robot.loginWithFacebook();

      await robot.goToAccessibilityPage();

      await container
          .read(fontSizeControllerProvider.notifier)
          .increaseFontSize();

      expect(
        container.read(themeControllerProvider).value!.appThemeMode,
        AppThemeMode.hcDark,
      );

      await container.read(themeControllerProvider.notifier).toggleDarkMode();

      expect(
        container.read(themeControllerProvider).value!.appThemeMode,
        AppThemeMode.hcLight,
      );
    });
  });
}
