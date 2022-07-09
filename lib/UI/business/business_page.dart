import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:honar_api_v17/api.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../logic/general_values.dart';
import '../../state_managment/gallery/gallery_cubit.dart';
import '../Art_piece/art_piece_page.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({Key? key}) : super(key: key);

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  late bool startApp;
  late FullUser profile;
  late BuildContext contextCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startApp = false;
    profile = ConfigGeneralValues.getInstance().profile;
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorPallet.colorPalletSambucus,
                    ColorPallet.colorPalletBlueGam,
                  ],
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter,
                ),
              ),
            ),
            RefreshIndicator(
              onRefresh: () async {
                await BlocProvider.of<GalleryCubit>(contextCubit).fetchGallery(
                    ConfigGeneralValues.getInstance().userId!,
                    isBusiness: true);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 40, bottom: 40),
                  children: [
                    Container(
                      height: 120,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CachedNetworkImage(
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
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
                              imageUrl: profile.userProfile!.avatar == null
                                  ? "http://188.121.110.151:8000/media/images/icons8-test-account-64.png"
                                  : profile.userProfile!.avatar!.image!,
                              fit: BoxFit.fill,
                              height: 130,
                              width: 100,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  profile.firstName! + " " + profile.lastName!,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.pink),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'دنبال کننده ها',
                                          style: TextStyle(
                                            color:
                                                ColorPallet.colorPalletBlueGam,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                          ),
                                        ),
                                        CircleAvatar(
                                          backgroundColor:
                                              ColorPallet.colorPalletNightFog,
                                          radius: 10,
                                          child: Center(
                                            child: Text(
                                              ConfigGeneralValues.getInstance()
                                                  .profile
                                                  .userProfile!
                                                  .followersCount
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
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
                                            color:
                                                ColorPallet.colorPalletBlueGam,
                                            fontSize: 13,
                                          ),
                                        ),
                                        CircleAvatar(
                                          backgroundColor:
                                              ColorPallet.colorPalletNightFog,
                                          radius: 10,
                                          child: Center(
                                            child: Text(
                                              ConfigGeneralValues.getInstance()
                                                  .profile
                                                  .userProfile!
                                                  .followingCount
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
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
                            flex: 6,
                          )
                        ],
                      ),
                    ),
                    BlocBuilder<GalleryCubit, GalleryState>(
                      builder: (context, state) {
                        contextCubit = context;
                        if (state is GalleryInitial && !startApp) {
                          startApp = true;
                          BlocProvider.of<GalleryCubit>(context).fetchGallery(
                              ConfigGeneralValues.getInstance().userId!,
                              isBusiness: true);
                        }
                        if (state is GalleryLoaded) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            child: MasonryGridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 1,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              itemCount: state.arts.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => ArtPiecePage(
                                                  artId:
                                                      state.arts[index].id!)));
                                    },
                                    child: ArtPieceTile(
                                        artPiece: state.arts[index]));
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

class ArtPieceTile extends StatelessWidget {
  ArtGalleryRead200ResponsePostsInner artPiece;

  ArtPieceTile({
    required this.artPiece,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      margin: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          CachedNetworkImage(
              color: Colors.white,
              imageUrl: artPiece.image!,
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: imageProvider)),
                );
              },
              placeholder: (context, url) {
                return Container(
                  decoration: const BoxDecoration(color: Colors.grey),
                );
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0, left: 15.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 15.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15)),
                            color: ColorPallet.colorPalletDark),
                        child: Text(
                          artPiece.title!,
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
                    const SizedBox(width: 15.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: ColorPallet.colorPalletDark),
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: context.width() * 0.7),
                          child: Text(
                            artPiece.title!,
                            style: const TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
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
    );
  }
}
