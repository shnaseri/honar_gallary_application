import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:honar_gallary/state_managment/home_page/home_cubit.dart';
import 'package:nb_utils/nb_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool startApp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startApp = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeInitial && startApp) {
              BlocProvider.of<HomeCubit>(context).fetchHome();
              startApp = false;
            }
            if (state is HomeLoaded) {
              return ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 10, top: 15),
                    width: context.width(),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: ColorPallet.colorPalletDark),
                    child:
                        state.homepage.stats!.commentsYouReceivedLast30Days !=
                                    0 ||
                                state.homepage.stats!
                                        .commentsYouGivenLast30Days !=
                                    0 ||
                                state.homepage.stats!.likesYouGivenLast30Days ==
                                    0 ||
                                state.homepage.stats!
                                        .likesYouReceivedLast30Days !=
                                    0
                            ? Column(
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white,
                                                style: BorderStyle.solid,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            const Text(
                                              "نظرات دریافتی",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            10.height,
                                            Container(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 3, horizontal: 9),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                    color: Colors.white54),
                                                child: Text(
                                                  state.homepage.stats!
                                                      .commentsYouReceivedLast30Days
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white,
                                                style: BorderStyle.solid,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            const Text(
                                              "لایک های ارسالی",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            10.height,
                                            Container(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 3, horizontal: 9),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                    color: Colors.white54),
                                                child: Text(
                                                  state.homepage.stats!
                                                      .likesYouGivenLast30Days
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                15.height,
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white,
                                              style: BorderStyle.solid,
                                              width: 2),
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          const Text(
                                            "نظرات دریافتی",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          10.height,
                                          Container(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 3, horizontal: 9),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                  color: Colors.white54),
                                              child: Text(
                                                state.homepage.stats!
                                                    .commentsYouReceivedLast30Days
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white,
                                              style: BorderStyle.solid,
                                              width: 2),
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          const Text(
                                            "لایک های دریافتی",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          10.height,
                                          Container(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 3, horizontal: 9),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                  color: Colors.white54),
                                              child: Text(
                                                state.homepage.stats!
                                                    .likesYouReceivedLast30Days
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                            : Container(
                          child: Image.asset("assets/images/1.jpeg"),
                        ),
                  )
                ],
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  "متاسفانه در لود شدن  این صفحه مشکلی به وجود امده است",
                  style: TextStyle(
                      color: ColorPallet.colorPalletSambucus,
                      fontWeight: FontWeight.w800),
                ))
              ],
            );
          },
        ),
      ),
    );
  }
}
