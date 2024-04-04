import 'package:luciapp/features/courses/domain/models/course.dart';

abstract class CoursesRepository {
  Future<List<Course>> getCourses();
}
