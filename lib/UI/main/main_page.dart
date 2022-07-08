import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:honar_gallary/const/color_const.dart';

import '../../home/home_page.dart';
import '../Create_art_piece/creater_art_piece_page.dart';
import '../explorer/explorer_page.dart';
import '../gallary/gallery_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  // late PersistentTabController _controller;
  late int _currentIndex;
  late List<Widget> pages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = 0;
    // _controller = PersistentTabController(initialIndex: 0);
    // _controller.jumpToTab(0);
    pages = [
      const HomePage(),
      const ExplorerPage(),
      const CreateArtPiece(),
      const GalleryView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: DotNavigationBar(
        enableFloatingNavBar: true,
        currentIndex: _currentIndex,
        onTap: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        itemPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        dotIndicatorColor: Colors.black,
        items: [
          /// Home
          DotNavigationBarItem(
              icon: const Icon(Icons.home),
              selectedColor: ColorPallet.colorPalletSambucus,
              unselectedColor: ColorPallet.colorPalletSambucus.withAlpha(70)),

          /// Likes
          DotNavigationBarItem(
              icon: const Icon(Icons.search),
              selectedColor: ColorPallet.colorPalletSambucus,
              unselectedColor: ColorPallet.colorPalletSambucus.withAlpha(70)),

          /// Search
          DotNavigationBarItem(
              icon: const Icon(Icons.add),
              selectedColor: ColorPallet.colorPalletSambucus,
              unselectedColor: ColorPallet.colorPalletSambucus.withAlpha(70)),

          /// Profile
          DotNavigationBarItem(
              icon: const Icon(Icons.person),
              selectedColor: ColorPallet.colorPalletSambucus,
              unselectedColor: ColorPallet.colorPalletSambucus.withAlpha(70)),
        ],
      ),
      body: pages[_currentIndex],
    );
  }
}
