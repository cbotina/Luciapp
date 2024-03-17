import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/attributions/data/providers/about_text_provider.dart';
import 'package:luciapp/features/auth/application/auth_service.dart';
import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/courses/data/providers/courses_provider.dart';
import 'package:luciapp/features/courses/domain/models/course.dart';
import 'package:luciapp/features/courses/presentation/widgets/colors/course_colors.dart';
import 'package:luciapp/features/courses/presentation/widgets/components/course_widget.dart';
import 'package:luciapp/features/courses/presentation/widgets/course_list.dart';
import 'package:luciapp/features/themes/application/theme_service.dart';
import 'package:luciapp/features/themes/presentation/state/theme_state.dart';
import 'package:luciapp/main.dart';
import 'package:mocktail/mocktail.dart';
import '../../common/robot/testing_robot.dart';
import '../../auth/mocks/mock_auth_service.dart';
import '../../common/mocks/mock_auth_repository.dart';
import '../../themes/constants/strings.dart';
import '../../themes/mocks/mock_theme_service.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:mockito/mockito.dart' as mockito;

class MockClient extends mockito.Mock implements HttpClient {}

const imageUrl =
    'https://firebasestorage.googleapis.com/v0/b/project-luciapp.appspot.com/o/courses%2F3JpGUu0qD7nfC2F1f1yf%2Fgame_images%2Flas%20flores.png?alt=media&token=b36ec641-4cd1-4697-90b8-8d40054ff545';

final client = MockClient();

final coursesWithPercentage = [
  CourseWithPercentage(
    course: Course(
      colors: CloudCourseColors(
        highlightColor: Colors.yellow,
        mainColor: Colors.orange,
        shadowColor: Colors.orange.shade700,
      ),
      id: '1',
      description: 'Course 1 description',
      imagePath: imageUrl,
      nContents: 10,
      name: 'Course 1',
    ),
    percentage: 0,
  ),
  CourseWithPercentage(
    course: Course(
      colors: CloudCourseColors(
        highlightColor: Colors.blue,
        mainColor: Colors.green,
        shadowColor: Colors.green.shade700,
      ),
      id: '2',
      description: 'Course 2 description',
      imagePath: imageUrl,
      nContents: 15,
      name: 'Course 2',
    ),
    percentage: 0,
  ),
];

void main() {
  late MockAuthService mockAuthService;
  late MockThemeService mockThemeService;
  late MockAuthRepository mockAuthRepository;
  late bool darkmode;
  late bool hcmode;

  setUpAll(() {
    HttpOverrides.global = null;
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
    coursesProvider.overrideWith((ref) => []),
    aboutTextProvider.overrideWith((ref) => ''),
    coursesWithPercentagesProvider.overrideWith((ref) => coursesWithPercentage)
  ];

  HttpOverrides.runZoned(() async {
    group(TestNames.integrationTest, () {
      testWidgets(
          '[CP-064] Mostrar lista de cursos cuando existen registros en la base de datos',
          (tester) async {
        darkmode = false;
        hcmode = true;

        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(
            ProviderScope(
              overrides: overrides,
              child: const MyApp(),
            ),
          );
        });

        final robot = TestingRobot(tester: tester);

        await robot.loginWithFacebook();

        await tester.pump(const Duration(seconds: 2));

        expect(find.byType(CourseWidget), findsNWidgets(2));
      });

      testWidgets(
          '[CP-065] Obtener mensaje cuando no existen cursos en la base de datos',
          (tester) async {
        darkmode = false;
        hcmode = true;

        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                ...overrides,
                coursesWithPercentagesProvider.overrideWith(
                  (ref) => [],
                ),
              ],
              child: const MyApp(),
            ),
          );
        });

        final robot = TestingRobot(tester: tester);

        await robot.loginWithFacebook();

        await tester.pump(const Duration(seconds: 2));

        expect(find.text('No se han publicado cursos aún'), findsOne);
      });

      testWidgets(
          '[CP-066] Mostrar aviso cuando no se cuenta con una conexión a internet',
          (tester) async {
        darkmode = false;
        hcmode = true;

        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                ...overrides,
                coursesWithPercentagesProvider.overrideWith(
                  (ref) => Future.error(
                      'Es necesario estar conectado a internet para acceder a los cursos'),
                ),
              ],
              child: const MyApp(),
            ),
          );
        });

        final robot = TestingRobot(tester: tester);

        await robot.loginWithFacebook();

        await tester.pump(const Duration(seconds: 2));

        expect(
            find.text(
                'Es necesario estar conectado a internet para acceder a los cursos'),
            findsOne);
      });
    });
  }, createHttpClient: (c) => HttpClient(context: c));
}
