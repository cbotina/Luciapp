// ignore_for_file: unused_result

import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/data/providers/user_id_provider.dart';
import 'package:luciapp/features/course_progress/application/complete_course_service.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/active_content_controller.dart';
import 'package:luciapp/features/courses/data/providers/courses_provider.dart';

class CompleteContentNotifier extends AsyncNotifier<void> {
  late final CompleteContentService _completeContentService =
      ref.watch(completeContentServiceProvider);
  @override
  FutureOr<void> build() {}

  Future<void> completeContent() async {
    // ref.refresh(completeContentServiceProvider);
    ref.invalidate(userIdProvider);

    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
        _completeContentService.completeContent(CompleteContentPayload(
          userId: ref.read(activeContentControllerProvider).userId ?? "",
          courseId: ref.read(activeContentControllerProvider).courseId ?? "",
          contentId: ref.read(activeContentControllerProvider).contentId ?? "",
          nContents: ref.read(activeContentControllerProvider).nContents ?? 0,
        )));
    ref.refresh(coursesProvider);
    // ref.refresh(courseProgressProvider(''));
  }
}

final completeContentControllerProvider =
    AsyncNotifierProvider<CompleteContentNotifier, void>(() {
  return CompleteContentNotifier();
});

class CompleteContentPayload {
  final String userId;
  final String courseId;
  final String contentId;
  final int nContents;

  CompleteContentPayload({
    required this.userId,
    required this.courseId,
    required this.contentId,
    required this.nContents,
  });
}
