import 'package:flutter/material.dart';

class BlankPageComponent extends StatelessWidget {
  String noMessageChatPage = "هیچ پیامی هنوز ارسال نشده یه پیام بهش بده";

  BlankPageComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Container(
        //   height: 200,
        //   decoration: const BoxDecoration(
        //       image: DecorationImage(
        //           image: AssetImage(baseOfPathMedia + 'no_chat.png'))),
        // ),
        Text(
          noMessageChatPage,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: TextStyle(fontWeight: FontWeight.w800),
        )
      ],
    );
  }
}
