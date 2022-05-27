import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honar_gallary/const/color_const.dart';

abstract class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final BuildContext parentContext;

  const AppBarWidget({Key? key, required this.parentContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return AppBar(
      toolbarHeight: height * 0.07,
      automaticallyImplyLeading: true,
      elevation: 0,
      title: getTitleWidget(),
      // excludeHeaderSemantics: true,
      backgroundColor: ColorPallet.colorPalletDark,
      // backgroundColor: Color(0xffd0dee9),
      leading: getLeading(),
      actions: getActions(),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(MediaQuery.of(parentContext).size.height * 0.07);

  List<Widget>? getActions();

  Widget? getLeading();

  Widget getTitleWidget();
}
