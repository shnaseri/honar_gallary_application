import 'package:flutter/material.dart';

import 'ChatListSideBar.dart';
import 'TileRows.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.purple,
          title: const Text("Naser",style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),),
          actions: const [
            Padding(
                padding: EdgeInsets.only(right: 10),
                // child: SearchList())
                child: Icon(Icons.search,size: 30,))
          ],
        ),

        drawer: sidebarDrawer(),
        body: ListView(
          children: [
            list(url: 'assets/one.jfif',name: "Rose",tym: "11:11pm",desc: "How are u?",msg: "2",isRead: true),
            const Divider(height: 0.2,),
            list(url: 'assets/two.jfif',name: "Samanta",tym: "10:10pm",desc: "hi baby",msg: "",isRead: false),
            const Divider(height: 0.2,),
            list(url: 'assets/three.jfif',name: "Nadia",tym: "9:11pm",desc: "love u",msg: "2",isRead: true),
            const Divider(height: 0.2,),
            list(url: 'assets/four.jfif',name: "Alia",tym: "8:11pm",desc: "miss u <3",msg: "",isRead: false),
            const Divider(height: 0.2,),
            list(url: 'assets/five.jfif',name: "Amy",tym: "7:11pm",desc: "baby...",msg: "",isRead: false),
            const Divider(height: 0.2,),
            list(url: 'assets/six.jfif',name: "Dani",tym: "6:11pm",desc: "whr r u baby?",msg: "2",isRead: true),
            const Divider(height: 0.2,),
            list(url: 'assets/7.jfif',name: "Rose",tym: "5:11pm",desc: "missing u",msg: "",isRead: false),
            const Divider(height: 0.2,),
            list(url: 'assets/8.jfif',name: "Anistone",tym: "4:11pm",desc: "hai my love <3",msg: "2",isRead: true),
            const Divider(height: 0.2,),
            list(url: 'assets/five.jfif',name: "Amy",tym: "7:11pm",desc: "baby...",msg: "",isRead: false),
            const Divider(height: 0.2,),
            list(url: 'assets/7.jfif',name: "Rose",tym: "5:11pm",desc: "missing u",msg: "",isRead: false),
            const Divider(height: 0.2,),
            list(url: 'assets/8.jfif',name: "Anistone",tym: "4:11pm",desc: "hai my love <3",msg: "2",isRead: true),
            const Divider(height: 0.2,),
          ],
        ),
      ),
    );
  }
}
