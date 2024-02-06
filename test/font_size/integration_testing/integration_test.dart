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
import '../../auth/mocks/mock_auth_service.dart';
import '../../common/mocks/mock_auth_repository.dart';
import '../../common/robot/testing_robot.dart';
import '../../themes/mocks/mock_theme_service.dart';
import '../mocks/mock_font_settings_repository.dart';

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

    when(() => mockFontSettingsRepository.get('1234')).thenAnswer(
        (_) => Future.value(UserFontSettings(scaleFactor: 1, userId: '1234')));

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

  group("IntegrationTest", () {
    testWidgets("First", (WidgetTester tester) async {
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
  });
}
