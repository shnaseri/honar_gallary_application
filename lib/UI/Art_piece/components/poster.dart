import 'package:flutter/material.dart';

class Poster extends StatelessWidget {
  static const posterRatio = 0.7;

  const Poster(
    this.posterUrl, {
    Key? key,
    this.height = 100.0,
  }) : super(key: key);

  final String posterUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    var width = posterRatio * height;

    return Material(
      borderRadius: BorderRadius.circular(4.0),
      elevation: 2.0,
      child: Image.asset(
        posterUrl,
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }
}
