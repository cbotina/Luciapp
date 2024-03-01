import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/course_progress/data/abstract_repositories/content_progress_repository.dart';
import 'package:luciapp/features/course_progress/data/abstract_repositories/course_progress_repository.dart';
import 'package:luciapp/features/course_progress/domain/models/course_progress.dart';
import 'package:luciapp/main.dart';

class CompleteContentService {
  CompleteContentService({
    required ICourseProgressRepository courseProgressRepository,
    required IContentProgressRepository contentProgressRepository,
  });

  Future<bool> completeContent() {
    // final courseProgress = getOrCreateCourseProgress();
    // TODO: implement completeContent
    // getorcreatecourseprogress
    // llamar a repositorio
    throw UnimplementedError();
  }

  Future<CourseProgress> getOrCreateCourseProgress() {
    // TODO: implement this
    throw UnimplementedError();
  }
}

final completeContentServiceProvider = Provider<CompleteContentService>((ref) {
  return CompleteContentService(
      courseProgressRepository: ref.watch(courseProgressRepositoryProvider),
      contentProgressRepository: ref.watch(contentProgressRepositoryProvider));
});
