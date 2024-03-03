import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/course_progress/data/abstract_repositories/content_progress_repository.dart';
import 'package:luciapp/features/course_progress/data/abstract_repositories/course_progress_repository.dart';
import 'package:luciapp/features/course_progress/domain/models/content_progress.dart';
import 'package:luciapp/features/course_progress/domain/models/course_progress.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/complete_content_controller.dart';
import 'package:luciapp/main.dart';

class CompleteContentService {
  final ICourseProgressRepository courseProgressRepository;
  final IContentProgressRepository contentProgressRepository;

  CompleteContentService({
    required this.courseProgressRepository,
    required this.contentProgressRepository,
  });

  Future<bool> completeContent(CompleteContentPayload payload) async {
    try {
      final courseProgress =
          await getOrCreateCourseProgress(payload.userId, payload.courseId);

      final existingContentProgress = await contentProgressRepository.get(
          payload.contentId, courseProgress.id);

      print(existingContentProgress);

      if (existingContentProgress == null) {
        await contentProgressRepository.create(
            ContentProgress(completed: true, contentId: payload.contentId),
            courseProgress.id);
      }

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<CourseProgress> getOrCreateCourseProgress(
      UserId userId, String courseId) async {
    final courseProgress = await courseProgressRepository.get(courseId, userId);

    // print(courseId);
    if (courseProgress == null) {
      return await courseProgressRepository.create(courseId, userId);
    }

    return courseProgress;
  }
}

final completeContentServiceProvider = Provider<CompleteContentService>((ref) {
  return CompleteContentService(
    courseProgressRepository: ref.watch(courseProgressRepositoryProvider),
    contentProgressRepository: ref.watch(contentProgressRepositoryProvider),
  );
});
