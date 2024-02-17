import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/application/auth_service.dart';
import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/font_size/domain/models/user_font_settings.dart';
import 'package:luciapp/features/font_size/presentation/controllers/font_size_controller.dart';
import 'package:luciapp/features/themes/application/theme_service.dart';
import 'package:luciapp/features/themes/presentation/state/theme_state.dart';
import 'package:luciapp/main.dart';
import 'package:mocktail/mocktail.dart';

import '../test/auth/mocks/mock_auth_service.dart';
import '../test/common/mocks/mock_auth_repository.dart';
import '../test/common/robot/testing_robot.dart';
import '../test/font_size/constants/strings.dart';
import '../test/font_size/mocks/mock_font_settings_repository.dart';
import '../test/themes/mocks/mock_theme_service.dart';

void main() {
  late final MockAuthRepository mockAuthRepository;
  late final MockAuthService mockAuthService;
  late final MockThemeService mockThemeService;

  late final MockFontSettingsRepository mockFontSettingsRepository;

  setUpAll(() async {
    mockAuthService = MockAuthService();
    mockThemeService = MockThemeService();
    mockAuthRepository = MockAuthRepository();
    mockFontSettingsRepository = MockFontSettingsRepository();
    registerFallbackValue(UserFontSettings.initial('1234'));

    when(() => mockAuthService.login(AuthMethod.facebook)).thenAnswer(
      (_) => Future.value(AuthResult.success),
    );

    when(mockThemeService.getCurrentThemeState).thenAnswer(
      (_) => Future.value(const ThemeState.light()),
    );

    when(() => mockAuthService.getUserId()).thenReturn('1234');

    when(() => mockAuthRepository.userId).thenAnswer((_) => '1234');

    when(() => mockFontSettingsRepository.update(any()))
        .thenAnswer((invocation) => Future.value(true));
  });

  final overrides = [
    authServiceProvider.overrideWith((ref) => mockAuthService),
    themeServiceProvider.overrideWith((ref) => mockThemeService),
    authRepositoryProvider.overrideWith((ref) => mockAuthRepository),
    fontSettingsRepositoryProvider
        .overrideWith((ref) => mockFontSettingsRepository),
  ];

  group(TestNames.integrationTest, () {
    testWidgets(TestNames.cp060, (WidgetTester tester) async {
      when(() => mockFontSettingsRepository.get('1234')).thenAnswer((_) =>
          Future.value(UserFontSettings(scaleFactor: 1, userId: '1234')));
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
        container.read(fontSizeControllerProvider).value!.scaleFactor,
        1.1,
      );
    });

    testWidgets(TestNames.cp061, (WidgetTester tester) async {
      when(() => mockFontSettingsRepository.get('1234')).thenAnswer((_) =>
          Future.value(UserFontSettings(scaleFactor: 2, userId: '1234')));
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
        container.read(fontSizeControllerProvider).value!.scaleFactor,
        2,
      );
    });
    testWidgets(TestNames.cp062, (WidgetTester tester) async {
      when(() => mockFontSettingsRepository.get('1234')).thenAnswer((_) =>
          Future.value(UserFontSettings(scaleFactor: 1, userId: '1234')));
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
          .decreaseFontSize();

      expect(
        container.read(fontSizeControllerProvider).value!.scaleFactor,
        0.9,
      );
    });
    testWidgets(TestNames.cp063, (WidgetTester tester) async {
      when(() => mockFontSettingsRepository.get('1234')).thenAnswer((_) =>
          Future.value(UserFontSettings(scaleFactor: 0.8, userId: '1234')));
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
          .decreaseFontSize();

      expect(
        container.read(fontSizeControllerProvider).value!.scaleFactor,
        0.8,
      );
    });
  });
}
