import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/audio_player.dart';
import 'components/image_view.dart';
import 'components/video_player.dart';

class PlayerContentPage extends StatefulWidget {
  final String type;
  final String content;

  const PlayerContentPage({Key? key, required this.type, required this.content})
      : super(key: key);

  @override
  State<PlayerContentPage> createState() => _PlayerContentPageState();
}

class _PlayerContentPageState extends State<PlayerContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(4, 9, 35, 1),
                  Color.fromRGBO(39, 105, 171, 1),
                ],
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
              ),
            ),
          ),
          playerContentSelector(),
        ],
      ),
    );
  }

  Widget playerContentSelector() {
    if (widget.type == "movie") {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: MoviePlayerPage(
          content: widget.content,
        ),
      );
    }
    if (widget.type == "music") {
      return AudioPlayerPage(
        content: widget.content,
      );
    }
    return ImageShowPage(
      content: widget.content,
    );
  }
}