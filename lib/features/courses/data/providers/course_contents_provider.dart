import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/courses/domain/models/course_content.dart';
import 'package:luciapp/features/courses/domain/typedefs/course_id.dart';
import 'package:luciapp/main.dart';

final courseContentsProvider =
    FutureProvider.family<List<CourseContent>, CourseId>((ref, id) async {
  return ref.watch(courseContentsRepositoryProvider).getCourseContents(id);
});
