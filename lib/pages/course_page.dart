import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/components/header_container.dart';
import 'package:luciapp/common/components/tappable_container.dart';
import 'package:luciapp/common/components/text_divider.dart';
import 'package:luciapp/features/courses/data/providers/course_colors_controller.dart';
import 'package:luciapp/features/courses/data/providers/course_contents_provider.dart';
import 'package:luciapp/features/courses/domain/enums/content_types.dart';
import 'package:luciapp/features/courses/domain/models/course.dart';
import 'package:luciapp/features/courses/domain/models/course_content.dart';
import 'package:luciapp/features/courses/presentation/widgets/colors/course_colors.dart';
import 'package:luciapp/features/courses/presentation/widgets/course_content_list.dart';
import 'package:luciapp/features/themes/data/providers/is_dark_mode_enabled_provider.dart';
import 'package:luciapp/features/themes/data/providers/is_hc_mode_enabled_provider.dart';
import 'package:luciapp/features/themes/data/providers/theme_mode_provider.dart';
import 'package:luciapp/features/themes/domain/enums/app_theme_mode.dart';
import 'package:luciapp/features/themes/presentation/state/theme_state.dart';

class CoursePageColors {
  final Color gradientTop;
  final Color gradientBottom;
  final Color progressBar;
  final Color progressBarBackground;
  final Color titleFont;
  final Color icons;
  final Color? borders;
  final Color? contentBackground;
  final List<Color>? gradientColors;

  CoursePageColors({
    required this.gradientTop,
    required this.gradientBottom,
    required this.progressBar,
    required this.progressBarBackground,
    required this.titleFont,
    required this.icons,
    this.borders,
    this.gradientColors,
    this.contentBackground,
  });

  CoursePageColors.light(CloudCourseColors courseColors)
      : gradientTop = courseColors.mainColor,
        gradientBottom = Color.alphaBlend(
            Colors.black.withOpacity(.2), courseColors.mainColor),
        progressBar = courseColors.highlightColor,
        progressBarBackground = courseColors.shadowColor,
        gradientColors = [
          courseColors.mainColor,
          Color.alphaBlend(
              Colors.black.withOpacity(.2), courseColors.mainColor),
        ],
        titleFont = Colors.white,
        icons = courseColors.mainColor,
        borders = null,
        contentBackground = null;

  CoursePageColors.dark(CloudCourseColors courseColors)
      : gradientTop = const Color(0xff121212),
        gradientBottom = const Color(0xff2D2D2D),
        progressBar = courseColors.shadowColor,
        progressBarBackground = courseColors.highlightColor,
        gradientColors = null,
        titleFont = Colors.white,
        icons = courseColors.mainColor,
        borders = null,
        contentBackground = null;

  CoursePageColors.hcLight(CloudCourseColors courseColors)
      : gradientTop = courseColors.highlightColor,
        gradientBottom = const Color.fromARGB(255, 255, 255, 255),
        progressBar = courseColors.highlightColor,
        progressBarBackground = const Color.fromARGB(255, 0, 0, 0),
        gradientColors = [
          courseColors.highlightColor,
          courseColors.highlightColor
        ],
        titleFont = Colors.black,
        icons = Colors.black,
        borders = Colors.black,
        contentBackground = courseColors.highlightColor;

  CoursePageColors.hcDark(CloudCourseColors courseColors)
      : gradientTop = const Color.fromARGB(255, 0, 0, 0),
        gradientBottom = const Color.fromARGB(255, 0, 0, 0),
        progressBar = courseColors.highlightColor,
        progressBarBackground = const Color.fromARGB(255, 255, 255, 255),
        gradientColors = null,
        titleFont = courseColors.highlightColor,
        icons = courseColors.highlightColor,
        borders = courseColors.highlightColor,
        contentBackground = null;

  CoursePageColors.defaultColors()
      : gradientTop = const Color.fromARGB(255, 255, 255, 255),
        gradientBottom = const Color.fromARGB(255, 255, 255, 255),
        progressBar = Colors.blue,
        progressBarBackground = const Color.fromARGB(255, 0, 0, 0),
        gradientColors = [Colors.white, Colors.white],
        titleFont = Colors.black,
        icons = Colors.black,
        borders = Colors.black,
        contentBackground = null;
}

class CoursePage extends ConsumerWidget {
  final Course course;

  const CoursePage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.read(courseColorsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(course.name,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: colors.titleFont)),
        backgroundColor:
            colors.gradientColors != null ? colors.gradientTop : null,
        centerTitle: true,
        iconTheme: IconThemeData(color: colors.icons),
      ),
      body: ListView(
        children: [
          HeaderContainer(
            gradientColors: colors.gradientColors,
            child: Hero(
              tag: 'img',
              child: Image.network(
                course.imagePath,
                height: 250,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const TextDivider("Contenidos"),
          const SizedBox(height: 10),
          CourseContentsList(
            courseId: course.id,
          ),
        ],
      ),
    );
  }
}

class CourseContentWidget extends ConsumerWidget {
  final CourseContent content;
  const CourseContentWidget({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.read(courseColorsControllerProvider);

    IconData getIcon(ContentTypes type) {
      switch (type) {
        case ContentTypes.video:
          return Icons.play_circle;
        case ContentTypes.game:
          return Icons.videogame_asset;
      }
    }

    return TappableContainer(
      onPressed: () {},
      padding: 5,
      borderColor: colors.borders,
      backgroundColor: colors.contentBackground,
      child: ListTile(
        leading: Icon(
          getIcon(content.type),
          size: Theme.of(context).textTheme.headlineLarge!.fontSize! * 1.3,
          color: colors.icons,
        ),
        title: Text(
          content.name,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          content.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
