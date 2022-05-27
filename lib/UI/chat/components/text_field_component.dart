import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/src/extensions/context_extensions.dart';
import 'package:petstore_api/api.dart';

import '../../../state_managment/chat/chat_cubit.dart';
import '../chat_page.dart';

class TextFieldForChatPage extends StatelessWidget {
  final User contact;

  const TextFieldForChatPage({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            right: 0,
            left: 0,
            child: Container(
              height: 55,
              color: const Color(0xffF6BEB1).withOpacity(0.35),
              width: context.width(),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          BlocProvider.of<ChatCubit>(context)
                              .publishMessage(contact, controller.text);
                        }
                        controller.text = "";
                      },
                      icon: const Icon(
                        Icons.send,
                        textDirection: TextDirection.rtl,
                        color: Color(0xff413D4B),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: TextFormField(
                      maxLines: 20,
                      controller: controller,
                      textInputAction: TextInputAction.newline,
                      // textAlign: TextAlign.end,
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                          hintText: "وارد کنید...",
                          hintTextDirection: TextDirection.rtl,
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
