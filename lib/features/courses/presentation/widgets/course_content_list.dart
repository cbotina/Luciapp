import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/data/providers/user_id_provider.dart';
import 'package:luciapp/features/course_progress/domain/models/content_progress.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/active_content_controller.dart';
import 'package:luciapp/features/courses/data/providers/course_contents_provider.dart';
import 'package:luciapp/features/courses/data/providers/courses_provider.dart';
import 'package:luciapp/features/courses/domain/models/course_content.dart';
import 'package:luciapp/features/courses/domain/typedefs/course_id.dart';
import 'package:luciapp/features/courses/presentation/widgets/components/course_content_widget.dart';
import 'package:luciapp/features/courses/presentation/widgets/components/course_widget.dart';
import 'package:luciapp/main.dart';
import 'package:luciapp/pages/game_page.dart';

// class CourseContentsList extends ConsumerWidget {
//   final CourseId courseId;
//   const CourseContentsList({
//     super.key,
//     required this.courseId,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // ref.invalidate(courseContentsProvider);

//     ref.invalidate(courseProgressProvider(courseId)); //1

//     final contents = ref.watch(courseProgressProvider(courseId));
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: contents.when(
//         data: (data) {
//           return ListView.separated(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemBuilder: (context, index) => data[index],
//             itemCount: data.length,
//             separatorBuilder: (context, index) => const SizedBox(height: 10),
//           );
//         },
//         error: (error, stackTrace) => Text(error.toString()),
//         loading: () => const CircularProgressIndicator(),
//       ),
//     );
//   }
// }

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
    // print('CONTENT ID:');
    // print(ref.read(activeContentControllerProvider).contentId);
    // print('COURSE ID:');
    // print(ref.read(activeContentControllerProvider).courseId);
    // print('USER ID:');
    // print(ref.read(activeContentControllerProvider).userId);
    ref.invalidate(courseProgressProvider); //1

    final contents = ref.watch(courseProgressProvider2);

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

final courseProgressProvider =
    FutureProvider<List<CourseContentWidget>>((ref) async {
  final courseId = ref.read(activeContentControllerProvider).courseId;

// cambia a read
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
      return CourseContentWidget(
        content: e,
        completed: completed,
      );
    }).toList(),
  );
});

final courseProgressProvider2 =
    FutureProvider<List<CourseProgress>>((ref) async {
  final courseId = ref.read(activeContentControllerProvider).courseId;

// cambia a read
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
      return CourseProgress(
        content: e,
        completed: completed,
      );
    }).toList(),
  );
});

class CourseProgress {
  final CourseContent content;
  final bool completed;

  CourseProgress({required this.content, required this.completed});
}
// final courseProgressProvider =
//     StreamProvider.family<List<CourseContentWidget>, CourseId>(
//         (ref, courseId) async* {
//   final contents = ref
//       .watch(courseContentsRepositoryProvider)
//       .getCourseContentsStream(courseId);

//   final userId = ref.watch(userIdProvider);

//   List<ContentProgress> contentProgress;
//   final progress =
//       await ref.watch(courseProgressRepositoryProvider).get(courseId, userId!);

//   if (progress == null) {
//     contentProgress = [];
//   } else {
//     contentProgress =
//         await ref.watch(contentProgressRepositoryProvider).getAll(progress.id);
//   }

//   await for (var list in contents) {
//     yield list.map((e) {
//       final completed = contentProgress
//           .contains(ContentProgress(completed: true, contentId: e.id));
//       return CourseContentWidget(
//         content: e,
//         completed: completed,
//       );
//     }).toList();
//   }
// });


