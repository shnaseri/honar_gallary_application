import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MoviePlayerPage extends StatefulWidget {
  final String content;
  const MoviePlayerPage({Key? key, required this.content}) : super(key: key);

  @override
  _MoviePlayerPageState createState() => _MoviePlayerPageState();
}

class _MoviePlayerPageState extends State<MoviePlayerPage> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(
            "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
            videoPlayerOptions: VideoPlayerOptions(
              allowBackgroundPlayback: true,
            )),
        autoInitialize: true);
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlickVideoPlayer(flickManager: flickManager);
  }
}