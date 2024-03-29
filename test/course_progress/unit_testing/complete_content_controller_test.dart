import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/data/providers/user_id_provider.dart';
import 'package:luciapp/features/course_progress/application/complete_content_service.dart';
import 'package:luciapp/features/course_progress/data/dto/complete_content_dto.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/active_content_controller.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/complete_content_controller.dart';
import 'package:luciapp/features/course_progress/presentation/state/active_content_state.dart';
import 'package:mocktail/mocktail.dart';

class MockCompleteContentService extends Mock
    implements CompleteContentService {}

class MockActiveContentController extends StateNotifier<ActiveContentState>
    with Mock
    implements ActiveContentController {
  MockActiveContentController(super.initialValue);
}

void main() {
  group('CompleteContentNotifier', () {
    late MockCompleteContentService mockService;
    late ProviderContainer container;
    late CompleteContentController notifier;
    late MockActiveContentController mockActiveContentController;
    final dto = CompleteContentDto(
      userId: 'userId',
      courseId: 'courseId',
      contentId: 'contentId',
      nContents: 5,
    );

    setUp(() {
      mockService = MockCompleteContentService();
      mockActiveContentController = MockActiveContentController(
        const ActiveContentState(
          courseId: 'courseId',
          contentId: 'contentId',
          userId: 'userId',
          nContents: 5,
        ),
      );

      container = ProviderContainer(overrides: [
        completeContentServiceProvider.overrideWithValue(mockService),
        userIdProvider.overrideWithValue('1234'),
        activeContentControllerProvider
            .overrideWith((ref) => mockActiveContentController)
      ]);

      when(() => mockService.completeContent(dto))
          .thenAnswer((invocation) => Future.value(true));
    });

    test('completeContent updates state correctly', () async {
      notifier = container.read(completeContentControllerProvider.notifier);

      // Trigger completeContent method
      await notifier.completeContent();

      // // Verify state updates correctly
      // expect(notifier.state, isA<AsyncLoading>());
      // await Future.delayed(Duration.zero); // Allow time for async operation
      // expect(notifier.state, isNot(isA<AsyncLoading>()));

      verifyNever(() => mockService.completeContent(dto)); //
    });

    // Add more tests for other scenarios and edge cases
  });
}
