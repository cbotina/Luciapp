import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:luciapp/features/courses/presentation/widgets/colors/course_colors.dart';

class CoursePageColors {
  final Color progressBar;
  final Color progressBarBackground;
  final Color icons;
  final Color? borders;
  final Color? contentBackground;
  final Color? appBarBackground;
  final Color? backgroundColor;
  final Color appBarForeground;
  final Color appBarIcons;
  final Color main;
  final Color shadow;
  final Color accent;
  final Color letterDisabledBackground;
  final Color letterBagkround;
  final Color letterForeground;
  final Color? alphabetContainer;
  final Color falseForeground;
  final Color falseBackground;
  final Color trueForeground;
  final Color trueBackground;
  final Color falseBorder;
  final Color trueBorder;
  final List<Color>? gradientColors;

  CoursePageColors({
    required this.progressBar,
    required this.progressBarBackground,
    required this.icons,
    required this.appBarForeground,
    required this.appBarIcons,
    required this.shadow,
    required this.accent,
    required this.main,
    required this.letterBagkround,
    required this.letterForeground,
    required this.letterDisabledBackground,
    this.alphabetContainer,
    required this.falseForeground,
    required this.falseBackground,
    required this.trueForeground,
    required this.trueBackground,
    required this.falseBorder,
    required this.trueBorder,
    this.appBarBackground,
    this.backgroundColor,
    this.borders,
    this.gradientColors,
    this.contentBackground,
  });

  CoursePageColors.light(CloudCourseColors courseColors)
      : progressBar = courseColors.highlightColor,
        progressBarBackground = courseColors.shadowColor,
        gradientColors = [
          courseColors.mainColor,
          courseColors.shadowColor,
        ],
        icons = courseColors.mainColor,
        borders = null,
        contentBackground = null,
        appBarBackground = courseColors.mainColor,
        appBarForeground = Colors.white,
        backgroundColor = Color.alphaBlend(
            courseColors.mainColor.withOpacity(.2), Colors.white),
        appBarIcons = Colors.white,
        shadow = courseColors.shadowColor,
        accent = courseColors.highlightColor,
        main = courseColors.mainColor,
        letterBagkround = courseColors.shadowColor,
        letterForeground = Colors.white,
        letterDisabledBackground = courseColors.mainColor.withOpacity(.5),
        alphabetContainer = courseColors.mainColor.withOpacity(.5),
        falseForeground = Colors.white,
        falseBackground = const Color(0xffFF0C27),
        falseBorder = Colors.transparent,
        trueForeground = Colors.white,
        trueBackground = const Color(0xff1863FF),
        trueBorder = Colors.transparent;

  CoursePageColors.dark(CloudCourseColors courseColors)
      : progressBar = courseColors.shadowColor,
        progressBarBackground = courseColors.highlightColor,
        gradientColors = null,
        icons = courseColors.mainColor,
        borders = null,
        contentBackground = null,
        appBarBackground = null,
        appBarForeground = Colors.white,
        backgroundColor = null,
        appBarIcons = Colors.white,
        shadow = courseColors.shadowColor,
        accent = courseColors.highlightColor,
        main = courseColors.mainColor,
        letterBagkround = courseColors.mainColor,
        letterDisabledBackground = courseColors.mainColor.withOpacity(.5),
        letterForeground = Colors.white,
        alphabetContainer = null,
        falseForeground = Colors.white,
        falseBackground = const Color(0xffFF0C27),
        falseBorder = Colors.transparent,
        trueForeground = Colors.white,
        trueBackground = const Color(0xff1863FF),
        trueBorder = Colors.transparent;

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
        backgroundColor = null,
        appBarIcons = Colors.black,
        shadow = courseColors.shadowColor,
        accent = courseColors.highlightColor,
        main = courseColors.mainColor,
        letterBagkround = courseColors.highlightColor,
        letterForeground = Colors.black,
        letterDisabledBackground = Colors.white,
        alphabetContainer = Colors.black,
        falseForeground = Colors.black,
        falseBackground = const Color.fromARGB(255, 255, 120, 151),
        falseBorder = Colors.black,
        trueForeground = const Color.fromARGB(255, 0, 0, 0),
        trueBackground = const Color(0xff41e0ff),
        trueBorder = Colors.black;

