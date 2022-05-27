import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../logic/string_repository.dart';

class TextTopOfPage extends StatelessWidget {
  const TextTopOfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        titleOfLoginPage,
        textDirection: TextDirection.rtl,
        style: primaryTextStyle(
            color: Colors.white,
            size:
                Theme.of(context).textTheme.headline2?.fontSize!.toInt() ?? 50,
            weight: FontWeight.w600),
      ),
    );
  }
}
