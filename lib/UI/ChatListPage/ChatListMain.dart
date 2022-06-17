import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_api_v11/api.dart';
import 'package:honar_gallary/UI/chat/chat_page.dart';
import 'package:honar_gallary/state_managment/ChatList/chat_list_cubit.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'ChatListSideBar.dart';
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
                      Chat chat = state.chats[index];
                      return GestureDetector(
                        onTap: () {
                          pushNewScreen(
                            context,
                            screen: ChatPage(),
                            withNavBar: false,
                            // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation
                                .cupertino,
                          )
                        },
                        child: list(
                            url:
                            "https://media.istockphoto.com/photos/hot-air-balloons-flying-over-the-botan-canyon-in-turkey-picture-id1297349747?b=1&k=20&m=1297349747&s=170667a&w=0&h=oH31fJty_4xWl_JQ4OIQWZKP8C6ji9Mz7L4XmEnbqRU=",
                            name: chat.user ?? " ",
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
