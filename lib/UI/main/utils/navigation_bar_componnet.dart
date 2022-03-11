// TODO Implement this library.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NavigationBarWidget extends StatelessWidget {
  final PersistentTabController controller;

  const NavigationBarWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: PersistentTabView(
        context,
        controller: controller,

        confineInSafeArea: true,
        screens: _buildScreens(),
        items: _navBarsItems(),
        stateManagement: true,
        resizeToAvoidBottomInset: false,
        // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        decoration: const NavBarDecoration(
            // borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white60
            // colorBehindNavBar: Colors.white
            ),
        // padding: NavBarPadding.only(bottom: height*0.08),
        bottomScreenMargin: 0,

        navBarStyle: NavBarStyle.style5,
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        popAllScreensOnTapOfSelectedTab: true,
        backgroundColor: Colors.white30,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
      ),
    );
  }

  _buildScreens() {
    return [
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
    ];
  }

  _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          LineIcons.home,
          // key: IntroRepository.introHomePage.keys[3] ,
        ),
        // title: ("Home"),
        activeColorPrimary: ColorPallet.colorPalletNightFog,
        inactiveColorPrimary: CupertinoColors.inactiveGray,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.search,
          // key: IntroRepository.introHomePage.keys[4] ,
        ),
        // title: ("Settings"),
        activeColorPrimary: ColorPallet.colorPalletNightFog,
        inactiveColorPrimary: CupertinoColors.inactiveGray,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.calendar_circle_fill,
        ),
        inactiveIcon: const Icon(
          CupertinoIcons.calendar_circle,
          // key: IntroRepository.introHomePage.keys[6] ,
        ),
        // title: ("Settings"),
        activeColorPrimary: ColorPallet.colorPalletNightFog,
        inactiveColorPrimary: CupertinoColors.inactiveGray,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.profile_circled,
          // key: IntroRepository.introHomePage.keys[7] ,
        ),
        // title: ("Settings"),
        activeColorPrimary: ColorPallet.colorPalletNightFog,
        inactiveColorPrimary: CupertinoColors.inactiveGray,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.profile_circled,
          // key: IntroRepository.introHomePage.keys[7] ,
        ),
        // title: ("Settings"),
        activeColorPrimary: ColorPallet.colorPalletNightFog,
        inactiveColorPrimary: CupertinoColors.inactiveGray,
      ),
    ];
  }
}
