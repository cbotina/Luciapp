import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/data/providers/user_id_provider.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/course_progress/domain/typedefs/content_id.dart';
import 'package:luciapp/features/course_progress/presentation/state/active_content_state.dart';
import 'package:luciapp/features/courses/domain/typedefs/course_id.dart';

class ActiveContentController extends StateNotifier<ActiveContentState> {
  final UserId? userId;

  ActiveContentController({required this.userId})
      : super(const ActiveContentState.initial().copyWithUserId(userId ?? ''));

  void setCourseId(CourseId courseId) {
    state = state.copyWithCourseId(courseId);
  }

  void setContentId(ContentId contentId) {
    state = state.copyWithContentId(contentId);
  }

  void setNContents(int nContents) {
    state = state.copyWithNContents(nContents);
  }
}

final activeContentControllerProvider =
    StateNotifierProvider<ActiveContentController, ActiveContentState>((ref) {
  final userId = ref.watch(userIdProvider);
  return ActiveContentController(userId: userId);
});
