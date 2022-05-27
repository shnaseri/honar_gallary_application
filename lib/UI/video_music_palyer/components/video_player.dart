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
            "http://188.121.110.151:9006/art-pieces/2022-5-27/2022-05-27_11.41.47.mp4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=negare-user%2F20220527%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220527T071210Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=fd222d9045e43f1fe158ad57c1b4f2ad274ebaef17982d0566b52bce52b6aa93",
            videoPlayerOptions: VideoPlayerOptions(
              allowBackgroundPlayback: true,
            )),
        autoPlay: true,
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