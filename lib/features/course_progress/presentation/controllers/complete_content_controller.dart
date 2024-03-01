import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/course_progress/application/complete_course_service.dart';

class CompleteContentNotifier extends AsyncNotifier<void> {
  late final CompleteContentService _completeContentService =
      ref.watch(completeContentServiceProvider);
  @override
  FutureOr<void> build() {}

  Future<void> completeContent(String contentId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _completeContentService.completeContent(),
    );
  }
}
