import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_api_v20/api.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:honar_gallary/state_managment/home_page/home_cubit.dart';
import 'package:more_loading_gif/more_loading_gif.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Art_piece/art_piece_page.dart';
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
                  physics: ClampingScrollPhysics(),
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
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
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
                                                    color: ColorPallet
                                                        .colorPalletDark,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                          child: OfferTile(index: 1, post: state.homepage.feed[0]),
                                        ))
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

class OfferTile extends StatefulWidget {
  const OfferTile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
    required this.post,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;
  final ArtGalleryRead200ResponsePostsInner post;

  @override
  State<OfferTile> createState() => _OfferTileState();
}

class _OfferTileState extends State<OfferTile> {
  late bool showTitle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showTitle = false;
    print(widget.post.countLike);
  }

  @override
  Widget build(BuildContext context) {
    final child = GestureDetector(
        onTap: () {
          if (showTitle) {
            setState(() {
              showTitle = !showTitle;
            });
            return;
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ArtPiecePage(artId: widget.post.id!)));
        },
        onLongPress: () {
          setState(() {
            showTitle = !showTitle;
          });
        },
        child: Container(
          height: widget.extent,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
              boxShadow: const [
                BoxShadow(color: Colors.black26, spreadRadius: 0.2)
              ]),
          child: Stack(
            children: [
              Center(
                  child: CachedNetworkImage(
                      color: Colors.white,
                      imageUrl: widget.post.image!,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: context.width(),
                          height: context.height() * 0.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              image: DecorationImage(
                                  fit: BoxFit.cover, image: imageProvider)),
                        );
                      },
                      placeholder: (context, url) {
                        return Container(
                          height: context.height() * 0.3,
                          width: context.width(),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(11),
                          ),
                        );
                      })),
              Positioned(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(9)),
                  child: Row(
                    children: [
                      Text(
                        (widget.post.countLike ?? 0).toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                      2.width,
                      const Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                top: 0,
                left: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0, left: 15.0),
                      child: Row(
                        children: [
                          const SizedBox(width: 10.0),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15)),
                                color: ColorPallet.colorPalletDark),
                            child: Text(
                              widget.post.title!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [

                        const SizedBox(width: 10.0),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: ColorPallet.colorPalletDark),
                            child: ConstrainedBox(
                              constraints:
                              BoxConstraints(maxWidth: context.width() * 0.7),
                              child: Text(
                                "تعداد کامنت ها:" + widget.post.countComment.toString(),
                                style: const TextStyle(
                                    color: Colors.cyan,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));

    if (widget.bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: widget.bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}
