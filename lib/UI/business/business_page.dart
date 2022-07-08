import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:honar_api_v14/api.dart';
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: MediaQuery.of(context).size.height,
              child: ListView(
                padding: const EdgeInsets.only(top: 40, bottom: 70),
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  // Container(
                  //   height: 45,
                  //   margin: const EdgeInsets.symmetric(horizontal: 25),
                  //   padding: const EdgeInsets.symmetric(horizontal: 5),
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(10)),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       const Text(
                  //         " صفحه تجاری این کاربر باز است ",
                  //         style: TextStyle(
                  //             color: Colors.black, fontWeight: FontWeight.w900),
                  //       ),
                  //       ElevatedButton(
                  //           onPressed: () {}, child: const Text("مشاهده"))
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 5,
                  ),
                  BlocBuilder<GalleryCubit, GalleryState>(
                    builder: (context, state) {
                      if (state is GalleryInitial && !startApp) {
                        startApp = true;
                        BlocProvider.of<GalleryCubit>(context).fetchGallery(
                            ConfigGeneralValues.getInstance().userId!);
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
                                                artId: state.arts[index].id)));
                                  },
                                  child: ArtPieceTile(
                                      artPiece: state.arts[index]));
                            },
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArtPieceTile extends StatelessWidget {
  InlineResponse2003Posts artPiece;

  ArtPieceTile({
    required this.artPiece,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          CachedNetworkImage(
              color: Colors.white,
              imageUrl: artPiece.image,
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
                  height: context.height() * 0.3,
                  width: context.width(),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
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
                          artPiece.title,
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
                            artPiece.title * 3,
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
