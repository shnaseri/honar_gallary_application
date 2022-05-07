import 'package:flutter/material.dart';
import 'package:honar_gallary/const/color_const.dart';

import 'models.dart';

class RatingInformation extends StatelessWidget {
  const RatingInformation(this.movie, {Key? key}) : super(key: key);
  final Movie movie;

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
          movie.rating.toString(),
          style: textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'تعداد لایک ها',
          style: ratingCaptionStyle,
        ),
      ],
    );

    var starRating = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
              color: ColorPallet.colorPalletNightFog,
              borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            "9.0",
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          'قیمت',
          style: ratingCaptionStyle,
        ),
      ],
    );

    return Row(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            numericRating,
            const SizedBox(width: 16.0),
            starRating,
          ],
        ),
        const SizedBox(width: 25.0),
        Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(12)),
            child: const Text(
              'بمرانی',
              style:
                  TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
