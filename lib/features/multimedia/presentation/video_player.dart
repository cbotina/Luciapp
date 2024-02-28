import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    super.key,
    required this.path,
  });

  final String path;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  late ChewieController _chewieController;

  @override
  void initState() {
    // ignore: deprecated_member_use
    _videoPlayerController = VideoPlayerController.network(widget.path);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      looping: false,
      fullScreenByDefault: true,
      autoPlay: true,
      placeholder: Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    _videoPlayerController.addListener(_onVideoFinished);
    super.initState();
  }

  void _onVideoFinished() {
    if (_videoPlayerController.value.position ==
        _videoPlayerController.value.duration) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Chewie(controller: _chewieController),
        ),
      ),
    );
  }
}
