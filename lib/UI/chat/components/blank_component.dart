import 'package:flutter/material.dart';

class BlankPageComponent extends StatelessWidget {
  final String noMessageChatPage = "هیچ پیامی هنوز ارسال نشده یه پیام بهش بده";

  const BlankPageComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          decoration: const BoxDecoration(),
        ),
        Text(
          noMessageChatPage,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        )
      ],
    );
  }
}