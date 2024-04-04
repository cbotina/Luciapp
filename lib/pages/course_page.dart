import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/components/header_container.dart';
import 'package:luciapp/common/components/text_divider.dart';
import 'package:luciapp/features/courses/domain/enums/content_types.dart';
import 'package:luciapp/features/courses/presentation/controllers/course_colors_controller.dart';
import 'package:luciapp/features/courses/domain/models/course.dart';
import 'package:luciapp/features/courses/presentation/widgets/course_content_list.dart';
import 'package:luciapp/features/multimedia/presentation/youtube_video.dart';

class CoursePage extends ConsumerWidget {
  final Course course;

  const CoursePage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.read(courseColorsControllerProvider);

    ref.listen(
      completedContentProvider,
      (previous, next) {
        showScoreDialog(context, ref, 'Terminaste el contenido!');
      },
    );

    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: AppBar(
        title: Text(course.name,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: colors.appBarForeground)),
        backgroundColor:
            colors.gradientColors != null ? colors.appBarBackground : null,
        centerTitle: true,
        iconTheme: IconThemeData(color: colors.appBarIcons),
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

class ContentCompletedNotifier extends StateNotifier<ContentTypes?> {
  ContentCompletedNotifier() : super(null);

  void setCompletedContentType(ContentTypes type) {
    state = type;
  }
}

final completedContentProvider =
    StateNotifierProvider<ContentCompletedNotifier, ContentTypes?>((ref) {
  return ContentCompletedNotifier();
});
