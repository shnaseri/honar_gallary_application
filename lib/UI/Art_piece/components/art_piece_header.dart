import 'package:flutter/material.dart';
import 'package:honar_api_v22/api.dart';
import 'package:honar_gallary/UI/Art_piece/components/poster.dart';
import 'package:honar_gallary/UI/Art_piece/components/rating_information.dart';
import 'package:honar_gallary/UI/video_music_palyer/components/arc_banner.dart';
import 'package:honar_gallary/UI/video_music_palyer/player_content.dart';
import 'package:honar_gallary/const/color_const.dart';

class MovieDetailHeader extends StatelessWidget {
  const MovieDetailHeader(this.artPiece, {Key? key}) : super(key: key);
  final ArtPiece artPiece;

  List<Widget> _buildCategoryChips(TextTheme textTheme, ArtPiece artPiece) {
    return [artPiece.category].map((category) {
      return GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Chip(
            label: Text(category == null ? " " : category.name),
            labelStyle: TextStyle(color: ColorPallet.colorPalletBlueGam),
            backgroundColor: Colors.black12,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    print(artPiece.cover.image);
    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          artPiece.title!,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 8.0),
        RatingInformation(artPiece),
        const SizedBox(height: 12.0),
        Row(children: _buildCategoryChips(textTheme, artPiece)),
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 165.0),
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlayerContentPage(
                              type: "picture",
                              content: artPiece.cover.image!,
                            )));
              },
              child: ArcBannerImageOnline(artPiece.cover.image!)),
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
                                type: artPiece.type!,
                                content: artPiece.type! == "picture"
                                    ? artPiece.cover.image!
                                    : artPiece.url!,
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
