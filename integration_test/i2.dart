import 'package:flutter/widgets.dart';
import 'package:luciapp/features/themes/application/theme_service.dart';
import 'package:luciapp/features/themes/data/providers/is_dark_mode_enabled_provider.dart';
import 'package:luciapp/features/themes/data/providers/is_hc_mode_enabled_provider.dart';
import 'package:luciapp/features/themes/presentation/controllers/theme_controller.dart';
import 'package:luciapp/features/themes/presentation/state/theme_state.dart';
import 'package:luciapp/main.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/providers/is_loading_provider.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/data/providers/auth_result_provider.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/widget_keys.dart';
import 'package:luciapp/features/themes/presentation/widgets/constants/widget_keys.dart'
    as themes;

import '../test/common/mocks/mock_auth_repository.dart';

class MockThemeController extends AsyncNotifier<ThemeState>
    with Mock
    implements ThemeController {}

class MockThemeService extends Mock implements ThemeService {}

void main() {
  // late final User testUser;
  late MockAuthRepository mockAuthRepository;
  late MockThemeController mockThemeController;
  late MockThemeService mockThemeService;

  // late final MockAuthController mockAuthController;

  setUpAll(() async {
    // testUser = User(
    //   userId: '1234',
    //   name: 'Carlos',
    //   gender: Gender.male,
    //   age: 21,
    // );
    WidgetsFlutterBinding.ensureInitialized();
    mockAuthRepository = MockAuthRepository();
    mockThemeController = MockThemeController();
    mockThemeService = MockThemeService();
    // mockAuthController = MockAuthController();
  });

  group(
    "TestNames.integrationTest",
    () {
      testWidgets("TestNames.cp030", (WidgetTester tester) async {
        when(mockThemeController.toggleDarkMode)
            .thenAnswer((invocation) => Future.value());
        // container = makeProviderContainer(mockThemeService);

        when(mockThemeService.toggleDarkMode).thenAnswer((invocation) =>
            Future.value(
                ThemeState(isDarkModeEnabled: true, isHCModeEnabled: false)));

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authRepositoryProvider.overrideWith((ref) => mockAuthRepository),
              authResultProvider.overrideWith((ref) => AuthResult.success),
              themeControllerProvider.overrideWith(() => mockThemeController),
              // themeControllerProvider.overrideWith(
              //   () => container.read(themeControllerProvider.notifier),
              // ),
              themeServiceProvider.overrideWith((ref) => mockThemeService),
              isDarkModeEnabledProvider.overrideWith((ref) => false),
              isHcModeEnabledProvider.overrideWith((ref) => false),
              isLoadingProvider.overrideWith((ref) => false),
            ],
            child: const MyApp(),
          ),
        );

        final homePage = find.byKey(Keys.homePage);

        final darkButton = find.byKey(themes.Keys.darkModeIconButton);

        await tester.tap(darkButton);
        await tester.pump(const Duration(milliseconds: 100));

        await tester.tap(darkButton);
        await tester.pump(const Duration(milliseconds: 100));

        await tester.tap(darkButton);
        await tester.pump(const Duration(milliseconds: 100));

        expect(homePage, findsOne);
      });
    },
  );
}
