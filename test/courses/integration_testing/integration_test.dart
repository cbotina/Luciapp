import 'dart:async';
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
      testWidgets('[CP-064] ', (tester) async {
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

        // await tester.pumpWidget(
        //   ProviderScope(
        //     overrides: overrides,
        //     child: const MyApp(),
        //   ),
        // );

        final robot = TestingRobot(tester: tester);

        await robot.loginWithFacebook();

        await tester.pump(const Duration(seconds: 2));

        expect(find.byType(CourseWidget), findsNWidgets(2));
      });
    });
  }, createHttpClient: (c) => HttpClient(context: c));
}

/// ***
///
///
///

const List<int> kTransparentImage = <int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x06,
  0x62,
  0x4B,
  0x47,
  0x44,
  0x00,
  0xFF,
  0x00,
  0xFF,
  0x00,
  0xFF,
  0xA0,
  0xBD,
  0xA7,
  0x93,
  0x00,
  0x00,
  0x00,
  0x09,
  0x70,
  0x48,
  0x59,
  0x73,
  0x00,
  0x00,
  0x0B,
  0x13,
  0x00,
  0x00,
  0x0B,
  0x13,
  0x01,
  0x00,
  0x9A,
  0x9C,
  0x18,
  0x00,
  0x00,
  0x00,
  0x07,
  0x74,
  0x49,
  0x4D,
  0x45,
  0x07,
  0xE6,
  0x03,
  0x10,
  0x17,
  0x07,
  0x1D,
  0x2E,
  0x5E,
  0x30,
  0x9B,
  0x00,
  0x00,
  0x00,
  0x0B,
  0x49,
  0x44,
  0x41,
  0x54,
  0x08,
  0xD7,
  0x63,
  0x60,
  0x00,
  0x02,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0xE2,
  0x26,
  0x05,
  0x9B,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
];

FakeHttpClient createMockImageHttpClient(SecurityContext? _) {
  final FakeHttpClient client = FakeHttpClient();
  return client;
}

class FakeHttpClient extends Fake implements HttpClient {
  FakeHttpClient([this.context]);

  SecurityContext? context;

  @override
  bool autoUncompress = false;

  final FakeHttpClientRequest request = FakeHttpClientRequest();

  @override
  Future<HttpClientRequest> getUrl(Uri url) async {
    return request;
  }
}

class FakeHttpClientRequest extends Fake implements HttpClientRequest {
  final FakeHttpClientResponse response = FakeHttpClientResponse();

  @override
  Future<HttpClientResponse> close() async {
    return response;
  }
}

class FakeHttpClientResponse extends Fake implements HttpClientResponse {
  @override
  int get statusCode => 200;

  @override
  int get contentLength => kTransparentImage.length;

  @override
  final FakeHttpHeaders headers = FakeHttpHeaders();

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int>)? onData, {
    void Function()? onDone,
    Function? onError,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable(<List<int>>[kTransparentImage])
        .listen(onData,
            onDone: onDone, onError: onError, cancelOnError: cancelOnError);
  }
}

class FakeHttpHeaders extends Fake implements HttpHeaders {}

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:luciapp/features/attributions/data/providers/about_text_provider.dart';
// import 'package:luciapp/features/auth/application/auth_service.dart';
// import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
// import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
// import 'package:luciapp/features/courses/domain/models/course.dart';
// import 'package:luciapp/features/courses/presentation/widgets/colors/course_colors.dart';
// import 'package:luciapp/features/courses/presentation/widgets/course_list.dart';
// import 'package:luciapp/features/themes/application/theme_service.dart';
// import 'package:luciapp/features/themes/presentation/state/theme_state.dart';
// import 'package:luciapp/main.dart';
// import 'package:mocktail/mocktail.dart';
// import '../../common/robot/testing_robot.dart';
// import '../../auth/mocks/mock_auth_service.dart';
// import '../../common/mocks/mock_auth_repository.dart';
// import '../../themes/mocks/mock_theme_service.dart';
// import '../mocks/mock_courses_repository.dart';

// void main() {
//   late MockAuthService mockAuthService;
//   late MockThemeService mockThemeService;
//   late MockAuthRepository mockAuthRepository;

//   late bool darkmode;
//   late bool hcmode;

//   final courses = [
//     Course(
//       colors: CloudCourseColors(
//         highlightColor: Colors.yellow,
//         mainColor: Colors.orange,
//         shadowColor: Colors.orange.shade700,
//       ),
//       id: '1',
//       description: 'Course 1 description',
//       imagePath: 'course1.jpg',
//       nContents: 10,
//       name: 'Course 1',
//     ),
//     Course(
//       colors: CloudCourseColors(
//         highlightColor: Colors.blue,
//         mainColor: Colors.green,
//         shadowColor: Colors.green.shade700,
//       ),
//       id: '2',
//       description: 'Course 2 description',
//       imagePath: 'course2.jpg',
//       nContents: 15,
//       name: 'Course 2',
//     ),
//   ];

//   final coursesWithPercentage = [
//     for (Course course in courses)
//       CourseWithPercentage(course: course, percentage: .5),
//   ];

//   setUpAll(() {
//     mockAuthService = MockAuthService();
//     mockThemeService = MockThemeService();
//     mockAuthRepository = MockAuthRepository();

//     when(() => mockAuthService.login(AuthMethod.facebook)).thenAnswer(
//       (_) => Future.value(AuthResult.success),
//     );

//     when(mockThemeService.toggleDarkMode).thenAnswer((_) {
//       darkmode = !darkmode;
//       return Future.value(
//           ThemeState(isDarkModeEnabled: darkmode, isHCModeEnabled: hcmode));
//     });

//     when(mockThemeService.toggleHCMode).thenAnswer((_) {
//       hcmode = !hcmode;
//       return Future.value(
//           ThemeState(isDarkModeEnabled: darkmode, isHCModeEnabled: hcmode));
//     });

//     when(mockThemeService.getCurrentThemeState).thenAnswer(
//       (_) => Future.value(
//         ThemeState(
//           isDarkModeEnabled: darkmode,
//           isHCModeEnabled: hcmode,
//         ),
//       ),
//     );

//     when(() => mockAuthService.getUserId()).thenReturn('1234');

//     // when(() => mockCoursesRepository.getCourses()).thenAnswer(
//     //   (_) => Future.value(),
//     // );
//   });

//   final overrides = [
//     authServiceProvider.overrideWithValue(mockAuthService),
//     themeServiceProvider.overrideWithValue(mockThemeService),
//     authRepositoryProvider.overrideWithValue(mockAuthRepository),
//     // coursesRepositoryProvider.overrideWithValue(mockCoursesRepository),
//     aboutTextProvider.overrideWith((ref) => ''),
//     coursesWithPercentagesProvider.overrideWith((ref) => coursesWithPercentage)
//   ];

//   group('Integration Tests', () {
//     testWidgets('[CP-064] ', (tester) async {
//       darkmode = false;
//       hcmode = true;

//       await tester.pumpWidget(
//         ProviderScope(
//           overrides: overrides,
//           child: const MyApp(),
//         ),
//       );

//       final robot = TestingRobot(tester: tester);

//       await robot.loginWithFacebook();

//       await tester.pump(const Duration(seconds: 2));

//       // expect(find.byType(CourseWidget), findsNWidgets(2));
//       expect(2, 2);
//     });
//   });
// }
