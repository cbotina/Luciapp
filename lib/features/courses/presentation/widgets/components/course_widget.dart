// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/components/tappable_container.dart';
import 'package:luciapp/common/utils/page_wrapper.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/active_content_controller.dart';
import 'package:luciapp/features/courses/presentation/controllers/course_colors_controller.dart';
import 'package:luciapp/features/courses/domain/models/course.dart';
import 'package:luciapp/features/themes/data/providers/is_dark_mode_enabled_provider.dart';
import 'package:luciapp/features/themes/data/providers/is_hc_mode_enabled_provider.dart';
import 'package:luciapp/pages/course_page.dart';
import 'package:ribbon_widget/ribbon_widget.dart';

class CourseWidget extends ConsumerWidget {
  const CourseWidget({
    required this.course,
    super.key,
    this.isNew = false,
    required this.percentageCompleted,
  });

  final Course course;
  final bool isNew;
  final double percentageCompleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hc = ref.watch(isHcModeEnabledProvider);
    final dark = ref.watch(isDarkModeEnabledProvider);

    final borderColor = dark && hc
        ? course.colors.mainColor
        : hc
            ? Colors.black
            : null;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Ribbon(
          nearLength: isNew ? 80 : 0,
          farLength: isNew ? 30 : 0,
          title: 'Nuevo!',
          titleStyle: TextStyle(
            color: Theme.of(context).colorScheme.onTertiary,
            fontFamily: 'Lilita',
            fontSize: 18,
          ),
          color: Theme.of(context).colorScheme.tertiary,
          location: RibbonLocation.topEnd,
          child: TappableContainer(
            onPressed: () {
              ref
                  .read(courseColorsControllerProvider.notifier)
                  .setCourseColors(course);

              ref
                  .read(activeContentControllerProvider.notifier)
                  .setCourseId(course.id);

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return PageWrapper(CoursePage(course: course));
                  },
                ),
              );
            },
            splashColor: course.colors.mainColor,
            borderColor: borderColor,
            child: Column(
              children: [
                Text(
                  course.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth - 20 - 20 - 120,
                          child: Text(
                            course.description,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    Image(
                      image: Image.network(course.imagePath).image,
                      width: 110,
                      height: 110,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                LinearProgressIndicator(
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  color: course.colors.mainColor,
                  value: percentageCompleted,
                  borderRadius: BorderRadius.circular(20),
                  minHeight: 15,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
