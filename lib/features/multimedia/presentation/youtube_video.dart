import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/components/tappable_container.dart';
import 'package:luciapp/common/components/text_divider.dart';
import 'package:luciapp/features/courses/domain/models/course_content.dart';
import 'package:luciapp/features/courses/presentation/controllers/course_colors_controller.dart';
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
        onEnded: (metaData) {
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
