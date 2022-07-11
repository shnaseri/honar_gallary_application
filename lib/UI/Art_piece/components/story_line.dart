import 'package:flutter/material.dart';

import '../../video_music_palyer/player_content.dart';

class Storyline extends StatelessWidget {
  const Storyline(this.storyline, {Key? key}) : super(key: key);
  final String storyline;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => PlayerContentPage(
                          content: '',
                          type: 'music',
                        )));
          },
          child: Text(
            'دل نوشته',
            style: textTheme.subtitle1!.copyWith(fontSize: 18.0),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          storyline,
          style: textTheme.bodyText1!.copyWith(
            color: Colors.white70,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 4.0),
        // No expand-collapse in this tutorial, we just slap the "more"
        // button below the text like in the mockup.
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     Text(
        //       'بیشتر',
        //       style: textTheme.bodyText1!
        //           .copyWith(fontSize: 14.0, color: Colors.white),
        //     ),
        //     Icon(
        //       Icons.keyboard_arrow_down,
        //       size: 15.0,
        //       color: Colors.white,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
