import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
        child: ListView.separated(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 50),
          itemBuilder: (context, index) {
            return const CommentTileWidget();
          },
          itemCount: 3,
          separatorBuilder: (BuildContext context, int index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Divider(
                thickness: 2,
                color: Colors.white60,
              ),
            );
          },
        ),
      ),
    );
  }
}

class CommentTileWidget extends StatefulWidget {
  const CommentTileWidget({Key? key}) : super(key: key);

  @override
  State<CommentTileWidget> createState() => _CommentTileWidgetState();
}

class _CommentTileWidgetState extends State<CommentTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.white,
              child: Container(),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "بابک بهکام کیا",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "5 ساعت پیش",
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "به نظر من که خیلی فوق العادس",
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
