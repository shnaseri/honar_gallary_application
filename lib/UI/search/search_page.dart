import 'package:flutter/material.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:nb_utils/nb_utils.dart';

import 'components/search_text_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(4, 9, 35, 1),
                        Color.fromRGBO(39, 105, 171, 1),
                      ],
                      begin: FractionalOffset.bottomCenter,
                      end: FractionalOffset.topCenter,
                    ),
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 100,
                        child: Align(
                          alignment: const Alignment(0, 1.5),
                          child: TextFieldSearchWidget(
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.height(),
                        width: context.width(),
                        child: DraggableScrollableSheet(
                            expand: true,
                            minChildSize: 0.8,
                            initialChildSize: 0.82,
                            builder: (context, listScrollController) {
                              return Container(
                                  decoration: boxDecorationWithRoundedCorners(
                                      backgroundColor: Colors.white,
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(40),
                                          topLeft: Radius.circular(40))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: BodySearchWidget(
                                        controller: listScrollController),
                                  ));
                            }),
                      )
                    ],
                  )),
            ),
          ),
        ));
  }
}

class BodySearchWidget extends StatefulWidget {
  final ScrollController controller;

  const BodySearchWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<BodySearchWidget> createState() => _BodySearchWidgetState();
}

class _BodySearchWidgetState extends State<BodySearchWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.controller,
      scrollDirection: Axis.vertical,
      children: [
        const SizedBox(
          height: 25,
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 7),
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: ColorPallet.colorPalletDark.withOpacity(0.8),
                        width: 1)),
              );
            },
            itemCount: 10,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }
}
