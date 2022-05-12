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
  int categoryItemSelectedId = -1;

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
              return GestureDetector(
                onTap: () {
                  setState(() {
                    categoryItemSelectedId = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: categoryItemSelectedId == index
                          ? ColorPallet.colorPalletDark.withOpacity(0.8)
                          : Colors.white,
                      border: Border.all(
                          color: categoryItemSelectedId == index
                              ? Colors.white70
                              : ColorPallet.colorPalletDark.withOpacity(0.8),
                          width: 1)),
                  child: Center(
                    child: Text(
                      'موسیقی',
                      style: TextStyle(
                          color: categoryItemSelectedId == index
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
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
