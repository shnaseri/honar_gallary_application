import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../Art_piece/components/arc_banner_image.dart';
import 'arc_banner.dart';

AudioPlayer audioPlayer = AudioPlayer();
var ap = AudioCache(fixedPlayer: audioPlayer);

playonline() async {
  ap.clearAll();
  await audioPlayer.play(
      'https://raw.githubusercontent.com/sparsh308/sample_musics/master/Alan%20Walker%20-%20Faded.mp3');
}

class AudioPlayerPage extends StatefulWidget {
  final String content;

  const AudioPlayerPage({Key? key, required this.content}) : super(key: key);

  @override
  AudioPlayerPageState createState() {
    return AudioPlayerPageState();
  }
}

class AudioPlayerPageState extends State<AudioPlayerPage> {
  late bool playAudio;

  @override
  void initState() {
    playonline();
    // TODO: implement initState
    playAudio = true;
    super.initState();
  }

  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    await stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 0.0),
              child: ArcBannerImageOnline(
                  "https://facts.net/wp-content/uploads/2020/01/close-up-photography-of-cat-1183434-730x486.jpg"),
            ),
            // Container(
            //   width: 150,
            //   height: 150,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(200),
            //       image: const DecorationImage(
            //           image: NetworkImage(
            //               'https://yt3.ggpht.com/a/AATXAJxeXNRjpkdWUrpb4zEzRwDZAhYPOzO0irIZkPwMIQ=s900-c-k-c0xffffffff-no-rj-mo'))),
            // ),
            // Container(
            //   height: 50,
            //   child: StreamBuilder<MediaState>(
            //     stream: _mediaStateStream,
            //     builder: (context, snapshot) {
            //       final mediaState = snapshot.data;
            //       return SeekBar(
            //         duration:
            //         mediaState?.mediaItem?.duration ?? Duration.zero,
            //         position: mediaState?.position ?? Duration.zero,
            //         onChangeEnd: (newPosition) {
            //           AudioService.seekTo(newPosition);
            //         },
            //       );
            //     },
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (playAudio)
                      IconButton(
                        icon: const Icon(Icons.pause_rounded),
                        onPressed: () {
                          setState(() {
                            playAudio = !playAudio;
                          });
                          stop();
                        },
                        iconSize: 50,
                      ),
                    if (!playAudio)
                      IconButton(
                        icon: const Icon(Icons.play_arrow_rounded),
                        focusColor: Colors.black,
                        onPressed: () {
                          setState(() {
                            playAudio = !playAudio;
                          });
                          playonline();
                        },
                        iconSize: 50,
                      ),
                    const IconButton(
                      icon: const Icon(Icons.stop_rounded),
                      onPressed: stop,
                      iconSize: 50,
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              'music alan walker - faded.mp3',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  SeekBar({
    required this.duration,
    required this.position,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }
}
