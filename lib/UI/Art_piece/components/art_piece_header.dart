import 'package:flutter/material.dart';
import 'package:honar_api_v3/api.dart';
import 'package:honar_gallary/UI/Art_piece/components/poster.dart';
import 'package:honar_gallary/UI/Art_piece/components/rating_information.dart';
import 'package:honar_gallary/UI/video_music_palyer/components/arc_banner.dart';
import 'package:honar_gallary/UI/video_music_palyer/player_content.dart';
import 'package:honar_gallary/const/color_const.dart';

import 'models.dart';

class MovieDetailHeader extends StatelessWidget {
  const MovieDetailHeader(this.movie, this.artPiece, {Key? key})
      : super(key: key);
  final Movie movie;
  final ArtPiece artPiece;

  List<Widget> _buildCategoryChips(TextTheme textTheme) {
    return movie.categories.map((category) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Chip(
          label: Text(category),
          labelStyle: TextStyle(color: ColorPallet.colorPalletBlueGam),
          backgroundColor: Colors.black12,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title,
          style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 8.0),
        RatingInformation(artPiece),
        const SizedBox(height: 12.0),
        Row(children: _buildCategoryChips(textTheme)),
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 165.0),
          child: ArcBannerImageOnline(movie.bannerUrl),
        ),
        Positioned(
          bottom: 0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlayerContentPage(
                                type: artPiece.type,
                                content: artPiece.url,
                              )));
                },
                child: Poster(
                  artPiece,
                  height: 180.0,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(child: movieInformation),
            ],
          ),
        ),
      ],
    );
  }
}
