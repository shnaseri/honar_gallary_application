import 'package:flutter/material.dart';
import 'package:honar_api_v11/api.dart';
import 'package:honar_gallary/UI/utils/numeral/Numeral.dart';
import 'package:honar_gallary/const/color_const.dart';

class RatingInformation extends StatelessWidget {
  const RatingInformation(this.movie, {Key? key}) : super(key: key);
  final ArtPiece movie;

  // Widget _buildRatingBar(ThemeData theme) {
  //   var stars = <Widget>[];
  //
  //   for (var i = 1; i <= 5; i++) {
  //     var color = i <= movie.starRating ? Colors.amber : Colors.white60;
  //     var star = Icon(
  //       Icons.star,
  //       color: color,
  //     );
  //
  //     stars.add(star);
  //   }
  //
  //   return Row(children: stars);
  // }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var ratingCaptionStyle = textTheme.caption!.copyWith(color: Colors.white);

    var numericRating = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          ' لایک ها',
          style: ratingCaptionStyle,
        ),
        const SizedBox(height: 4.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            movie.likeCount.toString(),
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
          ),
        ),
      ],
    );

    var starRating = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'قیمت',
          style: ratingCaptionStyle,
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          decoration: BoxDecoration(
              color: ColorPallet.colorPalletNightFog,
              borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            Numeral(movie.price).toString(),
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              numericRating,
              const SizedBox(width: 16.0),
              Expanded(child: starRating),
            ],
          ),
        ),
        const SizedBox(width: 26.0),
        // Expanded(
        //   flex: 1,
        //   child: Align(
        //     alignment: Alignment.center,
        //     child: Container(
        //       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        //       decoration: BoxDecoration(
        //           color: Colors.red, borderRadius: BorderRadius.circular(12)),
        //       child: const Text(
        //         'بمرانی',
        //         style:
        //             TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
