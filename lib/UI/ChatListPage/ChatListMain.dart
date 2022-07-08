import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_api_v14/api.dart';
import 'package:honar_gallary/UI/chat/chat_page.dart';
import 'package:honar_gallary/state_managment/ChatList/chat_list_cubit.dart';

import 'TileRows.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  late bool startup;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startup = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatListCubit>(
      create: (context) => ChatListCubit(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          // appBar: AppBar(
          //   elevation: 0.0,
          //   backgroundColor: Colors.purple,
          //   title: const Text("Naser",style: TextStyle(
          //       fontSize: 15,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.white
          //   ),),
          //   actions: const [
          //     Padding(
          //         padding: EdgeInsets.only(right: 10),
          //         // child: SearchList())
          //         child: Icon(Icons.search,size: 30,))
          //   ],
          // )

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
            child: BlocBuilder<ChatListCubit, ChatListState>(
              builder: (context, state) {
                if (state is ChatListInitial && startup) {
                  BlocProvider.of<ChatListCubit>(context).fetchChatList();
                  startup = false;
                }
                if (state is ChatListLoaded) {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      InlineResponse2006 chat = state.chats[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatPage(
                                  index: 1,
                                  chatCode: chat.chatCode,
                                  contact: chat.user,
                                ),
                              ));
                        },
                        child: list(
                            url: chat.user.profilePhoto,
                            name: chat.user.fullName ?? " ",
                            tym: chat.updatedAt.hour.toString() +
                                ":" +
                                chat.updatedAt.minute.toString(),
                            desc: chat.lastMessage,
                            msg: "",
                            isRead: false),
                      );
                    },
                    itemCount: state.chats.length,
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.pink,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
