import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:petstore_api/api.dart';

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
        return InkWell(
          onLongPress: () {
            BlocProvider.of<ChatCubit>(context).deleteMessage(index);
          },
          child: Container(
            padding:
                const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
            child: Align(
              alignment: (!message.isUserSender
                  ? Alignment.topRight
                  : Alignment.topLeft),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: (!(message.isUserSender)
                        ? ColorPallet.colorPalletNightFog
                        : ColorPallet.colorPalletPurpleRain)),
                padding: const EdgeInsets.all(16),
                child: Text(
                  message.content ?? " ",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
