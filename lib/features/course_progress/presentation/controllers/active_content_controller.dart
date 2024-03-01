import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/data/providers/user_id_provider.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/course_progress/presentation/state/active_content_state.dart';

class ActiveContentController extends StateNotifier<ActiveContentState> {
  final UserId? userId;

  ActiveContentController({required this.userId})
      : super(const ActiveContentState.initial().copyWithUserId(userId ?? ''));
}

final activeContentControllerProvider =
    Provider<ActiveContentController>((ref) {
  final userId = ref.watch(userIdProvider);
  return ActiveContentController(userId: userId);
});
