import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/application/auth_service.dart';
import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/themes/application/theme_service.dart';
import 'package:luciapp/features/themes/domain/enums/app_theme_mode.dart';
import 'package:luciapp/features/themes/presentation/controllers/theme_controller.dart';
import 'package:luciapp/features/themes/presentation/state/theme_state.dart';
import 'package:luciapp/main.dart';
import 'package:mocktail/mocktail.dart';
import '../../common/robot/testing_robot.dart';
import '../../auth/mocks/mock_auth_service.dart';
import '../../common/mocks/mock_auth_repository.dart';
import '../constants/strings.dart';
import '../unit_testing/theme_controller_test.dart';

void main() {
  late MockAuthService mockAuthService;
  late MockThemeService mockThemeService;
  late MockAuthRepository mockAuthRepository;
  late bool darkmode;
  late bool hcmode;

  setUpAll(() {
    mockAuthService = MockAuthService();
    mockThemeService = MockThemeService();
    mockAuthRepository = MockAuthRepository();

    when(() => mockAuthService.login(AuthMethod.facebook)).thenAnswer(
      (_) => Future.value(AuthResult.success),
    );

    when(mockThemeService.toggleDarkMode).thenAnswer((_) {
      darkmode = !darkmode;
      return Future.value(
          ThemeState(isDarkModeEnabled: darkmode, isHCModeEnabled: hcmode));
    });

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

  group(TestNames.integrationTest, () {
    testWidgets(TestNames.cp041, (tester) async {
      darkmode = false;
      hcmode = false;

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

      await container.read(themeControllerProvider.notifier).toggleDarkMode();

      expect(
        container.read(themeControllerProvider).value!.appThemeMode,
        AppThemeMode.dark,
      );

      await tester.pump(const Duration(milliseconds: 100));

      await container.read(themeControllerProvider.notifier).toggleDarkMode();

      expect(
        container.read(themeControllerProvider).value!.appThemeMode,
        AppThemeMode.light,
      );
      await tester.pump(const Duration(milliseconds: 100));
    });

    testWidgets(TestNames.cp042, (tester) async {
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

      await container.read(themeControllerProvider.notifier).toggleDarkMode();

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

    testWidgets(TestNames.cp043, (tester) async {
      darkmode = false;
      hcmode = false;

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

      await container.read(themeControllerProvider.notifier).toggleHCMode();

      expect(
        container.read(themeControllerProvider).value!.appThemeMode,
        AppThemeMode.hcLight,
      );

      await container.read(themeControllerProvider.notifier).toggleHCMode();

      expect(
        container.read(themeControllerProvider).value!.appThemeMode,
        AppThemeMode.light,
      );
    });

    testWidgets(TestNames.cp044, (tester) async {
      darkmode = true;
      hcmode = false;

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

      await container.read(themeControllerProvider.notifier).toggleHCMode();

      expect(
        container.read(themeControllerProvider).value!.appThemeMode,
        AppThemeMode.hcDark,
      );

      await container.read(themeControllerProvider.notifier).toggleHCMode();

      expect(
        container.read(themeControllerProvider).value!.appThemeMode,
        AppThemeMode.dark,
      );
    });
  });
}
