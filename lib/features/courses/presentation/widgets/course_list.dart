import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/attributions/data/providers/about_text_provider.dart';
import 'package:luciapp/features/courses/data/providers/courses_with_percentages_provider.dart';
import 'package:luciapp/features/courses/domain/models/course.dart';
import 'package:luciapp/features/courses/presentation/widgets/components/course_widget.dart';

class CourseListWidget extends ConsumerWidget {
  const CourseListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              child: ExcludeSemantics(
                child: IconButton(
                  onPressed: () {
                    ref.invalidate(coursesWithPercentagesProvider);
                    ref.invalidate(aboutTextProvider);
                  },
                  icon: const Icon(
                    Icons.refresh_sharp,
                  ),
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
            if (courses.isEmpty) {
              return const Text("No se han publicado cursos aún");
            } else {
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
                itemCount: courses.length,
              );
            }
          },
          error: (e, _) {
            return const Text(
                'Es necesario estar conectado a internet para acceder a los cursos');
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
