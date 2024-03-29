import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/course_progress/domain/models/course_progress.dart';
import 'package:luciapp/features/courses/domain/typedefs/course_id.dart';

abstract class ICourseProgressRepository {
  Future<CourseProgress?> get(CourseId courseId, UserId userId);

  Future<CourseProgress> create(CourseId courseId, UserId userId);

  Future<bool> update(CourseProgress courseProgress);

  Future<void> delete(String cpId);

  Future<List<CourseProgress>> getAll();
}
