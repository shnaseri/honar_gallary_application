import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:honar_gallary/settings/setting_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'components/common.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
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
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: MediaQuery.of(context).size.height,
            child: ListView(
              padding: const EdgeInsets.only(top: 40, bottom: 70),
              children: [
                Container(
                  height: 250,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double innerHeight = constraints.maxHeight;
                      double innerWidth = constraints.maxWidth;
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: innerHeight * 0.68,
                              width: innerWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 55,
                                  ),
                                  Text(
                                    'امیرمهدی ایکانی',
                                    style: TextStyle(
                                      color: ColorPallet.colorPalletSambucus,
                                      fontSize: 25,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'دنبال کننده ها',
                                            style: TextStyle(
                                              color: ColorPallet
                                                  .colorPalletBlueGam,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                            ),
                                          ),
                                          CircleAvatar(
                                            backgroundColor:
                                                ColorPallet.colorPalletNightFog,
                                            radius: 14,
                                            child: const Center(
                                              child: Text(
                                                '10',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                          vertical: 8,
                                        ),
                                        child: Container(
                                          height: 45,
                                          width: 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'تعداد پست ها',
                                            style: TextStyle(
                                              color: ColorPallet
                                                  .colorPalletBlueGam,
                                              fontSize: 18,
                                            ),
                                          ),
                                          CircleAvatar(
                                            backgroundColor:
                                                ColorPallet.colorPalletNightFog,
                                            radius: 14,
                                            child: const Center(
                                              child: Text(
                                                '1',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 90,
                            right: 20,
                            child: GestureDetector(
                              onTap: () {
                                pushNewScreen(
                                  context,
                                  screen: const SettingsPage(),
                                  withNavBar: false,
                                  // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                              child: Icon(
                                Icons.settings,
                                color: ColorPallet.colorPalletNightFog,
                                size: 25,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Image.asset(
                                'assets/images/profile.png',
                                width: innerWidth * 0.41,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: MasonryGridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Tile(
                        index: index,
                        extent: (index % 3 + 1) * 100,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
