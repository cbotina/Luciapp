import 'package:flutter/material.dart';
import 'package:luciapp/features/multimedia/presentation/video_player.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({
    super.key,
    required this.path,
  });
  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoPlayer(path: path),
    );
  }
}
