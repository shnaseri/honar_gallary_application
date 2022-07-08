import 'package:flutter/material.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:nb_utils/nb_utils.dart';

showMessage(BuildContext context, String title, String message,
    {dynamic functionRun}) async {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  bool status = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        double bottom = MediaQuery.of(context).viewInsets.bottom;
        return StatefulBuilder(builder: (context, setStateOriginal) {
          return Builder(builder: (context) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: Form(
                  child: SingleChildScrollView(
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Center(
                          child: Container(
                            width: width * 0.75,
                            height: height * 0.4,
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                            margin: EdgeInsets.only(
                                bottom: (bottom == 0)
                                    ? 0.12 * height
                                    : bottom + 0.02 * height,
                                top: 0.12 * height),
                            decoration: BoxDecoration(
                                color: Color(0xfffefcfd),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.exit_to_app,
                                        color: ColorPallet.colorPalletNightFog,
                                        size: width * 0.15,
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Text(
                                        title,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: boldTextStyle(
                                          weight: FontWeight.bold,
                                          letterSpacing: 1.8,
                                          color: Color(0xff22262c),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Divider(
                                        color: Color(0xffededed),
                                        thickness: 3,
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Text(
                                        message,
                                        maxLines: 4,
                                        textAlign: TextAlign.center,
                                        style: boldTextStyle(
                                          weight: FontWeight.bold,
                                          letterSpacing: 1.25,
                                          color: Color(0xff4a4a4a),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: height * 0.08,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () async {
                                                Navigator.pop(context, true);
                                                await functionRun();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: ColorPallet
                                                        .colorPalletBlueGam,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20))),
                                                child: Container(
                                                  child: Center(
                                                    child: Text(
                                                      "تایید",
                                                      style: boldTextStyle(
                                                        color: Colors.white,
                                                        weight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context, false);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffea004e),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                  child: Container(
                                                    child: Center(
                                                      child: Text(
                                                        "لغو",
                                                        style: boldTextStyle(
                                                          color: Colors.white,
                                                          weight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
      });
}

showDialogUpload(BuildContext context, int StateLevel) async {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  bool status = await showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        double bottom = MediaQuery.of(context).viewInsets.bottom;
        return StatefulBuilder(builder: (context, setStateOriginal) {
          return Builder(builder: (context) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: Form(
                  child: SingleChildScrollView(
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [],
                    ),
                  ),
                ),
              ),
            );
          });
        });
      });
}
