import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/course_progress/domain/models/course_progress.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/active_content_controller.dart';
import 'package:luciapp/features/courses/domain/models/course.dart';
import 'package:luciapp/features/courses/domain/typedefs/course_id.dart';
import 'package:luciapp/features/courses/presentation/widgets/components/course_widget.dart';
import 'package:luciapp/main.dart';

class CourseListWidget extends ConsumerWidget {
  const CourseListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.invalidate(coursesWithPercentagesProvider);
    final coursesAsync = ref.watch(coursesWithPercentagesProvider);

    return ListView(
      padding: const EdgeInsets.all(15),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      addRepaintBoundaries: false,
      children: [
        Row(
          children: [
            Text(
              "Contenidos",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: Divider(
                  height: 36,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            Semantics(
              label: 'Refrescar',
              child: IconButton(
                onPressed: () {
                  ref.invalidate(coursesWithPercentagesProvider);
                },
                icon: const Icon(
                  Icons.refresh_sharp,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        coursesAsync.when(
          data: (courses) {
            return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Course course = courses.elementAt(index).course;
                  return CourseWidget(
                    course: course,
                    percentageCompleted:
                        courses.elementAt(index).percentage / 100,
                    isNew: courses.elementAt(index).percentage == 0,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemCount: courses.length);
          },
          error: (e, _) {
            return Text(e.toString());
          },
          loading: () {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            );
          },
          skipLoadingOnRefresh: false,
        ),
      ],
    );
  }
}

class CourseWithPercentage {
  final Course course;
  final double percentage;

  CourseWithPercentage({
    required this.course,
    required this.percentage,
  });
}

final coursesWithPercentagesProvider =
    FutureProvider<List<CourseWithPercentage>>((ref) async {
  final courses = ref.watch(coursesRepositoryProvider).getCourses();

  final coursesProgress =
      await ref.watch(courseProgressRepositoryProvider).getAll();

  final userId = ref.watch(activeContentControllerProvider).userId;

  return courses.then((list) {
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

extension Find on List<CourseProgress> {
  CourseProgress? findByCourseIdAndUserId(CourseId courseId, UserId userId) {
    for (CourseProgress cp in this) {
      if (cp.courseId == courseId && cp.userId == userId) return cp;
    }
    return null;
  }
}
