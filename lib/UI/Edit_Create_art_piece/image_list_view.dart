import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:nb_utils/nb_utils.dart';


final List<String> imgList = [
  'assets/images/sample1.jpg',
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
    return SizedBox(
      width: context.width(),
      child: CarouselSlider(
        items: imageSliders,
        carouselController: controller,
        options: CarouselOptions(
            autoPlay: false,
            aspectRatio: 1.3,
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

  final List<Widget> imageSliders = [
    const AddImageWidget(),
    ...imgList.map((item) => ImageSliderTile(item)).toList()
  ];
}

class AddImageWidget extends StatefulWidget {
  const AddImageWidget({Key? key}) : super(key: key);

  @override
  State<AddImageWidget> createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends State<AddImageWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      height: 80,
      decoration: const BoxDecoration(),
      child: DottedBorder(
        color: ColorPallet.colorPalletNightFog,
        strokeWidth: 1,
        child: Container(
          decoration: const BoxDecoration(),
          child: const Center(
            child: Icon(
              Icons.add,
            ),
          ),
        ),
      ),
    );
  }
}

class ImageSliderTile extends StatefulWidget {
  final String image;

  const ImageSliderTile(this.image, {Key? key}) : super(key: key);

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
    return GestureDetector(
      onLongPress: () {
        setState(() {
          showIcon = true;
          _myOpacity = 0.5;
        });
      },
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              AnimatedOpacity(
                opacity: _myOpacity,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(widget.image,
                      colorBlendMode: BlendMode.modulate),
                ),
              ),
              if (showIcon)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 80,
                        alignment: Alignment.center,
                        child: MaterialButton(
                          color: ColorPallet.colorPalletBlueGam,
                          child: const Text(
                            "حذف",
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9)),
                          onPressed: () {},
                        )),
                    10.width,
                    Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: MaterialButton(
                          color: ColorPallet.colorPalletDark.withAlpha(120),
                          child: const Text(
                            "لغو",
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9)),
                          onPressed: () {
                            setState(() {
                              showIcon = false;
                              _myOpacity = 1;
                            });
                          },
                        )),
                  ],
                )
            ],
          )),
    );
  }
}
