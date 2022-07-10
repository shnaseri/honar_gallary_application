import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:honar_gallary/logic/general_values.dart';
import 'package:honar_gallary/state_managment/search/search_cubit.dart';
import 'package:nb_utils/nb_utils.dart';

import '../gallary/components/common.dart';
import 'components/search_text_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
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
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 100,
                            child: Align(
                              alignment: const Alignment(0, 1.5),
                              child: BlocBuilder<SearchCubit, SearchState>(
                                builder: (context, state) {
                                  return TextFieldSearchWidget(
                                    onChanged: (value) {
                                      if (value.length < 3) {
                                        BlocProvider.of<SearchCubit>(context)
                                            .emit(SearchInitial());
                                        return;
                                      }
                                      if (state is SearchLoaded) {
                                        if (value == state.textSearched) {
                                          return;
                                        }
                                      }

                                      BlocProvider.of<SearchCubit>(context)
                                          .search(value);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: context.height(),
                            width: context.width(),
                            child: DraggableScrollableSheet(
                                expand: true,
                                minChildSize: 0.8,
                                initialChildSize: 0.82,
                                builder: (context, listScrollController) {
                                  return Container(
                                      decoration:
                                          boxDecorationWithRoundedCorners(
                                              backgroundColor: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(40),
                                                      topLeft:
                                                          Radius.circular(40))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: BodySearchWidget(
                                            controller: listScrollController),
                                      ));
                                }),
                          )
                        ],
                      )),
                ),
              ),
            )),
      ),
    );
  }
}

class BodySearchWidget extends StatefulWidget {
  final ScrollController controller;

  const BodySearchWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<BodySearchWidget> createState() => _BodySearchWidgetState();
}

class _BodySearchWidgetState extends State<BodySearchWidget> {
  int categoryItemSelectedId = -1;
  late bool startApp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startApp = true;
  }

  @override
  Widget build(BuildContext context) {
    var categories = ConfigGeneralValues.getInstance().getCategories();
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          startApp = false;
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: context.width(),
                  height: context.height() * 0.3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/dribble_5-15.jpg"))),
                ),
                Text("هنرمندان منتظر شما هستند ...")
              ],
            ),
          );
        }
        if (state is SearchLoaded) {
          return ListView(
            children: [
              const Center(
                child: Text(
                  "قطعات هنری",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
              ),
              15.height,
              if (state.artPieces.isNotEmpty)
                MasonryGridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemCount: state.artPieces.length,
                  itemBuilder: (context, index) {
                    return SearchTile(
                      post: state.artPieces[index],
                      index: index,
                      extent: context.height() * 0.18,
                    );
                  },
                ),
              15.height,
              if (state.artPieces.isEmpty)
                const Center(
                  child: Text(
                    "هیچ قطعات هنری یافت نشد",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black87),
                  ),
                ),
              15.height,
              const Center(
                child: Text(
                  "هنرمندان",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
              ),
              15.height,
              if (state.artists.isEmpty)
                const Center(
                  child: Text(
                    "هیچ هنرمندی یافت نشد",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black87),
                  ),
                ),
              if (state.artists.isNotEmpty)
                MasonryGridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemCount: state.artists.length,
                  itemBuilder: (context, index) {
                    return SearchArtistTile(
                      user: state.artists[index],
                      index: index,
                      extent: context.height() * 0.2,
                    );
                  },
                ),
            ],
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(
              color: Colors.pink,
            ),
          ],
        );
      },
    );
  }

  bool checIndex(int index) =>
      categoryItemSelectedId == index ||
      (categoryItemSelectedId == -1 && index == 0);
}
