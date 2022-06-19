import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_api_v14/api.dart';
import 'package:honar_gallary/UI/utils/auto_text_direction.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:nb_utils/src/extensions/context_extensions.dart';

import '../../../state_managment/chat/chat_cubit.dart';
import '../chat_page.dart';

class TextFieldForChatPage extends StatefulWidget {
  final ChatGetAllChatsUser contact;
  final List<Message> messages;

  const TextFieldForChatPage(
      {Key? key, required this.contact, required this.messages})
      : super(key: key);

  @override
  State<TextFieldForChatPage> createState() => _TextFieldForChatPageState();
}

class _TextFieldForChatPageState extends State<TextFieldForChatPage> {
  late Map<String, List<String>> dataExtensions;
  var items = [
    'عکس',
    'فیلم',
    'موسیقی',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataExtensions = {
      items[0]: ['bmp', 'jpg', 'png'],
      items[1]: ['mp4', 'mkv', 'avi'],
      items[2]: ['mp3', 'flac']
    };
  }

  @override
  Widget build(BuildContext context) {
    String textMessage = "";
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            right: 0,
            left: 0,
            child: Container(
              height: 55,
              color: ColorPallet.colorPalletBlueGam.withOpacity(0.35),
              width: context.width(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          BlocProvider.of<ChatCubit>(context)
                              .publishMessage(widget.contact, controller.text);
                        }
                        controller.text = "";
                      },
                      icon: const Icon(
                        Icons.send,
                        textDirection: TextDirection.rtl,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.attach_file,
                        textDirection: TextDirection.rtl,
                        color: Colors.white,
                      ),
                      onSelected: (String result) async {
                        switch (result) {
                          case 'picture':
                            File fileSelected;
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions:
                                        dataExtensions[items[0]]);

                            if (result != null) {
                              print(result);
                              fileSelected = File(result.files.single.path!);
                              await BlocProvider.of<ChatCubit>(context)
                                  .uploadImage(fileSelected);
                            } else {
                              // User canceled the picker
                            }
                            break;
                          case 'video':
                            print('filter 2 clicked');
                            break;
                          case 'clearFilters':
                            print('Clear filters');
                            break;
                          default:
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'picture',
                          child: Text(
                            'عکس',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'video',
                          child: Text(
                            'فیلم',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        // const PopupMenuItem<String>(
                        //   value: 'music',
                        //   child: Text('Clear filters'),
                        // ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: AutoDirection(
                      text: textMessage,
                      child: TextFormField(
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        controller: controller,
                        textInputAction: TextInputAction.newline,
                        // textAlign: TextAlign.end,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (String text) {
                          setState(() {
                            textMessage = text;
                          });
                        },
                        decoration: const InputDecoration(
                            hintText: "وارد کنید...",
                            hintStyle: TextStyle(color: Colors.white),
                            hintTextDirection: TextDirection.rtl,
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none),
                        cursorColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
