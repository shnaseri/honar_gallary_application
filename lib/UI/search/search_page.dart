import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_gallary/logic/general_values.dart';
import 'package:honar_gallary/state_managment/search/search_cubit.dart';
import 'package:nb_utils/nb_utils.dart';

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
                            child: TextFieldSearchWidget(
                              onChanged: (value) {},
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
                                    decoration: boxDecorationWithRoundedCorners(
                                        backgroundColor: Colors.white,
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(40),
                                            topLeft: Radius.circular(40))),
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
        if (state is SearchInitial && startApp) {
          BlocProvider.of<SearchCubit>(context).search("sl");
          startApp = false;
          // return Container();
        }
        if (state is SearchLoaded) {
          return ListView.builder(
            controller: widget.controller,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(bottom: 70, top: 50),
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Text(
                      state.artPieces[index].title,
                      style: TextStyle(
                          color: Colors.pink, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      state.artPieces[index].category.name,
                      style: TextStyle(
                          color: Colors.pink, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      state.artPieces[index].owner.fullName,
                      style: TextStyle(
                          color: Colors.pink, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              );
            },
            itemCount: state.artPieces.length,
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
