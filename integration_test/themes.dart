import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/attributions/data/providers/about_text_provider.dart';
import 'package:luciapp/features/auth/application/auth_service.dart';
import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/courses/data/providers/courses_provider.dart';
import 'package:luciapp/features/courses/data/providers/courses_with_percentages_provider.dart';
import 'package:luciapp/features/themes/application/theme_service.dart';
import 'package:luciapp/features/themes/domain/enums/app_theme_mode.dart';
import 'package:luciapp/features/themes/presentation/controllers/theme_controller.dart';
import 'package:luciapp/features/themes/presentation/state/theme_state.dart';
import 'package:luciapp/main.dart';
import 'package:mocktail/mocktail.dart';
import '../test/common/robot/testing_robot.dart';
import '../test/auth/mocks/mock_auth_service.dart';
import '../test/common/mocks/mock_auth_repository.dart';
import '../test/themes/constants/strings.dart';
import '../test/themes/mocks/mock_theme_service.dart';

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

    when(() => mockAuthService.login(AuthMethod.google)).thenAnswer(
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
    coursesProvider.overrideWith((ref) => []),
    aboutTextProvider.overrideWith((ref) => ''),
    coursesWithPercentagesProvider.overrideWith((ref) => [])
  ];

  group(TestNames.integrationTest, () {
    testWidgets(TestNames.cp041, (tester) async {
      darkmode = false;
      hcmode = true;

      final SemanticsHandle handle = tester.ensureSemantics();

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

      await robot.login();

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

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      handle.dispose();
    });

    testWidgets(TestNames.cp042, (tester) async {
      darkmode = false;
      hcmode = false;

      final SemanticsHandle handle = tester.ensureSemantics();

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

      await robot.login();

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

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      handle.dispose();
    });

    testWidgets(TestNames.cp043, (tester) async {
      darkmode = false;
      hcmode = false;

      final SemanticsHandle handle = tester.ensureSemantics();

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

      await robot.login();

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

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      handle.dispose();
    });

    testWidgets(TestNames.cp044, (tester) async {
      darkmode = true;
      hcmode = false;

      final SemanticsHandle handle = tester.ensureSemantics();

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

      await robot.login();

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

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      handle.dispose();
    });
  });
}
