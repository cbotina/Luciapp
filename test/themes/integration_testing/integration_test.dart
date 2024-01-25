import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/constants/widget_keys.dart';
import 'package:luciapp/features/auth/application/auth_service.dart';
import 'package:luciapp/features/auth/data/providers/is_logged_in_provider.dart';
import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/themes/application/theme_service.dart';
import 'package:luciapp/features/themes/presentation/controllers/theme_controller.dart';
import 'package:luciapp/features/themes/presentation/state/theme_state.dart';
import 'package:luciapp/features/themes/presentation/widgets/constants/widget_keys.dart'
    as themes;
import 'package:luciapp/main.dart';
import 'package:mocktail/mocktail.dart';
import '../../auth/integration_testing/robot/auth_robot.dart';
import '../../auth/mocks/mock_auth_service.dart';
import '../../common/mocks/mock_auth_repository.dart';
import '../unit_testing/theme_controller_test.dart';

void main() {
  late MockAuthService mockAuthService;
  late MockThemeService mockThemeService;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthService = MockAuthService();
    mockThemeService = MockThemeService();
    mockAuthRepository = MockAuthRepository();
  });

  group("TestNames.integrationTest", () {
    testWidgets('Toggle DarkMode', (tester) async {
      var darkmode = false;
      var hcmode = false;

      when(mockThemeService.getCurrentThemeState)
          .thenAnswer((_) => Future.value(ThemeState.light()));

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

      when(() => mockAuthService.login(AuthMethod.facebook)).thenAnswer(
        (_) => Future.value(AuthResult.success),
      );

      when(() => mockAuthService.getUserId()).thenReturn('1234');

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authServiceProvider.overrideWith((ref) => mockAuthService),
            themeServiceProvider.overrideWith((ref) => mockThemeService),
            authRepositoryProvider.overrideWith((ref) => mockAuthRepository),
          ],
          child: const MyApp(),
        ),
      );

      final element = tester.element(find.byType(MyApp));
      final container = ProviderScope.containerOf(element);
      final robot = AuthRobot(tester: tester);

      await robot.loginWithFacebook();

      final mainPage = find.byKey(Keys.mainPage);
      final accessibilityPage = find.byKey(Keys.accessibilityPage);

      await tester.dragUntilVisible(
          accessibilityPage, mainPage, const Offset(-300, 0));

      expect(container.read(isLoggedInProvider), true);
      expect(accessibilityPage, findsOne);

      await container.read(themeControllerProvider.notifier).toggleDarkMode();

      expect(
        container.read(themeControllerProvider).value!,
        ThemeState(isDarkModeEnabled: true, isHCModeEnabled: false),
      );

      await container.read(themeControllerProvider.notifier).toggleDarkMode();

      expect(
        container.read(themeControllerProvider).value!,
        ThemeState(isDarkModeEnabled: false, isHCModeEnabled: false),
      );
    });
  });
}
