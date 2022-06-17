import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../const/color_const.dart';

// import 'package:saffrun_app/constants/theme_color.dart';
// import '../constants.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final Function onTapRow;

  const ProfileListItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTapRow,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const kTitleTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
    // final double height = context.height();
    final double width = context.width();
    return Container(
      // height: height * 0.08,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.005,
      ).copyWith(
        bottom: 0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.025,
      ),
      decoration: const BoxDecoration(
          // borderRadius: BorderRadius.circular(30),
          ),
      child: InkWell(
        onTap: () {
          onTapRow();
        },
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Icon(
                  icon,
                  size: 25,
                  color: ColorPallet.colorPalletPurpleRain,
                ),
                SizedBox(width: width * 0.02),
                Text(
                  text,
                  style: kTitleTextStyle.copyWith(
                      fontWeight: FontWeight.w800,
                      color: ColorPallet.colorPalletPurpleRain
                      // fontFamily: "Poppins"
                      ),
                ),
                const Spacer(),
                if (hasNavigation)
                  IconButton(
                    splashRadius: 10,
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.red,
                      size: 20,
                    ),
                    onPressed: () {
                      // setState(() {
                      //   _volume += 10;
                      // });
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
