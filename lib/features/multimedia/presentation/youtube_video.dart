// ignore_for_file: unused_result, use_build_context_synchronously

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/components/tappable_container.dart';
import 'package:luciapp/common/components/text_divider.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/complete_content_controller.dart';
import 'package:luciapp/features/courses/domain/enums/content_types.dart';
import 'package:luciapp/features/courses/domain/models/course_content.dart';
import 'package:luciapp/features/courses/presentation/controllers/course_colors_controller.dart';
import 'package:luciapp/features/courses/presentation/widgets/course_list.dart';
import 'package:luciapp/features/font_size/presentation/controllers/font_size_controller.dart';
import 'package:luciapp/main.dart';
import 'package:luciapp/pages/course_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends ConsumerStatefulWidget {
  final CourseContent video;
  const VideoScreen({super.key, required this.video});

  @override
  ConsumerState<VideoScreen> createState() => _YtVideoState();
}

class _YtVideoState extends ConsumerState<VideoScreen> {
  YoutubePlayerController? _controller;
  late AudioPlayer player;

  @override
  void initState() {
    player = AudioPlayer();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.url!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        isLive: false,
        controlsVisibleAtStart: false,
        hideThumbnail: true,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    _controller!.dispose();
    super.dispose();
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
          await ref
              .read(completeContentControllerProvider.notifier)
              .completeContent();

          await player.play(
            AssetSource('audio/contentfinish.mp3'),
          );
          const Duration(milliseconds: 500);

          ref.refresh(completedContentProvider);
          ref
              .read(completedContentProvider.notifier)
              .setCompletedContentType(ContentTypes.video);

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

void showScoreDialog(BuildContext context, WidgetRef ref, String message) {
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
      ref.invalidate(coursesWithPercentagesProvider);
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
          'Muy Bien!',
          style: TextStyle(
            fontSize: titleSize * scaleFactor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          message,
          style: TextStyle(fontSize: bodySize * scaleFactor),
          textAlign: TextAlign.center,
        )
      ],
    ),
  ).show();
}
