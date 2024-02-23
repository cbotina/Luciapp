import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/extensions/int_to_duration.dart';
import 'package:luciapp/features/courses/data/providers/courses_provider.dart';
import 'package:luciapp/features/courses/domain/models/course.dart';
import 'package:luciapp/features/courses/presentation/widgets/components/course_widget.dart';

class CourseListWidget extends ConsumerWidget {
  const CourseListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(coursesProvider);

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(0.ms);
        ref.invalidate(coursesProvider);
      },
      child: ListView(
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
              IconButton(
                onPressed: () {
                  ref.invalidate(coursesProvider);
                },
                icon: const Icon(
                  Icons.refresh_sharp,
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
                    Course course = courses.elementAt(index);
                    return CourseWidget(
                      course: course,
                      percentageCompleted: .78,
                      isNew: true,
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
      ),
    );
  }
}
