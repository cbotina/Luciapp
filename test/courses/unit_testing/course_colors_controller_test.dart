import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/courses/domain/models/course.dart';
import 'package:luciapp/features/courses/presentation/controllers/course_colors_controller.dart';
import 'package:luciapp/features/courses/presentation/state/course_page_colors.dart';
import 'package:luciapp/features/courses/presentation/widgets/colors/course_colors.dart';
import 'package:luciapp/features/themes/data/providers/theme_mode_provider.dart';
import 'package:luciapp/features/themes/domain/enums/app_theme_mode.dart';

void main() {
  group("Unit Test", () {
    late ProviderContainer container;
    late Course course;

    setUp(() {
      course = Course(
        colors: CloudCourseColors(
          highlightColor: Colors.yellow,
          mainColor: Colors.orange,
          shadowColor: Colors.orange.shade700,
        ),
        id: '1234',
        description: 'description',
        imagePath: 'photo.jpg',
        nContents: 10,
        name: 'Course',
      );
    });

    ProviderContainer makeProviderContainer(AppThemeMode appThemeMode) {
      final container = ProviderContainer(
        overrides: [
          themeModeProvider.overrideWithValue(appThemeMode),
        ],
      );
      addTearDown(container.dispose);
      return container;
    }

    test("[CP-064] Set course colors for light theme", () {
      const themeMode = AppThemeMode.light;
      container = makeProviderContainer(themeMode);
      final controller =
          container.read(courseColorsControllerProvider.notifier);

      controller.setCourseColors(course);

      expect(controller.state, CoursePageColors.light(course.colors));
    });

    test("[CP-065] Set course colors for dark theme", () {
      const themeMode = AppThemeMode.dark;
      container = makeProviderContainer(themeMode);
      final controller =
          container.read(courseColorsControllerProvider.notifier);

      controller.setCourseColors(course);

      expect(controller.state, CoursePageColors.dark(course.colors));
    });

    test("[CP-066] Set course colors for high contrast light theme", () {
      const themeMode = AppThemeMode.hcLight;
      container = makeProviderContainer(themeMode);
      final controller =
          container.read(courseColorsControllerProvider.notifier);

      controller.setCourseColors(course);

      expect(controller.state, CoursePageColors.hcLight(course.colors));
    });

    test("[CP-067] Set course colors for high contrast dark theme", () {
      const themeMode = AppThemeMode.hcDark;
      container = makeProviderContainer(themeMode);
      final controller =
          container.read(courseColorsControllerProvider.notifier);

      controller.setCourseColors(course);

      expect(controller.state, CoursePageColors.hcDark(course.colors));
    });
  });
}
