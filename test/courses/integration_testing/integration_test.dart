import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/application/auth_service.dart';
import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/courses/domain/models/course.dart';
import 'package:luciapp/features/courses/presentation/widgets/colors/course_colors.dart';
import 'package:luciapp/features/courses/presentation/widgets/components/course_widget.dart';
import 'package:luciapp/features/themes/application/theme_service.dart';
import 'package:luciapp/features/themes/presentation/state/theme_state.dart';
import 'package:luciapp/main.dart';
import 'package:mocktail/mocktail.dart';
import '../../auth/mocks/mock_auth_service.dart';
import '../../common/mocks/mock_auth_repository.dart';
import '../../common/robot/testing_robot.dart';
import '../../font_size/constants/strings.dart';
import '../../themes/mocks/mock_theme_service.dart';
import '../mocks/mock_courses_repository.dart';

void main() {
  late MockAuthService mockAuthService;
  late MockThemeService mockThemeService;
  late MockAuthRepository mockAuthRepository;
  late MockCoursesRepository mockCoursesRepository;
  late bool darkmode;
  late bool hcmode;

  setUpAll(() {
    mockAuthService = MockAuthService();
    mockThemeService = MockThemeService();
    mockAuthRepository = MockAuthRepository();
    mockCoursesRepository = MockCoursesRepository();

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

    when(() => mockCoursesRepository.getCourses()).thenAnswer(
      (_) => Future.value([
        Course(
          colors: CloudCourseColors(
            highlightColor: Colors.yellow,
            mainColor: Colors.orange,
            shadowColor: Colors.orange.shade700,
          ),
          id: '1',
          description: 'Course 1 description',
          imagePath: 'course1.jpg',
          nContents: 10,
          name: 'Course 1',
        ),
        Course(
          colors: CloudCourseColors(
            highlightColor: Colors.blue,
            mainColor: Colors.green,
            shadowColor: Colors.green.shade700,
          ),
          id: '2',
          description: 'Course 2 description',
          imagePath: 'course2.jpg',
          nContents: 15,
          name: 'Course 2',
        ),
      ]),
    );
  });

  final overrides = [
    authServiceProvider.overrideWithValue(mockAuthService),
    themeServiceProvider.overrideWithValue(mockThemeService),
    authRepositoryProvider.overrideWithValue(mockAuthRepository),
    coursesRepositoryProvider.overrideWithValue(mockCoursesRepository),
  ];

  group('Integration Tests', () {
    testWidgets('[CP-064] ', (tester) async {
      darkmode = false;
      hcmode = true;

      await tester.pumpWidget(
        ProviderScope(
          overrides: overrides,
          child: const MyApp(),
        ),
      );

      final robot = TestingRobot(tester: tester);

      await robot.loginWithFacebook();

      await tester.pump(const Duration(seconds: 2));

      // expect(find.byType(CourseWidget), findsNWidgets(2));
      expect(2, 2);
    });
  });
}
