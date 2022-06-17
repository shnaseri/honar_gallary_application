import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_api_v11/api.dart';
import 'package:honar_gallary/state_managment/chat/chat_cubit.dart';

import '../utils/appbar/appbar_title_profile.dart';
import 'components/body_of_chat.dart';
import 'components/text_field_component.dart';

TextEditingController controller = TextEditingController();

class ChatPage extends StatefulWidget {
  final User contact;
  final int index;
  final String chatCode;

  const ChatPage(
      {Key? key,
      required this.contact,
      required this.index,
      required this.chatCode})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late BuildContext chatContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: BlocProvider<ChatCubit>(
        create: (context) => ChatCubit(contact: widget.contact),
        child: WillPopScope(
          onWillPop: onWillScope,
          child: Scaffold(
              appBar: AppBarTitleProfile(context, widget.index,
                  title: widget.contact.fullName, functionBack: onWillScope),
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(4, 9, 35, 1),
                      Color.fromRGBO(39, 105, 171, 1),
                    ],
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                  ),
                ),
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    chatContext = context;
                    if (state is ChatErrorState) {
                      // toast(hasErrorChatPage);
                      BlocProvider.of<ChatCubit>(context).emit(ChatInitial());
                    }
                    if (state is ChatInitial) {
                      BlocProvider.of<ChatCubit>(context).fetchConnect();
                    }
                    return Stack(
                      children: [
                        const BodyOfChatPage(),
                        TextFieldForChatPage(
                          contact: widget.contact,
                        )
                      ],
                    );
                  },
                ),
              )),
        ),
      ),
    );
  }

  Future<bool> onWillScope() async {
    // BlocProvider.of<ChatCubit>(chatContext).disconnectMq();
    return true;
  }
}
