import 'package:flutter/material.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../search/search_page.dart';
import '../../utils/auto_text_direction.dart';

class TextFieldSearchWidget extends StatefulWidget {
  final Function(String) onChanged;

  const TextFieldSearchWidget({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<TextFieldSearchWidget> createState() => _TextFieldSearchWidgetState();
}

class _TextFieldSearchWidgetState extends State<TextFieldSearchWidget> {
  String value = "";

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      widthFactor: 0.7,
      child: GestureDetector(
        onTap: () {
          pushNewScreen(
            context,
            screen: const SearchPage(),
            withNavBar: false, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        },
        child: AutoDirection(
          text: value,
          child: TextFormField(
            enabled: false,
            onTap: () {
              print("fsf");
            },
            onChanged: (String text) {
              setState(() {
                value = text;
              });
              widget.onChanged(text);
            },
            autofocus: false,
            cursorColor: ColorPallet.colorPalletNightFog,
            decoration: InputDecoration(
                alignLabelWithHint: true,
                filled: true,
                fillColor: ColorPallet.colorPalletSambucus,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                focusColor: ColorPallet.colorPalletNightFog,
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)))),
          ),
        ),
      ),
    );
  }
}
