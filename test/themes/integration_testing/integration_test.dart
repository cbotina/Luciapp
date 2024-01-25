import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/application/auth_service.dart';
import 'package:luciapp/features/auth/data/providers/is_logged_in_provider.dart';
import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/widget_keys.dart';
import 'package:luciapp/features/themes/application/theme_service.dart';
import 'package:luciapp/features/themes/presentation/state/theme_state.dart';
import 'package:luciapp/main.dart';
import 'package:mocktail/mocktail.dart';
import '../../../integration_test/i2.dart';
import '../../auth/integration_testing/robot/register_robot.dart';
import '../../auth/mocks/mock_auth_service.dart';
import '../../common/mocks/mock_auth_repository.dart';

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
    testWidgets('When user is authenticated', (tester) async {
      when(mockThemeService.getCurrentThemeState)
          .thenAnswer((_) => Future.value(ThemeState.light()));

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

      expect(container.read(isLoggedInProvider), true);
      expect(mainPage, findsOne);
    });

    testWidgets('When user is authenticated but not registered',
        (tester) async {
      when(mockThemeService.getCurrentThemeState)
          .thenAnswer((invocation) => Future.value(ThemeState.light()));

      when(() => mockAuthService.login(AuthMethod.facebook)).thenAnswer(
        (_) => Future.value(AuthResult.registering),
      );

      when(() => mockAuthService.getUserId()).thenReturn('1234');

      when(() => mockAuthRepository.displayName).thenReturn('Carlos');

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

      // robot login with facebook
      final facebookButton = find.byKey(Keys.facebookButton);
      await tester.tap(facebookButton);
      await tester.pump(Durations.short1);

      final registerForm = find.byKey(Keys.registerForm);

      expect(container.read(isLoggedInProvider), false);
      expect(registerForm, findsOne);
    });
    testWidgets('When authentication fails', (tester) async {
      when(mockThemeService.getCurrentThemeState)
          .thenAnswer((invocation) => Future.value(ThemeState.light()));

      when(() => mockAuthService.login(AuthMethod.facebook)).thenAnswer(
        (_) => Future.value(AuthResult.failure),
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

      // robot login with facebook
      final facebookButton = find.byKey(Keys.facebookButton);
      await tester.tap(facebookButton);
      await tester.pump(Durations.short1);

      final authPage = find.byKey(Keys.authPage);

      expect(container.read(isLoggedInProvider), false);
      expect(authPage, findsOne);
    });

    testWidgets('When user cancels authentication', (tester) async {
      when(mockThemeService.getCurrentThemeState)
          .thenAnswer((invocation) => Future.value(ThemeState.light()));

      when(() => mockAuthService.login(AuthMethod.facebook)).thenAnswer(
        (_) => Future.value(AuthResult.aborted),
      );

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

      // robot login with facebook
      final facebookButton = find.byKey(Keys.facebookButton);
      await tester.tap(facebookButton);
      await tester.pump(Durations.short1);

      final authPage = find.byKey(Keys.authPage);

      expect(container.read(isLoggedInProvider), false);
      expect(authPage, findsOne);
    });

    testWidgets('When user is authenticated but not registered',
        (tester) async {
      when(mockThemeService.getCurrentThemeState)
          .thenAnswer((invocation) => Future.value(ThemeState.light()));

      when(() => mockAuthService.login(AuthMethod.facebook)).thenAnswer(
        (_) => Future.value(AuthResult.registering),
      );

      when(() => mockAuthService.getUserId()).thenReturn('1234');

      when(() => mockAuthRepository.displayName).thenReturn('Carlos');

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

      // robot login with facebook
      final facebookButton = find.byKey(Keys.facebookButton);
      await tester.tap(facebookButton);
      await tester.pump(Durations.short1);

      final registerForm = find.byKey(Keys.registerForm);

      expect(container.read(isLoggedInProvider), false);
      expect(registerForm, findsOne);
    });
    testWidgets('When user is authenticated but not registered',
        (tester) async {
      when(mockThemeService.getCurrentThemeState)
          .thenAnswer((invocation) => Future.value(ThemeState.light()));

      when(() => mockAuthService.login(AuthMethod.facebook)).thenAnswer(
        (_) => Future.value(AuthResult.registering),
      );

      when(() => mockAuthService.getUserId()).thenReturn('1234');

      when(() => mockAuthRepository.displayName).thenReturn('Carlos');

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

      final facebookButton = find.byKey(Keys.facebookButton);
      await tester.tap(facebookButton);
      await tester.pump(Durations.short1);

      final registerForm = find.byKey(Keys.registerForm);

      expect(container.read(isLoggedInProvider), false);
      expect(registerForm, findsOne);
    });

    testWidgets('When user logsout', (tester) async {
      when(mockThemeService.getCurrentThemeState)
          .thenAnswer((invocation) => Future.value(ThemeState.light()));

      when(() => mockAuthService.login(AuthMethod.facebook)).thenAnswer(
        (_) => Future.value(AuthResult.success),
      );

      when(() => mockAuthService.getUserId()).thenReturn('1234');

      when(() => mockAuthService.logout()).thenAnswer(
        (_) => Future.value(),
      );

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

      // robot login with facebook
      final facebookButton = find.byKey(Keys.facebookButton);
      await tester.tap(facebookButton);
      await tester.pump(Durations.short1);

      final mainPage = find.byKey(Keys.mainPage);

      expect(container.read(isLoggedInProvider), true);
      expect(mainPage, findsOne);

      final logoutButton = find.byKey(Keys.logoutIconButton);

      // robot logout
      await tester.tap(logoutButton);
      await tester.pump(Durations.short1);

      expect(container.read(isLoggedInProvider), false);
      expect(mainPage, findsNothing);
    });
  });
}
