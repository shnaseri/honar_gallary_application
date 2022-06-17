import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_api_v11/api.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../state_managment/chat/chat_cubit.dart';
import 'blank_component.dart';
import 'message_tile.dart';

class BodyOfChatPage extends StatefulWidget {
  final Function addMessageFunction;

  BodyOfChatPage({Key? key, required this.addMessageFunction})
      : super(key: key);

  @override
  State<BodyOfChatPage> createState() => _BodyOfChatPageState();
}

class _BodyOfChatPageState extends State<BodyOfChatPage> {
  late ScrollController controller;
  String lastDate = "";

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        lastDate = " ";
        print(state);
        if (state is ChatSendMessage) {
          print('add message');
          print(state.message);
          widget.addMessageFunction(state.message);
        }
        if (state is ChatConnectToServer) {
          if (state.messages.isEmpty) {
            return BlankPageComponent().paddingBottom(100);
          }

          WidgetsBinding.instance!.addPostFrameCallback((_) => _endOfScroll());
          return ListView.builder(
            controller: controller,
            padding: EdgeInsets.only(bottom: context.width() * 0.16, top: 10),
            itemBuilder: (context, index) {
              Message message = state.messages[index];
              var date = Gregorian(message.createdAt.year,
                  message.createdAt.month, message.createdAt.day);
              var dateFormatter = date.toJalali().formatter;
              String dateString = "${dateFormatter.d} ${dateFormatter.mN}";
              bool showDate = lastDate != dateString;
              lastDate = dateString;
              return Column(
                children: [
                  showDate
                      ? Container(
                          width: 59,
                          height: 22,
                          decoration: boxDecorationWithRoundedCorners(
                              backgroundColor: const Color(0xffF2F2F2),
                              borderRadius: BorderRadius.circular(32)),
                          child: Text(
                            dateString,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xff828282)),
                          ),
                        )
                      : Container(),
                  MessageTile(message: message, index: index),
                ],
              );
            },
            itemCount: state.messages.length,
          );
        }
        return Container();
      },
    );
  }

  _endOfScroll() {
    controller.jumpTo(controller.position.maxScrollExtent);
  }
}