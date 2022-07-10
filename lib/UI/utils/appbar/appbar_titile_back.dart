import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/src/extensions/widget_extensions.dart';

import 'appbar.dart';

class AppBarTitleWithBack extends AppBarWidget {
  String title;

  AppBarTitleWithBack(BuildContext context, this.title, {Key? key})
      : super(key: key, parentContext: context);

  @override
  getActions() {
    // TODO: implement getActions
    return [
      const Center(
        child: Text(
          "بازگشت",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ).paddingRight(7),
      InkWell(
        onTap: () {
          Navigator.pop(parentContext);
        },
        child: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.1),
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ).paddingRight(10),
      ),
    ];
  }

  @override
  getLeading() {
    // TODO: implement getLeading
    return Container();
  }

  @override
  Widget getTitleWidget() {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize:
              Theme.of(parentContext).textTheme.headline6!.fontSize! * 0.8),
    );
  }
}
