// import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:nb_utils/nb_utils.dart';

// import 'package:flutter/material.dart';
// import 'package:honar_gallary/const/color_const.dart';
//
// import '../../const/color_const.dart';

final List<String> imgList = [
  'assets/images/sample1.jpg',
  // const AssetImage('assets/images/mafia2.jpg'),
  // const AssetImage('assets/images/mafia3.jpg'),
  // const AssetImage('assets/images/mafia4.jpg')
];

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int current = 0;
  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      child: CarouselSlider(
        items: imageSliders,
        carouselController: controller,
        options: CarouselOptions(
            autoPlay: false,
            aspectRatio: 1,
            enableInfiniteScroll: false,
            disableCenter: false,
            onPageChanged: (index, reason) {
              // setState(() {
              // current = index;
              // });
            }),
      ),
    );
  }

  final List<Widget> imageSliders =
      imgList.map((item) => ImageSliderTile(item)).toList();
}

class ImageSliderTile extends StatefulWidget {
  String image;

  ImageSliderTile(this.image);

  @override
  State<ImageSliderTile> createState() => _ImageSliderTileState();
}

class _ImageSliderTileState extends State<ImageSliderTile> {
  late bool showIcon;
  late double _myOpacity;

  @override
  void initState() {
    super.initState();
    showIcon = false;
    _myOpacity = 1;
  }

  @override
  Widget build(BuildContext context) {
    // double heigt = context.height();
    // double width = context.width();
    return Container(
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            showIcon = true;
            _myOpacity = 0.5;
            print("1");
          });
        },
        child: Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  if (!showIcon)
                    Container(
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage(widget.image),
                      ),
                    ),
                  // if(showIcon)
                  //   Container(
                  //     decoration: new BoxDecoration(color: Colors.white),
                  //     alignment: Alignment.center,
                  //     height: 240,
                  //     child: Image.asset(widget.image, color: Colors.white.withOpacity(0.8), colorBlendMode: BlendMode.modulate),
                  //   ),
                  if (showIcon)
                    AnimatedOpacity(
                      opacity: _myOpacity,
                      duration: const Duration(milliseconds: 20000),
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(widget.image,
                            color: Colors.white.withOpacity(0.8),
                            colorBlendMode: BlendMode.modulate),
                      ),
                    ),

                  // if(showIcon)
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: GestureDetector(
                  //     onTap: () => print("icon clicked"),
                  //     child: Icon(Icons.close,
                  //     color: Colors.red,
                  //     size: context.width() * 0.15,),
                  //   ),
                  // ),
                  if (showIcon)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 80,
                            alignment: Alignment.center,
                            child: MaterialButton(
                              color: ColorPallet.colorPalletBlueGam,
                              child: Text(
                                "حذف",
                                style: TextStyle(color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(9)),
                              onPressed: () {},
                            )),
                        10.width,
                        Container(
                            width: 60,
                            alignment: Alignment.center,
                            child: MaterialButton(
                              color: ColorPallet.colorPalletDark.withAlpha(120),
                              child: Text(
                                "لغو",
                                style: TextStyle(color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(9)),
                              onPressed: () {
                                setState(() {
                                  showIcon = false;
                                });
                              },
                            )),
                      ],
                    )
                ],
              )),
        ),
      ),
    );
  }
}
