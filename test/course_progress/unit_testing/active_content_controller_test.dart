import 'package:flutter_test/flutter_test.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/active_content_controller.dart';

void main() {
  group('ActiveContentController', () {
    late ActiveContentController controller;
    late UserId userId;

    setUp(() {
      userId = '123';
      controller = ActiveContentController(userId: userId);
    });

    test('setCourseId updates the state with the provided course ID', () {
      const courseId = 'course_123';
      controller.setCourseId(courseId);
      expect(controller.state.courseId, courseId);
    });

    test('setContentId updates the state with the provided content ID', () {
      const contentId = 'content_456';
      controller.setContentId(contentId);
      expect(controller.state.contentId, contentId);
    });

    test('setNContents updates the state with the provided number of contents',
        () {
      const nContents = 10;
      controller.setNContents(nContents);
      expect(controller.state.nContents, nContents);
    });
  });
}
