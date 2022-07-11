import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_9.dart';
import 'package:honar_api_v22/api.dart';
import 'package:honar_gallary/const/color_const.dart';

import '../../../state_managment/chat/chat_cubit.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
    Key? key,
    required this.message,
    required this.index,
  }) : super(key: key);

  final Message message;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return ChatBubble(
          elevation: 1,
          clipper: ChatBubbleClipper9(
              type: message.isUserSender!
                  ? BubbleType.sendBubble
                  : BubbleType.receiverBubble),
          alignment: message.isUserSender!
              ? Alignment.centerRight
              : Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          backGroundColor: message.isUserSender!
              ? ColorPallet.colorPalletNightFog
              : ColorPallet.colorPalletSambucus,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.content!,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  message.createdAt!.hour.toString() +
                      ":" +
                      message.createdAt!.minute.toString(),
                  style: TextStyle(color: Colors.white60, fontSize: 10),
                ),
              ],
            ),
          ),
        );
        // return InkWell(
        //   onLongPress: () {
        //     BlocProvider.of<ChatCubit>(context).deleteMessage(index);
        //   },
        //   child: Container(
        //     padding:
        //         const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
        //     child: Align(
        //       alignment: (!message.isUserSender
        //           ? Alignment.topRight
        //           : Alignment.topLeft),
        //       child: Container(
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(8),
        //             color: (!(message.isUserSender)
        //                 ? ColorPallet.colorPalletNightFog
        //                 : ColorPallet.colorPalletPurpleRain)),
        //         padding: const EdgeInsets.all(16),
        //         child: Text(
        //           message.content ?? " ",
        //           style: const TextStyle(
        //               color: Colors.white,
        //               fontSize: 15,
        //               fontWeight: FontWeight.w700),
        //         ),
        //       ),
        //     ),
        //   ),
        // );
      },
    );
  }
}
