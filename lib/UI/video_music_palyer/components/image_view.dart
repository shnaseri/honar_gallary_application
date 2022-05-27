import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ImageShowPage extends StatefulWidget {
  final String content;
  const ImageShowPage({Key? key, required this.content}) : super(key: key);

  @override
  State<ImageShowPage> createState() => _ImageShowPageState();
}

class _ImageShowPageState extends State<ImageShowPage> {
  _showimage() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: CachedNetworkImage(
          color: Colors.white,
          imageUrl: widget.content,
          imageBuilder: (context, imageProvider) {
            return Container(
              width: context.width(),
              height: context.height() * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain, image: imageProvider)),
            );
          },
          placeholder: (context, url) {
            return Container(
              height: context.height() * 0.3,
              width: context.width(),
              decoration: const BoxDecoration(color: Colors.grey),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body: Center(child: _showimage()));
  }
}
