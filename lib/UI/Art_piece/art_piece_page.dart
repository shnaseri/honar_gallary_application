import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_api_v17/api.dart';
import 'package:honar_gallary/UI/chat/chat_page.dart';
import 'package:honar_gallary/UI/comment/comment_page.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:honar_gallary/logic/general_values.dart';
import 'package:honar_gallary/state_managment/art_piece/art_piece_cubit.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Edit_art_piece/edit_art_piece_page.dart';
import 'components/art_piece_header.dart';
import 'components/models.dart';
import 'components/photo_scroller.dart';
import 'components/story_line.dart';

class ArtPiecePage extends StatefulWidget {
  final int artId;

  const ArtPiecePage({Key? key, required this.artId}) : super(key: key);

  @override
  State<ArtPiecePage> createState() => _ArtPiecePageState();
}

class _ArtPiecePageState extends State<ArtPiecePage> {
  final Movie testMovie = Movie(
    bannerUrl: 'assets/images/banner.png',
    posterUrl: 'assets/images/poster.png',
    title: 'موسیقی ای ایران',
    rating: 8.0,
    starRating: 4,
    categories: ['سنتی', 'حماسی'],
    storyline: 'عججججب صوحبتی کردن چچچچیززززززز',
    price: 0,
    photoUrls: [
      'assets/images/1.png',
      'assets/images/2.png',
      'assets/images/3.png',
      'assets/images/4.png',
    ],
    like: 0,
    actors: [
      Actor(
        name: 'Louis C.K.',
        avatarUrl: 'assets/images/louis.png',
      ),
      Actor(
        name: 'Eric Stonestreet',
        avatarUrl: 'assets/images/eric.png',
      ),
      Actor(
        name: 'Kevin Hart',
        avatarUrl: 'assets/images/kevin.png',
      ),
      Actor(
        name: 'Jenny Slate',
        avatarUrl: 'assets/images/jenny.png',
      ),
      Actor(
        name: 'Ellie Kemper',
        avatarUrl: 'assets/images/ellie.png',
      ),
    ],
  );
  late bool startApp;
  late BuildContext contextCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startApp = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArtPieceCubit>(
      create: (context) => ArtPieceCubit(),
      child: Scaffold(
        body: BlocBuilder<ArtPieceCubit, ArtPieceState>(
          builder: (context, state) {
            contextCubit = context;
            if (state is ArtPieceInitial && startApp) {
              startApp = false;
              BlocProvider.of<ArtPieceCubit>(context)
                  .fetchArtPiece(widget.artId);
            }
            if (state is ArtPieceLoaded) {
              testMovie.title = state.artPiece.title!;
              testMovie.storyline = state.artPiece.description!;
              testMovie.price = state.artPiece.price!;
              testMovie.bannerUrl = state.artPiece.cover.image!;
              testMovie.like = state.artPiece.likeCount!.toInt();
              return RefreshIndicator(
                onRefresh: () async {
                  await BlocProvider.of<ArtPieceCubit>(contextCubit)
                      .fetchArtPiece(widget.artId);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
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
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            MovieDetailHeader(testMovie, state.artPiece),
                            Positioned(
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (state.artPiece.isUserLiked!) {
                                        state.artPiece.likeCount =
                                            state.artPiece.likeCount! - 1;
                                      } else {
                                        state.artPiece.likeCount =
                                            state.artPiece.likeCount! + 1;
                                      }
                                      setState(() {
                                        state.artPiece.isUserLiked =
                                            !state.artPiece.isUserLiked!;
                                      });

                                      bool status =
                                          await BlocProvider.of<ArtPieceCubit>(
                                                  context)
                                              .changeStatusLikeArtPiece(
                                                  state.artPiece.id!);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          color: Colors.pink),
                                      child: Center(
                                        child: !(state.artPiece.isUserLiked!)
                                            ? const Icon(
                                                Icons.favorite_border_rounded)
                                            : const Icon(Icons.favorite),
                                      ),
                                    ),
                                  ),
                                  if (state.artPiece.owner.id ==
                                      ConfigGeneralValues.getInstance().userId)
                                    10.width,
                                  if (state.artPiece.owner.id ==
                                      ConfigGeneralValues.getInstance().userId)
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => EditArtPiece(
                                                      artPiece: state.artPiece,
                                                    ))).then((value) {
                                          BlocProvider.of<ArtPieceCubit>(
                                                  context)
                                              .resetState();
                                          startApp = true;
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            color:
                                                ColorPallet.colorPalletBlueGam),
                                        child: const Center(
                                          child: Icon(Icons.edit),
                                        ),
                                      ),
                                    ),
                                  if (state.artPiece.owner.id !=
                                      ConfigGeneralValues.getInstance().userId)
                                    10.width,
                                  if (state.artPiece.owner.id !=
                                      ConfigGeneralValues.getInstance().userId)
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => ChatPage(
                                                chatCode: getChatCode(
                                                    state.artPiece.owner.id!),
                                                index: 1,
                                                contact:
                                                    ChatGetAllChatsList200ResponseInnerUser(
                                                        fullName: state.artPiece
                                                            .owner.fullName,
                                                        profilePhoto: state
                                                            .artPiece
                                                            .owner
                                                            .profilePhoto),
                                              ),
                                            ));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            color:
                                                ColorPallet.colorPalletBlueGam),
                                        child: const Center(
                                          child: Icon(Icons.wechat),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              top: 20,
                              left: 20,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Storyline(testMovie.storyline),
                        ),
                        if (state.artPiece.images.isNotEmpty)
                          PhotoScroller(state.artPiece.images),
                        // SizedBox(height: 20.0),
                        // ActorScroller(testMovie.actors),
                        const SizedBox(height: 60.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                "نظرات",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => CommentPage(
                                              artPiece: state.artPiece,
                                            )));
                              },
                              child: const Text("مشاهده همه"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
              child: const Center(
                child: Text(
                  "لطفا منتظر بمانید...",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  getChatCode(int userId) {
    return "${min<int>(ConfigGeneralValues.getInstance().userId!, userId)}-${max<int>(ConfigGeneralValues.getInstance().userId!, userId)}";
  }
}
