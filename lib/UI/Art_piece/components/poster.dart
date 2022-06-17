import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:honar_api_v13/api.dart';
import 'package:nb_utils/nb_utils.dart';

class Poster extends StatelessWidget {
  static const posterRatio = 0.7;

  const Poster(
    this.artpiece, {
    Key? key,
    this.height = 100.0,
  }) : super(key: key);

  final ArtPiece artpiece;
  final double height;

  @override
  Widget build(BuildContext context) {
    var width = posterRatio * height;

    return Container(
      height: context.height() * 0.2,
      width: context.width() * 0.3,
      child: Stack(
        // fit: StackFit.passthrough,
        children: [
          CachedNetworkImage(
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: imageProvider)),
              );
            },
            placeholder: (context, strImage) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(
                    width: 2.0,
                  ),
                ),
              );
            },
            imageUrl: artpiece.cover.image,
            height: context.height() * 0.2,
            width: context.width() * 0.3,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black54,
            ),
            child: Center(
              child: artpiece.type == "picture"
                  ? Icon(Icons.search_rounded)
                  : Icon(Icons.play_arrow_rounded),
            ),
          )
        ],
      ),
    );
  }
}
