import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/courses/domain/models/course.dart';
import 'package:luciapp/features/courses/presentation/state/course_page_colors.dart';
import 'package:luciapp/features/themes/data/providers/theme_mode_provider.dart';
import 'package:luciapp/features/themes/domain/enums/app_theme_mode.dart';

class CourseController extends StateNotifier<CoursePageColors> {
  AppThemeMode themeMode;
  CourseController({required this.themeMode})
      : super(CoursePageColors.defaultColors());

  void setCourseColors(Course course) {
    switch (themeMode) {
      case AppThemeMode.light:
        state = CoursePageColors.light(course.colors);
        break;
      case AppThemeMode.dark:
        state = CoursePageColors.dark(course.colors);
        break;
      case AppThemeMode.hcLight:
        state = CoursePageColors.hcLight(course.colors);
      case AppThemeMode.hcDark:
        state = CoursePageColors.hcDark(course.colors);
    }
  }
}

final courseColorsControllerProvider =
    StateNotifierProvider<CourseController, CoursePageColors>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  return CourseController(themeMode: themeMode);
});
