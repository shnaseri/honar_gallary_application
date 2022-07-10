import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:honar_api_v20/api.dart';
import 'package:honar_gallary/UI/business/business_page.dart';
import 'package:honar_gallary/UI/utils/show_dialog.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:honar_gallary/logic/general_values.dart';
import 'package:honar_gallary/settings/setting_page.dart';
import 'package:honar_gallary/state_managment/gallery/gallery_cubit.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Art_piece/art_piece_page.dart';
import '../chat/chat_page.dart';
import 'components/common.dart';

class GalleryView extends StatefulWidget {
  late int id;

  GalleryView({Key? key, int? uid}) : super(key: key) {
    id = uid ?? ConfigGeneralValues.getInstance().userId!;
  }

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  late bool startApp;
  late BuildContext contextCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startApp = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GalleryCubit>(
      create: (context) => GalleryCubit(),
      child: Scaffold(
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
            RefreshIndicator(
              onRefresh: () async {
                await BlocProvider.of<GalleryCubit>(contextCubit)
                    .fetchGallery(widget.id);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  padding: const EdgeInsets.only(top: 40, bottom: 70),
                  children: [
                    BlocBuilder<GalleryCubit, GalleryState>(
                      builder: (context, state) {
                        if (state is GalleryLoaded) {
                          return Container(
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 55,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  state.owner.fullName!,
                                                  style: TextStyle(
                                                      color: ColorPallet
                                                          .colorPalletSambucus,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                5.width,
                                                if (state.owner.id !=
                                                    ConfigGeneralValues
                                                            .getInstance()
                                                        .userId)
                                                  IconButton(
                                                      onPressed: () {
                                                        showMessage(
                                                            context,
                                                            state.profile
                                                                    .isFollowedByYou!
                                                                ? "لفو دنبال"
                                                                : "دنبال کردن",
                                                            state.profile
                                                                    .isFollowedByYou!
                                                                ? "آیا تمایل دارد از دنبال کردن این شخص دست بردارید؟"
                                                                : "ایا از دنبال کردن این هنرمند اطمینان دارید؟",
                                                            functionRun:
                                                                () async {
                                                          setState(() {
                                                            if (state.profile
                                                                .isFollowedByYou!) {
                                                              state.profile
                                                                  .followerCount = state
                                                                      .profile
                                                                      .followerCount! -
                                                                  1;
                                                            } else {
                                                              state.profile
                                                                  .followerCount = state
                                                                      .profile
                                                                      .followerCount! +
                                                                  1;
                                                            }
                                                            state.profile
                                                                    .isFollowedByYou =
                                                                !state.profile
                                                                    .isFollowedByYou!;
                                                          });
                                                          try {
                                                            bool status = await BlocProvider
                                                                    .of<GalleryCubit>(
                                                                        context)
                                                                .followUser(
                                                                    state.owner
                                                                        .id);
                                                          } catch (e) {
                                                            setState(() {
                                                              if (state.profile
                                                                  .isFollowedByYou!) {
                                                                state.profile
                                                                    .followerCount = state
                                                                        .profile
                                                                        .followerCount! -
                                                                    1;
                                                              } else {
                                                                state.profile
                                                                    .followerCount = state
                                                                        .profile
                                                                        .followerCount! +
                                                                    1;
                                                              }
                                                              state.profile
                                                                      .isFollowedByYou =
                                                                  !state.profile
                                                                      .isFollowedByYou!;
                                                            });
                                                          }
                                                        });
                                                      },
                                                      icon: state.profile
                                                              .isFollowedByYou!
                                                          ? Icon(
                                                              LineIcons
                                                                  .user_minus,
                                                              color: ColorPallet
                                                                  .colorPalletSambucus,
                                                            )
                                                          : Icon(
                                                              LineIcons
                                                                  .user_plus,
                                                              color: ColorPallet
                                                                  .colorPalletSambucus,
                                                            ))
                                              ],
                                            ),
                                            Container(
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      'دنبال کننده ها',
                                                      style: TextStyle(
                                                        color: ColorPallet
                                                            .colorPalletBlueGam,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    CircleAvatar(
                                                      backgroundColor: ColorPallet
                                                          .colorPalletNightFog,
                                                      radius: 14,
                                                      child: Center(
                                                        child: Text(
                                                          state.profile
                                                              .followerCount
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 25,
                                                    vertical: 8,
                                                  ),
                                                  child: Container(
                                                    height: 45,
                                                    width: 3,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'دنبال شونده ها',
                                                      style: TextStyle(
                                                        color: ColorPallet
                                                            .colorPalletBlueGam,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    CircleAvatar(
                                                      backgroundColor: ColorPallet
                                                          .colorPalletNightFog,
                                                      radius: 14,
                                                      child: Center(
                                                        child: Text(
                                                          state.profile
                                                              .followingCount
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w800,
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
                                    if (widget.id ==
                                        ConfigGeneralValues.getInstance()
                                            .userId)
                                      Positioned(
                                        top: 90,
                                        right: 20,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const SettingsPage()));
                                          },
                                          child: Icon(
                                            Icons.settings,
                                            color:
                                                ColorPallet.colorPalletNightFog,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    if (widget.id !=
                                        ConfigGeneralValues.getInstance()
                                            .userId)
                                      Positioned(
                                        top: 90,
                                        right: 20,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => ChatPage(
                                                    chatCode: getChatCode(
                                                        state.owner.id!),
                                                    index: 1,
                                                    contact:
                                                        ArtGalleryRead200ResponseOwner(
                                                            fullName: state
                                                                .owner.fullName,
                                                            profilePhoto: state
                                                                .owner
                                                                .profilePhoto),
                                                  ),
                                                ));
                                          },
                                          child: Icon(
                                            Icons.wechat,
                                            color:
                                                ColorPallet.colorPalletNightFog,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    if (state.enableBusiness ||
                                        state.owner.id ==
                                            ConfigGeneralValues.getInstance()
                                                .userId)
                                      Positioned(
                                        top: 90,
                                        left: 20,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => BusinessPage(
                                                    id: widget.id,
                                                  ),
                                                ));
                                          },
                                          child: Icon(
                                            Icons.business_center_sharp,
                                            color: state.enableBusiness
                                                ? ColorPallet
                                                    .colorPalletNightFog
                                                : Colors.red,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                          child: CachedNetworkImage(
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: imageProvider)),
                                          );
                                        },
                                        placeholder: (context, strImage) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey,
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 2.0,
                                              ),
                                            ),
                                          );
                                        },
                                        imageUrl: state
                                                .owner.profilePhoto!.isEmpty
                                            ? "http://188.121.110.151:8000/media/images/icons8-test-account-64.png"
                                            : state.owner.profilePhoto!,
                                        fit: BoxFit.fill,
                                        height: 165,
                                        width: 110,
                                      )),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    BlocBuilder<GalleryCubit, GalleryState>(
                      builder: (context, state) {
                        contextCubit = context;
                        if (state is GalleryInitial && !startApp) {
                          startApp = true;
                          BlocProvider.of<GalleryCubit>(context)
                              .fetchGallery(widget.id);
                        }
                        if (state is GalleryLoaded) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            child: MasonryGridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              itemCount: state.arts.length,
                              itemBuilder: (context, index) {
                                return Tile(
                                  post: state.arts[index],
                                  index: index,
                                  extent: 180,
                                );
                              },
                            ),
                          );
                        }
                        return const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
