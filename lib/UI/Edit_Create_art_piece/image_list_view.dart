
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:honar_gallary/const/color_const.dart';
//
// import '../../const/color_const.dart';

final List<AssetImage> imgList = [
  const AssetImage('assets/images/sample1.jpg'),
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

  // int _demonstrateIcon = 0;
  // int _exitCounter = 0;
  double x = 0.0;
  double y = 0.0;

  void _showIcon(PointerEvent details) {
    setState(() {
      // _demonstrateIcon = 1;
    });
  }

  void _hideIcon(PointerEvent details) {
    setState(() {
      // _demonstrateIcon = 0;
    });
  }


  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.tight(const Size(300.0, 200.0)),
    child: MouseRegion(
    onEnter: _showIcon,
    // onHover: _updateLocation,
    onExit: _hideIcon,
    child: Container(
    height: context.height(),
    width: context.width(),
    decoration: const BoxDecoration(color: Colors.white),
    child: Stack(
    children: [
    Column(children: [
    CarouselSlider(
    items: imageSliders,
    carouselController: controller,
    options: CarouselOptions(
    autoPlay: true,
    enlargeCenterPage: true,
    aspectRatio: 2.0,
    onPageChanged: (index, reason) {
    // setState(() {
    // current = index;
    // });
    }),
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: imgList.asMap().entries.map((entry) {
    return GestureDetector(
    onTap: () => controller.animateToPage(entry.key),
    child: Container(
    width: 12.0,
    height: 12.0,
    margin: const EdgeInsets.symmetric(
    vertical: 8.0, horizontal: 4.0),
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: (Theme.of(context).brightness ==
    Brightness.dark
    ? Colors.white
        : Colors.white)
        .withOpacity(current == entry.key ? 0.9 : 0.4)),
    ),
    );
    }).toList(),
    ),
    ]),
    ]),
    )
    )
    );
  }
  final List<Widget> imageSliders = imgList
      .map((item) => Container(
    child: Container(
      margin: const EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Container(
                  decoration: new BoxDecoration(color: Colors.white),
                  alignment: Alignment.center,
                  height: 240,
                  child: Image(
                    image: item,
                  ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.favorite),
              )

            ],
          )),
    ),
  ))
      .toList();
}
