import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/components/tappable_container.dart';
import 'package:luciapp/common/utils/page_wrapper.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/active_content_controller.dart';
import 'package:luciapp/features/courses/domain/enums/content_types.dart';
import 'package:luciapp/features/courses/domain/models/course_content.dart';
import 'package:luciapp/features/courses/presentation/controllers/course_colors_controller.dart';
import 'package:luciapp/features/multimedia/presentation/youtube_video.dart';
import 'package:luciapp/pages/game_page.dart';

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
      onPressed: () {
        ref
            .read(activeContentControllerProvider.notifier)
            .setCourseId(content.id);

        if (content.type == ContentTypes.game) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return PageWrapper(GamePage(gameId: content.gameId!));
              },
            ),
          );
        } else if (content.type == ContentTypes.video) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return PageWrapper(YtVideo(video: content));
            },
          ));
        }
      },
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