  CoursePageColors.hcDark(CloudCourseColors courseColors)
      : progressBar = courseColors.highlightColor,
        progressBarBackground = const Color.fromARGB(255, 255, 255, 255),
        gradientColors = null,
        icons = courseColors.highlightColor,
        borders = courseColors.highlightColor,
        contentBackground = null,
        appBarBackground = null,
        appBarForeground = courseColors.highlightColor,
        backgroundColor = null,
        appBarIcons = courseColors.highlightColor,
        shadow = courseColors.shadowColor,
        accent = courseColors.highlightColor,
        main = courseColors.mainColor,
        letterBagkround = courseColors.highlightColor,
        letterForeground = Colors.black,
        letterDisabledBackground = Colors.black,
        alphabetContainer = Colors.transparent,
        falseForeground = Colors.white,
        falseBackground = Colors.black,
        falseBorder = const Color(0xffff0c27),
        trueForeground = const Color.fromARGB(255, 255, 255, 255),
        trueBackground = const Color.fromARGB(255, 0, 0, 0),
        trueBorder = const Color.fromARGB(255, 94, 207, 255);

  CoursePageColors.defaultColors()
      : progressBar = Colors.blue,
        progressBarBackground = const Color.fromARGB(255, 0, 0, 0),
        gradientColors = [Colors.white, Colors.white],
        icons = Colors.black,
        borders = Colors.black,
        contentBackground = null,
        appBarBackground = null,
        appBarForeground = Colors.black,
        backgroundColor = null,
        appBarIcons = Colors.black,
        shadow = Colors.blue.shade800,
        accent = Colors.blueAccent,
        main = Colors.blue,
        letterBagkround = Colors.blue,
        letterForeground = Colors.white,
        letterDisabledBackground = Colors.blueAccent.withOpacity(.5),
        alphabetContainer = Colors.blue.withOpacity(.5),
        falseForeground = Colors.white,
        falseBackground = const Color(0xffFF0C27),
        falseBorder = Colors.transparent,
        trueForeground = Colors.white,
        trueBackground = const Color(0xff1863FF),
        trueBorder = Colors.transparent;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CoursePageColors &&
        other.progressBar == progressBar &&
        other.progressBarBackground == progressBarBackground &&
        other.icons == icons &&
        other.borders == borders &&
        other.contentBackground == contentBackground &&
        other.appBarBackground == appBarBackground &&
        other.backgroundColor == backgroundColor &&
        other.appBarForeground == appBarForeground &&
        other.appBarIcons == appBarIcons &&
        other.main == main &&
        other.shadow == shadow &&
        other.accent == accent &&
        other.letterDisabledBackground == letterDisabledBackground &&
        other.letterBagkround == letterBagkround &&
        other.letterForeground == letterForeground &&
        other.alphabetContainer == alphabetContainer &&
        other.falseForeground == falseForeground &&
        other.falseBackground == falseBackground &&
        other.trueForeground == trueForeground &&
        other.trueBackground == trueBackground &&
        other.falseBorder == falseBorder &&
        other.trueBorder == trueBorder &&
        listEquals(other.gradientColors, gradientColors);
  }

  @override
  int get hashCode {
    return progressBar.hashCode ^
        progressBarBackground.hashCode ^
        icons.hashCode ^
        borders.hashCode ^
        contentBackground.hashCode ^
        appBarBackground.hashCode ^
        backgroundColor.hashCode ^
        appBarForeground.hashCode ^
        appBarIcons.hashCode ^
        main.hashCode ^
        shadow.hashCode ^
        accent.hashCode ^
        letterDisabledBackground.hashCode ^
        letterBagkround.hashCode ^
        letterForeground.hashCode ^
        alphabetContainer.hashCode ^
        falseForeground.hashCode ^
        falseBackground.hashCode ^
        trueForeground.hashCode ^
        trueBackground.hashCode ^
        falseBorder.hashCode ^
        trueBorder.hashCode ^
        gradientColors.hashCode;
  }
}
