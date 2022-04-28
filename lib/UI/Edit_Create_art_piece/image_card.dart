
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// final List<String> imgList2 = [
//   'assets/images/mafia1.jpg',
//   'assets/images/mafia1.jpg',
//   'assets/images/mafia1.jpg',
//   'assets/images/mafia1.jpg'
// ];

import 'package:honar_gallary/UI/Art_piece/art_piece_model.dart';

// import 'package:flutter/material.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../const/color_const.dart';

final List<AssetImage> imgList = [
  const AssetImage('assets/images/sample1.jpg'),
  // const AssetImage('assets/images/mafia2.jpg'),
  // const AssetImage('assets/images/mafia3.jpg'),
  // const AssetImage('assets/images/mafia4.jpg')
];

class ImageCardWidget extends StatelessWidget {
  ImageCardWidget({
    Key? key,
    required this.ap,
  }) : super(key: key);

  final ArtPiece ap;
  final String item = 'assets/images/mafia1.jpg';

  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width() * 0.51,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
          boxShadow: defaultBoxShadow(),
          borderRadius: BorderRadius.circular(12)),
      child: IntrinsicHeight(
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(color: ColorPallet.colorPalletPurpleRain, width: 10),
              // const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: <Widget>[
                    // CachedNetworkImage(
                    //   placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                    //   imageUrl: mFavouriteList[index].image,
                    //   width: width / 5,
                    //   height: 100,
                    // ),


                    Expanded(
                      flex: 2,
                      child: Hero(
                          tag: ap.id.toString() + "profile",
                          child: CachedNetworkImage(
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(8)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: imageProvider)),
                              );
                            },
                            placeholder: (context, strImage) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5)),
                                  color: Colors.grey,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                              );
                            },
                            imageUrl: 'https://hips.hearstapps.com/ghk.h-cdn.co/assets/17/30/2560x1280/landscape-1500925839-golden-retriever-puppy.jpg?resize=480:*',
                            fit: BoxFit.fill,
                            height: context.height() * 0.15,
                            width: context.width(),
                          )),
                    ),
                    // const SizedBox(width: 10,height: 10,),


                    const SizedBox(height: 5),

                    10.height,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}