import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../logic/general_values.dart';
import '../../state_managment/gallery/gallery_cubit.dart';
import '../gallary/components/common.dart';

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
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffe96443),
                    Color(0xff904e95),
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
                              return Tile(
                                post: state.arts[index],
                                index: index,
                                extent: 180,
                              );
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
