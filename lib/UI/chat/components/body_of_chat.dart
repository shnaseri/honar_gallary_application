import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_9.dart';
import 'package:honar_api_v19/api.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../const/color_const.dart';
import '../../../state_managment/chat/chat_cubit.dart';
import '../../video_music_palyer/player_content.dart';
import 'blank_component.dart';
import 'message_tile.dart';

class BodyOfChatPage extends StatefulWidget {
  final Function addMessageFunction;
  final File? fileSelected;
  final String? type;

  const BodyOfChatPage(
      {Key? key,
      required this.addMessageFunction,
      this.fileSelected,
      this.type})
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
              if (index == state.messages.length &&
                  widget.fileSelected != null) {
                print("inja 1");
                if (widget.type == "P" || widget.type == "picture") {
                  print("inja 2");
                  return PictureOfflineTile(
                      message: widget.fileSelected!, index: index);
                }
                if (widget.type == "V" || widget.type == "video") {
                  print("inja 2");
                  return VideoOfflineTile(
                      message: widget.fileSelected!, index: index);
                }
              }
              Message message = state.messages[index];
              print(message.type);
              var date = Gregorian(message.createdAt!.year,
                  message.createdAt!.month, message.createdAt!.day);
              var dateFormatter = date.toJalali().formatter;
              String dateString = "${dateFormatter.d} ${dateFormatter.mN}";
              bool showDate = lastDate != dateString;
              lastDate = dateString;
              print("----- show chat ------");
              print(widget.fileSelected);
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
                    PictureTile(message: message, index: index),
                  if (message.type == "V" || message.type == "video")
                    VideoTile(message: message, index: index)
                ],
              );
            },
            itemCount: widget.fileSelected == null
                ? state.messages.length
                : state.messages.length + 1,
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

class VideoTile extends StatefulWidget {
  final Message message;
  final int index;

  const VideoTile({
    Key? key,
    required this.message,
    required this.index,
  }) : super(key: key);

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Video link");
    print(widget.message.content);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<String>(
      future: fetchVideoTile(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ChatBubble(
            elevation: 1,
            clipper: ChatBubbleClipper9(
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
                                    type: "video",
                                    content: widget.message.content!,
                                  )));
                    },
                    child: Stack(
                      children: [
                        if (snapshot.hasData)
                          Container(
                              height: context.height() * 0.3,
                              width: context.width(),
                              child: Image.file(File(snapshot.data))),
                        Container(
                          height: context.height() * 0.3,
                          width: context.width(),
                          decoration:
                              const BoxDecoration(color: Colors.black54),
                          child: const Center(
                            child: Icon(Icons.play_arrow_rounded),
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    widget.message.createdAt!.hour.toString() +
                        ":" +
                        widget.message.createdAt!.minute.toString(),
                    style: const TextStyle(color: Colors.white60, fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<String> fetchVideoTile() async {
    try {
      print(widget.message.content!);
      final fileName = await VideoThumbnail.thumbnailFile(
        video: widget.message.content!,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
        quality: 75,
      );
      print("file");
      print(fileName);
      return Future.value(fileName!);
    } catch (e) {
      print(e);
      return "";
    }
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
      padding: const EdgeInsets.only(bottom: 10),
      child: ChatBubble(
        elevation: 1,
        clipper: ChatBubbleClipper9(
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
                style: const TextStyle(color: Colors.white60, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PictureOfflineTile extends StatefulWidget {
  final File message;
  final int index;

  const PictureOfflineTile({
    Key? key,
    required this.message,
    required this.index,
  }) : super(key: key);

  @override
  State<PictureOfflineTile> createState() => _PictureOfflineTileState();
}

class _PictureOfflineTileState extends State<PictureOfflineTile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ChatBubble(
        elevation: 1,
        clipper: ChatBubbleClipper9(
            type: true ? BubbleType.sendBubble : BubbleType.receiverBubble),
        alignment: true ? Alignment.centerRight : Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        backGroundColor: true
            ? ColorPallet.colorPalletNightFog
            : ColorPallet.colorPalletSambucus,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: context.height() * 0.3,
                    width: context.width(),
                    decoration: BoxDecoration(
                        image:
                            DecorationImage(image: FileImage(widget.message))),
                  ),
                  Container(
                    height: context.height() * 0.3,
                    decoration: const BoxDecoration(color: Colors.black54),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white70,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoOfflineTile extends StatefulWidget {
  final File message;
  final int index;

  const VideoOfflineTile({
    Key? key,
    required this.message,
    required this.index,
  }) : super(key: key);

  @override
  State<VideoOfflineTile> createState() => _VideoOfflineTileState();
}

class _VideoOfflineTileState extends State<VideoOfflineTile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<Uint8List>(
      future: fetchVideoTile(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ChatBubble(
            elevation: 1,
            clipper: ChatBubbleClipper9(
                type: true ? BubbleType.sendBubble : BubbleType.receiverBubble),
            alignment: true ? Alignment.centerRight : Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            backGroundColor: true
                ? ColorPallet.colorPalletNightFog
                : ColorPallet.colorPalletSambucus,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      if (snapshot.hasData)
                        Container(
                            height: context.height() * 0.3,
                            width: context.width(),
                            child: Image.memory(snapshot.data)),
                      Container(
                          height: context.height() * 0.3,
                          width: context.width(),
                          decoration:
                              const BoxDecoration(color: Colors.black54),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [CircularProgressIndicator()],
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<Uint8List> fetchVideoTile() async {
    try {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: widget.message.path,
        imageFormat: ImageFormat.JPEG,
        quality: 25,
      );
      print("file");
      print(uint8list);
      return Future.value(uint8list!);
    } catch (e) {
      print(e);
      return Uint8List.fromList([]);
    }
  }
}
