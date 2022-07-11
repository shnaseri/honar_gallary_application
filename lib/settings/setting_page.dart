import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:honar_api_v22/api.dart';
import 'package:honar_gallary/UI/profile/profile_page.dart';
import 'package:honar_gallary/UI/utils/appbar/appbar_titile_back.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:honar_gallary/logic/general_values.dart';
import 'package:nb_utils/nb_utils.dart';

import '../UI/utils/show_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBarTitleWithBack(context, "تنظیمات"),
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //   elevation: 1,
        //   leading: IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //     icon: Icon(
        //       Icons.arrow_back,
        //       color: Colors.green,
        //     ),
        //   ),
        // ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
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
            padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: ColorPallet.colorPalletDark,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "حساب کاربری",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                const Divider(
                  height: 15,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                // buildAccountOptionRow(context, "تغییر رمز عبور"),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ProfilePage()));
                    },
                    child: buildAccountOptionRow(context, "اطلاعات کاربری")),
                // buildAccountOptionRow(context, "Social"),
                // buildAccountOptionRow(context, "زبان"),
                // buildAccountOptionRow(context, "Privacy and security"),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.volume_up_outlined,
                      color: ColorPallet.colorPalletDark,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "اعلانات",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                  ],
                ),
                const Divider(
                  height: 15,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                buildNotificationOptionRow("کسب و کار",
                    ConfigGeneralValues.getInstance().enableBusiness, () async {
                  final profileApi = ProfileApi(interfaceOfUser);
                  ProfileToggleBusinessUpdate200Response? response;
                  try {
                    response = await profileApi.profileToggleBusinessUpdate();
                    setState(() {
                      ConfigGeneralValues.getInstance().enableBusiness =
                          response!.business;
                    });
                  } catch (e) {}
                }),
                // buildNotificationOptionRow("Account activity", true),
                // buildNotificationOptionRow("Opportunity", false),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: OutlinedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => ColorPallet.colorPalletDark),
                        padding: MaterialStateProperty.resolveWith((states) =>
                            const EdgeInsets.symmetric(horizontal: 30)),
                        shape: MaterialStateProperty.resolveWith((states) =>
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)))),
                    onPressed: () {
                      showMessage(context, 'خروج',
                          'آیا از خروج از برنامه اطمینان دارد؟',
                          functionRun: () async {
                        final _prefs = await SharedPreferences.getInstance();
                        await _prefs.clear();
                        print('1');
                        Phoenix.rebirth(context);
                      });
                    },
                    child: const Text("خروج",
                        style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 2.2,
                            color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(
      String title, bool isActive, Function function) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.amber,
              value: isActive,
              onChanged: (bool val) {
                setState(() {
                  isActive = val;
                  function();
                });
              },
            ))
      ],
    );
  }

  Padding buildAccountOptionRow(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }
}
