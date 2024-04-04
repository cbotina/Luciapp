import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/courses/domain/models/course.dart';
import 'package:luciapp/main.dart';

final coursesProvider = FutureProvider<List<Course>>((ref) async {
  return ref.watch(coursesRepositoryProvider).getCourses();
});
