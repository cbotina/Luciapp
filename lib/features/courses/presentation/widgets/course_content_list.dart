import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/courses/data/providers/course_contents_provider.dart';
import 'package:luciapp/features/courses/domain/typedefs/course_id.dart';
import 'package:luciapp/features/courses/presentation/widgets/components/course_content_widget.dart';

class CourseContentsList extends ConsumerWidget {
  final CourseId courseId;
  const CourseContentsList({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.invalidate(courseContentsProvider);
    final contents = ref.read(courseContentsProvider(courseId));
    return Padding(
      padding: const EdgeInsets.all(10),
      child: contents.when(
        data: (data) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                CourseContentWidget(content: data[index]),
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
