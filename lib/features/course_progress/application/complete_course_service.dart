import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/course_progress/data/abstract_repositories/content_progress_repository.dart';
import 'package:luciapp/features/course_progress/data/abstract_repositories/course_progress_repository.dart';
import 'package:luciapp/features/course_progress/domain/models/content_progress.dart';
import 'package:luciapp/features/course_progress/domain/models/course_progress.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/active_content_controller.dart';
import 'package:luciapp/main.dart';

class CompleteContentService {
  final String userId;
  final String courseId;
  final String contentId;
  final ICourseProgressRepository courseProgressRepository;
  final IContentProgressRepository contentProgressRepository;

  CompleteContentService({
    required this.userId,
    required this.courseId,
    required this.contentId,
    required this.courseProgressRepository,
    required this.contentProgressRepository,
  });

  Future<bool> completeContent() async {
    try {
      final contentProgress = await getOrCreateCourseProgress(userId, courseId);
      await contentProgressRepository.create(
          ContentProgress(completed: true, contentId: contentId),
          contentProgress.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<CourseProgress> getOrCreateCourseProgress(
      UserId userId, String courseId) async {
    final courseProgress = await courseProgressRepository.get(courseId, userId);

    if (courseProgress == null) {
      return await courseProgressRepository.create(courseId, userId);
    }
    return courseProgress;
  }
}

final completeContentServiceProvider = Provider<CompleteContentService>((ref) {
  return CompleteContentService(
      userId: ref.watch(activeContentControllerProvider).userId ?? '',
      courseId: ref.watch(activeContentControllerProvider).courseId ?? '',
      contentId: ref.watch(activeContentControllerProvider).contentId ?? '',
      courseProgressRepository: ref.watch(courseProgressRepositoryProvider),
      contentProgressRepository: ref.watch(contentProgressRepositoryProvider));
});
