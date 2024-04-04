// ignore_for_file: unused_result

import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/data/providers/user_id_provider.dart';
import 'package:luciapp/features/course_progress/application/complete_content_service.dart';
import 'package:luciapp/features/course_progress/data/dto/complete_content_dto.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/active_content_controller.dart';
import 'package:luciapp/features/courses/data/providers/courses_provider.dart';

class CompleteContentController extends AsyncNotifier<void> {
  late final CompleteContentService _service =
      ref.watch(completeContentServiceProvider);
  @override
  FutureOr<void> build() {}

  Future<void> completeContent() async {
    ref.invalidate(userIdProvider);

    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
        _service.completeContent(CompleteContentDto(
          userId: ref.read(activeContentControllerProvider).userId ?? "",
          courseId: ref.read(activeContentControllerProvider).courseId ?? "",
          contentId: ref.read(activeContentControllerProvider).contentId ?? "",
          nContents: ref.read(activeContentControllerProvider).nContents ?? 0,
        )));
    ref.refresh(coursesProvider);
  }
}

final completeContentControllerProvider =
    AsyncNotifierProvider<CompleteContentController, void>(() {
  return CompleteContentController();
});
