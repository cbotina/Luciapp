import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/course_progress/domain/models/content_progress.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/active_content_controller.dart';
import 'package:luciapp/features/courses/domain/models/course_content.dart';
import 'package:luciapp/features/courses/domain/typedefs/course_id.dart';
import 'package:luciapp/features/courses/presentation/widgets/components/course_content_widget.dart';
import 'package:luciapp/main.dart';

class CourseContentsList extends ConsumerStatefulWidget {
  final CourseId courseId;
  const CourseContentsList({
    super.key,
    required this.courseId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CourseContentsListState();
}

class _CourseContentsListState extends ConsumerState<CourseContentsList> {
  void refresh() {
    setState(() {});
    build(context);
  }

  @override
  Widget build(BuildContext context) {
    final contents = ref.watch(contentsProgressProvider);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: contents.when(
        data: (data) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => CourseContentWidget(
              content: data[index].content,
              completed: data[index].completed,
            ),
            itemCount: data.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}

final contentsProgressProvider =
    FutureProvider<List<ContentWithProgress>>((ref) async {
  final courseId = ref.read(activeContentControllerProvider).courseId;

  final contents = ref
      .watch(courseContentsRepositoryProvider)
      .getCourseContents(courseId ?? "");

  final userId = ref.watch(activeContentControllerProvider).userId;

  List<ContentProgress> contentProgress;

  final progress = await ref
      .watch(courseProgressRepositoryProvider)
      .get(courseId ?? "", userId!);

  if (progress == null) {
    contentProgress = [];
  } else {
    contentProgress =
        await ref.watch(contentProgressRepositoryProvider).getAll(progress.id);
  }

  return contents.then(
    (list) => list.map((e) {
      final completed = contentProgress
          .contains(ContentProgress(completed: true, contentId: e.id));
      return ContentWithProgress(
        content: e,
        completed: completed,
      );
    }).toList(),
  );
});

class ContentWithProgress {
  final CourseContent content;
  final bool completed;

  ContentWithProgress({required this.content, required this.completed});
}
