import 'package:luciapp/common/constants/widget_keys.dart';
import 'package:luciapp/features/attributions/data/providers/about_text_provider.dart';
import 'package:luciapp/features/auth/application/auth_service.dart';
import 'package:luciapp/features/auth/data/providers/is_logged_in_provider.dart';
import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/courses/data/providers/courses_provider.dart';
import 'package:luciapp/features/courses/presentation/widgets/course_list.dart';
import 'package:luciapp/features/themes/application/theme_service.dart';
import 'package:luciapp/features/themes/presentation/state/theme_state.dart';
import 'package:luciapp/main.dart';
import '../../themes/mocks/mock_theme_service.dart';
import '../constants/strings.dart';
import 'package:mocktail/mocktail.dart';
import '../../common/mocks/mock_auth_repository.dart';
import '../mocks/mock_auth_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/common/providers/is_loading_provider.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/data/providers/user_id_provider.dart';
import 'package:luciapp/features/auth/data/providers/auth_result_provider.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/strings.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';
import 'package:luciapp/features/auth/data/providers/user_display_name_provider.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/widget_keys.dart'
    as auth;

import '../mocks/mock_auth_service.dart';
import '../../common/robot/testing_robot.dart';

void main() {
  late final User testUser;
  late final MockAuthRepository mockAuthRepository;
  late final MockAuthController mockAuthController;
  late final MockAuthService mockAuthService;
  late final MockThemeService mockThemeService;

  setUpAll(() async {
    testUser = User(
      userId: '1234',
      name: 'Carlos',
      gender: Gender.male,
      age: 21,
    );
    mockAuthRepository = MockAuthRepository();
    mockAuthController = MockAuthController();
    mockAuthService = MockAuthService();
    mockThemeService = MockThemeService();
  });

  group(
    TestNames.integrationTest,
    () {
      testWidgets(TestNames.cp025, (WidgetTester tester) async {
        when(mockThemeService.getCurrentThemeState)
            .thenAnswer((_) => Future.value(const ThemeState.light()));

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
              coursesProvider.overrideWith((ref) => []),
              aboutTextProvider.overrideWith((ref) => ''),
              coursesWithPercentagesProvider.overrideWith((ref) => [])
            ],
            child: const MyApp(),
          ),
        );

        final element = tester.element(find.byType(MyApp));
        final container = ProviderScope.containerOf(element);
        final robot = TestingRobot(tester: tester);

        await robot.login();

        final mainPage = find.byKey(Keys.mainPage);

        expect(container.read(isLoggedInProvider), true);
        expect(mainPage, findsOne);
      });

      testWidgets(TestNames.cp026, (WidgetTester tester) async {
        when(mockThemeService.getCurrentThemeState)
            .thenAnswer((invocation) => Future.value(const ThemeState.light()));

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
              coursesProvider.overrideWith((ref) => []),
              aboutTextProvider.overrideWith((ref) => ''),
              coursesWithPercentagesProvider.overrideWith((ref) => [])
            ],
            child: const MyApp(),
          ),
        );

        final element = tester.element(find.byType(MyApp));
        final container = ProviderScope.containerOf(element);
        final robot = TestingRobot(tester: tester);

        // robot login with facebook
        await robot.login();

        final registerForm = find.byKey(auth.Keys.registerForm);

        expect(container.read(isLoggedInProvider), false);
        expect(registerForm, findsOne);
      });

      testWidgets(TestNames.cp027, (WidgetTester tester) async {
        when(mockThemeService.getCurrentThemeState)
            .thenAnswer((invocation) => Future.value(const ThemeState.light()));

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
              coursesProvider.overrideWith((ref) => []),
              aboutTextProvider.overrideWith((ref) => ''),
              coursesWithPercentagesProvider.overrideWith((ref) => [])
            ],
            child: const MyApp(),
          ),
        );

        final element = tester.element(find.byType(MyApp));
        final container = ProviderScope.containerOf(element);
        final robot = TestingRobot(tester: tester);

        await robot.login();

        final authPage = find.byKey(auth.Keys.authPage);

        expect(container.read(isLoggedInProvider), false);
        expect(authPage, findsOne);
      });

      testWidgets(TestNames.cp028, (WidgetTester tester) async {
        when(mockThemeService.getCurrentThemeState)
            .thenAnswer((invocation) => Future.value(const ThemeState.light()));

        when(() => mockAuthService.login(AuthMethod.facebook)).thenAnswer(
          (_) => Future.value(AuthResult.aborted),
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authServiceProvider.overrideWith((ref) => mockAuthService),
              themeServiceProvider.overrideWith((ref) => mockThemeService),
              authRepositoryProvider.overrideWith((ref) => mockAuthRepository),
              coursesProvider.overrideWith((ref) => []),
              aboutTextProvider.overrideWith((ref) => ''),
              coursesWithPercentagesProvider.overrideWith((ref) => [])
            ],
            child: const MyApp(),
          ),
        );

        final element = tester.element(find.byType(MyApp));
        final container = ProviderScope.containerOf(element);
        final robot = TestingRobot(tester: tester);

        await robot.login();

        final authPage = find.byKey(auth.Keys.authPage);

        expect(container.read(isLoggedInProvider), false);
        expect(authPage, findsOne);
      });

      testWidgets(TestNames.cp029, (WidgetTester tester) async {
        reset(mockAuthRepository);
        reset(mockAuthController);

        final robot = TestingRobot(tester: tester);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authControllerProvider.overrideWith((ref) => mockAuthController),
              authRepositoryProvider.overrideWith((ref) => mockAuthRepository),
              authResultProvider.overrideWith((ref) => AuthResult.registering),
              userDisplayNameProvider.overrideWith((ref) => null),
              userIdProvider.overrideWith((ref) => testUser.userId),
              isLoadingProvider.overrideWith((ref) => true),
              coursesProvider.overrideWith((ref) => []),
              aboutTextProvider.overrideWith((ref) => ''),
              coursesWithPercentagesProvider.overrideWith((ref) => [])
            ],
            child: const MyApp(),
          ),
        );

        await robot.enterName(testUser.name);
        await robot.enterAge(testUser.age);
        await robot.selectGender();

        when(() => mockAuthController.register(testUser)).thenAnswer(
          (_) => Future.value(),
        );

        await robot.pressRegisterButton();

        verify(() => mockAuthController.register(testUser)).called(1);
      });

      testWidgets(TestNames.cp030, (WidgetTester tester) async {
        reset(mockAuthRepository);
        reset(mockAuthController);

        final robot = TestingRobot(tester: tester);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authControllerProvider.overrideWith((ref) => mockAuthController),
              authRepositoryProvider.overrideWith((ref) => mockAuthRepository),
              authResultProvider.overrideWith((ref) => AuthResult.registering),
              userDisplayNameProvider.overrideWith((ref) => null),
              userIdProvider.overrideWith((ref) => testUser.userId),
              isLoadingProvider.overrideWith((ref) => true),
              coursesProvider.overrideWith((ref) => []),
              aboutTextProvider.overrideWith((ref) => ''),
              coursesWithPercentagesProvider.overrideWith((ref) => [])
            ],
            child: const MyApp(),
          ),
        );

        when(() => mockAuthController.register(testUser)).thenAnswer(
          (_) => Future.value(),
        );

        await robot.pressRegisterButton();

        expect(find.text(Strings.ageIsRequired), findsAny);
        expect(find.text(Strings.nameIsRequired), findsAny);
        expect(find.text(Strings.genderIsRequired), findsAny);

        await robot.enterName(testUser.name);
        await robot.pressRegisterButton();

        expect(find.text(Strings.ageIsRequired), findsAny);
        expect(find.text(Strings.nameIsRequired), findsNothing);
        expect(find.text(Strings.genderIsRequired), findsAny);

        await robot.enterAge(testUser.age);
        await robot.pressRegisterButton();

        expect(find.text(Strings.ageIsRequired), findsNothing);
        expect(find.text(Strings.nameIsRequired), findsNothing);
        expect(find.text(Strings.genderIsRequired), findsAny);

        await robot.selectGender();
        await robot.pressRegisterButton();

        expect(find.text(Strings.ageIsRequired), findsNothing);
        expect(find.text(Strings.nameIsRequired), findsNothing);
        expect(find.text(Strings.genderIsRequired), findsNothing);
      });

      testWidgets(TestNames.cp031, (WidgetTester tester) async {
        when(mockThemeService.getCurrentThemeState)
            .thenAnswer((invocation) => Future.value(const ThemeState.light()));

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
              coursesProvider.overrideWith((ref) => []),
              aboutTextProvider.overrideWith((ref) => ''),
              coursesWithPercentagesProvider.overrideWith((ref) => [])
            ],
            child: const MyApp(),
          ),
        );

        final element = tester.element(find.byType(MyApp));
        final container = ProviderScope.containerOf(element);
        final robot = TestingRobot(tester: tester);

        await robot.login();

        final mainPage = find.byKey(Keys.mainPage);

        expect(container.read(isLoggedInProvider), true);
        expect(mainPage, findsOne);

        await robot.pressLogoutIconButton();

        expect(container.read(isLoggedInProvider), false);
        expect(mainPage, findsNothing);
      });
    },
  );
}
