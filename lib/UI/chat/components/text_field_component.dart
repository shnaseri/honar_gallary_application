import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_gallary/UI/utils/auto_text_direction.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:nb_utils/src/extensions/context_extensions.dart';
import 'package:petstore_api/api.dart';

import '../../../state_managment/chat/chat_cubit.dart';
import '../chat_page.dart';

class TextFieldForChatPage extends StatefulWidget {
  final User contact;

  const TextFieldForChatPage({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  State<TextFieldForChatPage> createState() => _TextFieldForChatPageState();
}

class _TextFieldForChatPageState extends State<TextFieldForChatPage> {
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
                children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          BlocProvider.of<ChatCubit>(context).publishMessage(
                              widget.contact, controller.text, state.messages);
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
                    flex: 6,
                    child: AutoDirection(
                      text: controller.text,
                      child: TextFormField(
                        maxLines: 20,
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
