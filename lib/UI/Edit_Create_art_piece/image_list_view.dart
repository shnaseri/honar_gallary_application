import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
    return ConstrainedBox(
        constraints: BoxConstraints.tight(const Size(450.0, 200.0)),
        child: Container(
          height: context.height(),
          width: context.width(),
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(children: [
            Column(children: [
              CarouselSlider(
                items: imageSliders,
                carouselController: controller,
                options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      // setState(() {
                      // current = index;
                      // });
                    }),
              ),
            ]),
          ]),
        ));
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
      child: MouseRegion(
        onHover: (value) {
          setState(() {
            showIcon = true;
            _myOpacity = 0.5;
          });
        },
        onExit: (value) {
          setState(() {
            showIcon = false;
            _myOpacity = 1;
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
                      decoration: const BoxDecoration(color: Colors.white),
                      alignment: Alignment.center,
                      height: 240,
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
                        decoration: const BoxDecoration(color: Colors.white),
                        alignment: Alignment.center,
                        height: 240,
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
                    Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                            onTap: () => print("icon clicked"),
                            child: const Image(
                              image: AssetImage("images/wrong1.png"),
                              width: 50,
                              height: 50,
                            )))
                ],
              )),
        ),
      ),
    );
  }
}
