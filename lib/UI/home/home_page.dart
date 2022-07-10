import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:honar_gallary/state_managment/home_page/home_cubit.dart';
import 'package:more_loading_gif/more_loading_gif.dart';
import 'package:nb_utils/nb_utils.dart';

import '../business/business_page.dart';

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
              return SizedBox(
                height: context.height(),
                width: context.width(),
                child: ListView(
                  children: [
                    const HomeHeader(),
                    Container(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Column(
                              children: [
                                Container(
                                  height: 200,
                                  width: context.width(),
                                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 150,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/1.jpeg"))),
                                              ),
                                              Text(
                                                "بیشترین لایک ",
                                                style: TextStyle(
                                                    color: ColorPallet.colorPalletDark,fontWeight: FontWeight.w900,fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(child: Container())
                                      ],
                                    ),
                                  ),
                                ),
                                if (state.homepage.feed.length > index)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: ArtPieceTile(
                                      artPiece: state.homepage.feed[index],
                                    ),
                                  )
                              ],
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ArtPieceTile(
                              artPiece: state.homepage.feed[index],
                            ),
                          );
                        },
                        itemCount: 1,
                      ),
                    )
                  ],
                ),
              );
            }
            if (state is HomeError) {
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
            }
            return Center(
              child: MoreLoadingGif(type: MoreLoadingGifType.doubleRing),
            );
          },
        ),
      ),
    );
  }

  int getItemCount(HomeLoaded state) {
    int length = state.homepage.feed.length;
    if (state.homepage.offers!.mostCommentedPostInLast7Days != null) {
      length++;
    }
    if (state.homepage.offers!.mostLikedPostInLast7Days != null) {
      length++;
    }
    if (state.homepage.offers!.mostFavoriteUserInLast7Days != null) {
      length++;
    }
    return length;
  }
}

class HomeHeader extends StatefulWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          return Container(
            padding: EdgeInsets.only(bottom: 10, top: 15),
            width: context.width(),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                color: ColorPallet.colorPalletDark),
            child: state.homepage.stats!.commentsYouReceivedLast30Days != 0 ||
                    state.homepage.stats!.commentsYouGivenLast30Days != 0 ||
                    state.homepage.stats!.likesYouGivenLast30Days == 0 ||
                    state.homepage.stats!.likesYouReceivedLast30Days != 0
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                    width: 2),
                                borderRadius: BorderRadius.circular(10)),
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
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white54),
                                    child: Text(
                                      state.homepage.stats!
                                          .commentsYouReceivedLast30Days
                                          .toString(),
                                      style: TextStyle(color: Colors.white),
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
                                borderRadius: BorderRadius.circular(10)),
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
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white54),
                                    child: Text(
                                      state.homepage.stats!
                                          .likesYouGivenLast30Days
                                          .toString(),
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      15.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                    width: 2),
                                borderRadius: BorderRadius.circular(10)),
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
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white54),
                                    child: Text(
                                      state.homepage.stats!
                                          .commentsYouReceivedLast30Days
                                          .toString(),
                                      style: TextStyle(color: Colors.white),
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
                                borderRadius: BorderRadius.circular(10)),
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
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white54),
                                    child: Text(
                                      state.homepage.stats!
                                          .likesYouReceivedLast30Days
                                          .toString(),
                                      style: TextStyle(color: Colors.white),
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
          );
        }
        return Container();
      },
    );
  }
}
