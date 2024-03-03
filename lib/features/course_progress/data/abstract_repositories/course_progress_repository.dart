import 'package:luciapp/features/course_progress/domain/models/course_progress.dart';

abstract class ICourseProgressRepository {
  Future<CourseProgress?> get(String courseId, String userId);

  Future<CourseProgress> create(String courseId, String userId);

  Future<bool> update(CourseProgress courseProgress);

  Future<void> delete(String cpId);

  Future<List<CourseProgress>> getAll();
}
