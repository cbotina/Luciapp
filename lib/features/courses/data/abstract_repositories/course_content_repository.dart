import 'package:luciapp/features/courses/domain/models/course_content.dart';
import 'package:luciapp/features/courses/domain/typedefs/course_id.dart';

abstract class CourseContentsRepository {
  Future<List<CourseContent>> getCourseContents(CourseId id);
}
