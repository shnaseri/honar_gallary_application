// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:honar_gallary/UI/Art_piece/art_piece_model.dart';

class ArtPiecePage extends StatefulWidget {
  const ArtPiecePage({Key? key}) : super(key: key);

  @override
  _ArtPiecePageState createState() => _ArtPiecePageState();
}

class _ArtPiecePageState extends State<ArtPiecePage> {
  static List<ArtPiece> mList = [
    ArtPiece(
      id: 1,
      name: 'بازی مافیا',
      description: 'برگزاری بازی مافیا به صورت گروهی به همراه جایزه',
      imageUrl: '',
      discount: 10,
      ownerId: 2,
      startTime: DateTime(2020),
      finishTime: DateTime(2021),
      // comments: [],
    ),
    ArtPiece(
      id: 1,
      name: 'بازی مافیا',
      description: 'برگزاری بازی مافیا به صورت گروهی به همراه جایزه',
      imageUrl: '',
      discount: 10,
      ownerId: 2,
      startTime: DateTime(2020),
      finishTime: DateTime(2021),
      // comments: [],
    ),
    ArtPiece(
      id: 1,
      name: 'بازی مافیا',
      description: 'برگزاری بازی مافیا به صورت گروهی به همراه جایزه',
      imageUrl: '',
      discount: 10,
      ownerId: 2,
      startTime: DateTime(2020),
      finishTime: DateTime(2021),
      // comments: [],
    ),
    ArtPiece(
      id: 1,
      name: 'بازی مافیا',
      description: 'برگزاری بازی مافیا به صورت گروهی به همراه جایزه',
      imageUrl: '',
      discount: 10,
      ownerId: 2,
      startTime: DateTime(2020),
      finishTime: DateTime(2021),
      // comments: [],
    ),
    ArtPiece(
      id: 1,
      name: 'بازی مافیا',
      description: 'برگزاری بازی مافیا به صورت گروهی به همراه جایزه',
      imageUrl: '',
      discount: 10,
      ownerId: 2,
      startTime: DateTime(2020),
      finishTime: DateTime(2021),
      // comments: [],
    ),
    ArtPiece(
      id: 1,
      name: 'بازی مافیا',
      description: 'برگزاری بازی مافیا به صورت گروهی به همراه جایزه',
      imageUrl: '',
      discount: 10,
      ownerId: 2,
      startTime: DateTime(2020),
      finishTime: DateTime(2021),
      // comments: [],
    ),
    ArtPiece(
      id: 1,
      name: 'بازی مافیا',
      description: 'برگزاری بازی مافیا به صورت گروهی به همراه جایزه',
      imageUrl: '',
      discount: 10,
      ownerId: 2,
      startTime: DateTime(2020),
      finishTime: DateTime(2021),
      // comments: [],
    ),
  ];

  // ColorPallet my_pallete = new ColorPallet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorPallet.colorPalletPurpleRain,
      body: SafeArea(
        child: PageView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 1.3,
                  margin: const EdgeInsets.fromLTRB(16, 30, 16, 16),
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(16),
                              topLeft: Radius.circular(16)),
                          // child: CachedNetworkImage(
                          //   placeholder: placeholderWidgetFn() as Widget Function(
                          //       BuildContext, String)?,
                          //   imageUrl: t9_climb,
                          //   fit: BoxFit.cover,
                          //   height: MediaQuery.of(context).size.height * 0.3,
                          //   width: MediaQuery.of(context).size.width,
                          // ),
                          child: Image.network(
                              'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif')),
                      const SizedBox(height: 16),
                      const Text('leanardo davinchi pic'),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          t9OptionDescription('total', 'type'),
                          t9OptionDescription('total', 'type'),
                          t9OptionDescription('total', 'type'),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: const <Widget>[
                      Icon(
                        Icons.keyboard_arrow_up,
                        // color: t9_textColorSecondary,
                        color: Colors.grey,
                      ),
                      // text(t9_lbl_swipe_up_to_show_course_contents,
                      //     textColor: t9_textColorSecondary)
                      Text('swip up to show')
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.topRight,
                    margin: const EdgeInsets.all(16.0),
                    child: const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 20,
                    )),
                // text(t9_lbl_project_management,
                //     textColor: appStore.textPrimaryColor,
                //     fontSize: textSizeNormal,
                //     fontFamily: fontMedium),
                const Text('decaprio pic'),
                const SizedBox(height: 10),

                //hamon dokme sabze chert :)

                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            // backgroundImage:
                            // CachedNetworkImageProvider(t9_ic_profile),
                            backgroundColor: Colors.brown.shade800,
                            radius: MediaQuery.of(context).size.height * 0.025,
                          ),
                          const SizedBox(width: 16),
                          // text(t9_lbl_hannah_tran, textColor: t9_colorPrimary)
                          const Text('hosein mehdi tabar')
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyText2,
                          children: const [
                            WidgetSpan(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  // color: t9_yellow,
                                  size: 16,
                                ),
                              ),
                            ),
                            TextSpan(
                              // text: t9_lbl_5_0,
                              text: '5.0',
                              // style: TextStyle(
                              //     fontSize: textSizeMedium,
                              //     color: t9_yellow,
                              //     fontFamily: fontMedium)
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: mList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // return Container();
                      return T9Question(mList[index], index);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class T9Question extends StatelessWidget {
  final ArtPiece model;

  const T9Question(this.model, int pos, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: <Widget>[
          const Text("1"),
          // text("1", textColor: t9_textColorSecondary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // text(model.name,
                //     textColor: appStore.textPrimaryColor,
                //     fontFamily: fontMedium,
                //     fontSize: textSizeLargeMedium,
                //     maxLine: 2,
                //     isLongText: true),
                // text(model.subtitle,
                //     textColor: appStore.textSecondaryColor,
                //     isLongText: true,
                //     maxLine: 2),
                // text(model.type, textColor: t9_colorPrimary)
                Text(model.name),
                Text(model.description),
                Text(model.name),
              ],
            ),
          )
        ],
      ),
    );
  }
}


Widget t9OptionDescription(var total, var type) {
  return Container(
    margin: const EdgeInsets.only(left: 16, right: 16),
    child: Column(
      children: const <Widget>[
        // CachedNetworkImage(
        //     placeholder:
        //     placeholderWidgetFn() as Widget Function(BuildContext, String)?,
        //     imageUrl: t9_ic_cup,
        //     height: 20,
        //     width: 20),
        // SizedBox(height: 4),
        // text(total,
        //     textColor: appStore.textPrimaryColor,
        //     fontFamily: fontMedium,
        //     isLongText: true),
        // text(type, textColor: appStore.textSecondaryColor),
        Icon(Icons.favorite,
          color: Colors.pink,
          size: 24.0,),
        Text('price'),
        Text('heading'),
      ],
    ),
  );
}

