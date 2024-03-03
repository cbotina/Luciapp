import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/components/tappable_container.dart';
import 'package:luciapp/common/components/text_divider.dart';
import 'package:luciapp/common/extensions/int_to_duration.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/active_content_controller.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/complete_content_controller.dart';
import 'package:luciapp/features/courses/data/providers/courses_provider.dart';
import 'package:luciapp/features/courses/domain/models/course_content.dart';
import 'package:luciapp/features/courses/presentation/controllers/course_colors_controller.dart';
import 'package:luciapp/features/courses/presentation/widgets/course_content_list.dart';
import 'package:luciapp/features/font_size/presentation/controllers/font_size_controller.dart';
import 'package:luciapp/main.dart';
import 'package:luciapp/pages/game_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtVideo extends ConsumerStatefulWidget {
  final CourseContent video;
  const YtVideo({super.key, required this.video});

  @override
  ConsumerState<YtVideo> createState() => _YtVideoState();
}

class _YtVideoState extends ConsumerState<YtVideo> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.url!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        isLive: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(courseColorsControllerProvider);
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        progressColors: ProgressBarColors(
          playedColor: colors.main,
          handleColor: colors.accent,
        ),
        width: 6,
        onEnded: (metaData) async {
          ref
              .read(completeContentControllerProvider.notifier)
              .completeContent();

          ref.invalidate(courseContentsRepositoryProvider);

          Navigator.of(context).pop();
        },
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              widget.video.name,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: colors.appBarForeground),
            ),
            iconTheme: IconThemeData(color: colors.appBarIcons),
            backgroundColor: colors.appBarBackground,
          ),
          body: ListView(
            children: [
              player,
              const SizedBox(height: 20),
              const TextDivider('Transcripción'),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TappableContainer(
                  onPressed: () {},
                  child: Text(widget.video.transcription ?? ""),
                ),
              )
            ],
          ),
          backgroundColor: colors.backgroundColor,
        );
      },
    );
  }
}

void showScoreDialog(BuildContext context, WidgetRef ref) {
  final scaleFactor =
      ref.watch(fontSizeControllerProvider).value?.scaleFactor ?? 1.0;

  const bodySize = 15;
  const titleSize = 20;
  const buttonTextSize = 18;

  AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    headerAnimationLoop: false,
    dialogType: DialogType.success,
    showCloseIcon: false,
    btnOkOnPress: () {
      ref.invalidate(courseContentsRepositoryProvider);
      Navigator.of(context).pop();
    },
    btnOkText: 'Continuar',
    buttonsTextStyle: TextStyle(
      fontSize: buttonTextSize * scaleFactor,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    btnOkColor: Colors.blue,
    dismissOnTouchOutside: false,
    dismissOnBackKeyPress: false,
    body: Column(
      children: [
        Text(
          'Bien hecho!',
          style: TextStyle(
            fontSize: titleSize * scaleFactor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'terminaste el video',
          style: TextStyle(fontSize: bodySize * scaleFactor),
          textAlign: TextAlign.center,
        )
      ],
    ),
  ).show();
}
