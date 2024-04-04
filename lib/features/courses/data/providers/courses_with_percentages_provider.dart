import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/course_progress/domain/models/course_progress.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/active_content_controller.dart';
import 'package:luciapp/features/courses/domain/models/course_with_percentage.dart';
import 'package:luciapp/main.dart';

final coursesWithPercentagesProvider =
    FutureProvider<List<CourseWithPercentage>>((ref) async {
  final courses = ref.watch(coursesRepositoryProvider).getCourses();

  final coursesProgress =
      await ref.watch(courseProgressRepositoryProvider).getAll();

  final userId = ref.watch(activeContentControllerProvider).userId;

  return await courses.then((list) {
    return list.map((course) {
      final courseProgress =
          coursesProgress.findByCourseIdAndUserId(course.id, userId!);
      if (courseProgress != null) {
        return CourseWithPercentage(
          course: course,
          percentage: courseProgress.percentage,
        );
      } else {
        return CourseWithPercentage(
          course: course,
          percentage: 0.0,
        );
      }
    }).toList();
  });
});
