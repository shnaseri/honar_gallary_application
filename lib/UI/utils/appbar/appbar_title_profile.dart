import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/extensions/widget_extensions.dart';

import 'appbar.dart';

class AppBarTitleProfile extends AppBarWidget {
  final String title;
  final BuildContext context;
  final int index;
  final Function functionBack;

  AppBarTitleProfile(this.context, this.index,
      {Key? key, required this.title, required this.functionBack})
      : super(key: key, parentContext: context);

  @override
  Widget getTitleWidget() {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: Theme.of(context).textTheme.headline6!.fontSize! * 0.8),
    );
  }

  @override
  getActions() {
    // TODO: implement getActions
    return [
      const Center(
        child: Text(
          "بازگشت",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ).paddingRight(7),
      InkWell(
        onTap: () {
          Navigator.pop(parentContext);
          functionBack();
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
    return Padding(
      padding: EdgeInsets.only(left: 15),
      child: CachedNetworkImage(
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image:
                    DecorationImage(fit: BoxFit.cover, image: imageProvider)),
          );
        },
        placeholder: (context, strImage) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
          );
        },
        imageUrl: 'https://picsum.photos/id/237/200/300',
        fit: BoxFit.fill,
        height: context.height() * 0.05,
        width: context.width(),
      ),
    );
  }
}
