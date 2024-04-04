import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/course_progress/data/abstract_repositories/content_progress_repository.dart';
import 'package:luciapp/features/course_progress/data/abstract_repositories/course_progress_repository.dart';
import 'package:luciapp/features/course_progress/data/dto/complete_content_dto.dart';
import 'package:luciapp/features/course_progress/domain/models/content_progress.dart';
import 'package:luciapp/features/course_progress/domain/models/course_progress.dart';
import 'package:luciapp/main.dart';

class CompleteContentService {
  final ICourseProgressRepository _courseProgressRepository;
  final IContentProgressRepository _contentProgressRepository;

  CompleteContentService({
    required ICourseProgressRepository courseProgressRepository,
    required IContentProgressRepository contentProgressRepository,
  })  : _contentProgressRepository = contentProgressRepository,
        _courseProgressRepository = courseProgressRepository;

  Future<bool> completeContent(CompleteContentDto dto) async {
    try {
      final courseProgress =
          await getOrCreateCourseProgress(dto.userId, dto.courseId);

      final existingContentProgress = await _contentProgressRepository.get(
          dto.contentId, courseProgress.id);

      if (existingContentProgress == null) {
        await _contentProgressRepository.create(
            ContentProgress(completed: true, contentId: dto.contentId),
            courseProgress.id);

        final newPercentage = (100 / dto.nContents) + courseProgress.percentage;

        await _courseProgressRepository
            .update(courseProgress.copyWithPercentage(newPercentage.clank()));
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<CourseProgress> getOrCreateCourseProgress(
      UserId userId, String courseId) async {
    final courseProgress =
        await _courseProgressRepository.get(courseId, userId);

    if (courseProgress == null) {
      return await _courseProgressRepository.create(courseId, userId);
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

extension Clank on double {
  double clank() {
    if (this >= 99.8 && this <= 100.2) {
      return 100;
    }
    return this;
  }
}
