import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:honar_api_v17/api.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../const/color_const.dart';
import '../../../state_managment/chat/chat_cubit.dart';
import '../../video_music_palyer/player_content.dart';
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
        if (state is ChatConnectingToServer) {
          return const ConnectingPageComponent().paddingBottom(100);
        }
        if (state is ChatErrorState) {
          return const ErrorPageComponent().paddingBottom(100);
        }
        if (state is ChatConnectToServer) {
          if (state.messages.isEmpty) {
            return const BlankPageComponent().paddingBottom(100);
          }

          WidgetsBinding.instance!.addPostFrameCallback((_) => _endOfScroll());
          return ListView.builder(
            controller: controller,
            padding: EdgeInsets.only(bottom: context.width() * 0.16, top: 10),
            itemBuilder: (context, index) {
              Message message = state.messages[index];
              print(message.type);
              var date = Gregorian(message.createdAt!.year,
                  message.createdAt!.month, message.createdAt!.day);
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
                  if (message.type == "T" || message.type == "text")
                    MessageTile(message: message, index: index),
                  if (message.type == "P" || message.type == "picture")
                    PictureTile(message: message, index: index)
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

class PictureTile extends StatefulWidget {
  final Message message;
  final int index;

  const PictureTile({
    Key? key,
    required this.message,
    required this.index,
  }) : super(key: key);

  @override
  State<PictureTile> createState() => _PictureTileState();
}

class _PictureTileState extends State<PictureTile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: ChatBubble(
        elevation: 1,
        clipper: ChatBubbleClipper1(
            type: widget.message.isUserSender!
                ? BubbleType.sendBubble
                : BubbleType.receiverBubble),
        alignment: widget.message.isUserSender!
            ? Alignment.centerRight
            : Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        backGroundColor: widget.message.isUserSender!
            ? ColorPallet.colorPalletNightFog
            : ColorPallet.colorPalletSambucus,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlayerContentPage(
                                type: "picture",
                                content: widget.message.content!,
                              )));
                },
                child: CachedNetworkImage(
                    color: Colors.white,
                    imageUrl: widget.message.content!,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        width: context.width(),
                        height: context.height() * 0.3,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain, image: imageProvider)),
                      );
                    },
                    placeholder: (context, url) {
                      return Container(
                        height: context.height() * 0.3,
                        width: context.width(),
                        decoration: const BoxDecoration(color: Colors.grey),
                      );
                    }),
              ),
              Text(
                widget.message.createdAt!.hour.toString() +
                    ":" +
                    widget.message.createdAt!.minute.toString(),
                style: TextStyle(color: Colors.white60, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
