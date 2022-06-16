import 'package:flutter/material.dart';
import 'TileRows.dart';

Drawer sidebarDrawer()
{
  return Drawer(
    child: Column(
      children: [
        Container(
          height: 150,
          color: Colors.purple,
          child: Container(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: ExactAssetImage('assets/one.jfif'),
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    children: const [
                      Text("Hosein Naser",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
                      SizedBox(height: 5,),
                      Text("+912569874563",style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w600),),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // tile(msg: "New Group",im: Icons.people),
        // tile(msg: "New Seceret Chat",im: Icons.lock),
        // tile(msg: "New Broadcast List",im: Icons.speaker_phone_outlined),
        // Divider(height: 10,),
        // tile(msg: "Contacts",im: Icons.contact_page_sharp),
        // tile(msg: "Theming",im: Icons.format_paint),
        tile(msg: "Settings",im: Icons.settings),
        // tile(msg: "support",im: Icons.question_answer),
      ],
    ),
  );
}