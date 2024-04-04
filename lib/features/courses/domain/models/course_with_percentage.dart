import 'package:luciapp/features/courses/domain/models/course.dart';

class CourseWithPercentage {
  final Course course;
  final double percentage;

  CourseWithPercentage({
    required this.course,
    required this.percentage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseWithPercentage &&
          runtimeType == other.runtimeType &&
          course == other.course &&
          percentage == other.percentage;

  @override
  int get hashCode => Object.hash(course, percentage);
}
