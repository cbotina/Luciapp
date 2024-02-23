import 'package:flutter/material.dart';
import 'package:luciapp/features/courses/presentation/widgets/colors/course_colors.dart';

class CoursePageColors {
  final Color progressBar;
  final Color progressBarBackground;
  final Color icons;
  final Color? borders;
  final Color? contentBackground;
  final Color? appBarBackground;
  final Color appBarForeground;
  final Color appBarIcons;
  final List<Color>? gradientColors;

  CoursePageColors({
    required this.progressBar,
    required this.progressBarBackground,
    required this.icons,
    required this.appBarForeground,
    required this.appBarIcons,
    this.appBarBackground,
    this.borders,
    this.gradientColors,
    this.contentBackground,
  });

  CoursePageColors.light(CloudCourseColors courseColors)
      : progressBar = courseColors.highlightColor,
        progressBarBackground = courseColors.shadowColor,
        gradientColors = [
          courseColors.mainColor,
          Color.alphaBlend(
              Colors.black.withOpacity(.2), courseColors.mainColor),
        ],
        icons = courseColors.mainColor,
        borders = null,
        contentBackground = null,
        appBarBackground = courseColors.mainColor,
        appBarForeground = Colors.white,
        appBarIcons = Colors.white;

  CoursePageColors.dark(CloudCourseColors courseColors)
      : progressBar = courseColors.shadowColor,
        progressBarBackground = courseColors.highlightColor,
        gradientColors = null,
        icons = courseColors.mainColor,
        borders = null,
        contentBackground = null,
        appBarBackground = null,
        appBarForeground = Colors.white,
        appBarIcons = Colors.white;

  CoursePageColors.hcLight(CloudCourseColors courseColors)
      : progressBar = courseColors.highlightColor,
        progressBarBackground = const Color.fromARGB(255, 0, 0, 0),
        gradientColors = [
          courseColors.highlightColor,
          courseColors.highlightColor
        ],
        icons = Colors.black,
        borders = Colors.black,
        contentBackground = courseColors.highlightColor,
        appBarBackground = courseColors.highlightColor,
        appBarForeground = Colors.black,
        appBarIcons = Colors.black;

  CoursePageColors.hcDark(CloudCourseColors courseColors)
      : progressBar = courseColors.highlightColor,
        progressBarBackground = const Color.fromARGB(255, 255, 255, 255),
        gradientColors = null,
        icons = courseColors.highlightColor,
        borders = courseColors.highlightColor,
        contentBackground = null,
        appBarBackground = null,
        appBarForeground = courseColors.highlightColor,
        appBarIcons = courseColors.highlightColor;

  CoursePageColors.defaultColors()
      : progressBar = Colors.blue,
        progressBarBackground = const Color.fromARGB(255, 0, 0, 0),
        gradientColors = [Colors.white, Colors.white],
        icons = Colors.black,
        borders = Colors.black,
        contentBackground = null,
        appBarBackground = null,
        appBarForeground = Colors.black,
        appBarIcons = Colors.black;
}
