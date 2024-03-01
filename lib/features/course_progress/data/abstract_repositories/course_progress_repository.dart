import 'package:luciapp/features/course_progress/domain/models/course_progress.dart';

abstract class ICourseProgressRepository {
  Future<CourseProgress?> get(String courseId, String userId);

  Future<bool> create(String courseId, String userId);

  Future<void> delete(String cpId);
}
