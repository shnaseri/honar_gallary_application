import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_api_v20/api.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:honar_gallary/state_managment/comment/comment_cubit.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/appbar/appbar_titile_back.dart';

class CommentPage extends StatefulWidget {
  final ArtPiece artPiece;

  const CommentPage({Key? key, required this.artPiece}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late bool startApp;
  late int repIndex;
  late TextEditingController textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startApp = true;
    repIndex = -1;
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentCubit>(
      create: (context) => CommentCubit(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar:
              AppBarTitleWithBack(context, "نظرات " + widget.artPiece.title!),
          body: Directionality(
            textDirection: TextDirection.rtl,
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
              child: BlocBuilder<CommentCubit, CommentState>(
                builder: (context, state) {
                  if (state is CommentInitial && startApp) {
                    startApp = false;
                    BlocProvider.of<CommentCubit>(context)
                        .fetchComments(widget.artPiece.id.toString());
                  }
                  if (state is CommentLoaded) {
                    return Stack(
                      children: [
                        ListView.separated(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 10),
                          itemBuilder: (context, index) {
                            return CommentTileWidget(
                                state.comments[index], index,
                                changeState: (index) {
                              setState(() {
                                repIndex = index;
                              });
                            });
                          },
                          itemCount: state.comments.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              child: Divider(
                                thickness: 2,
                                color: Colors.white60,
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          child: Column(
                            children: [
                              (repIndex != -1)
                                  ? Container(
                                      width: context.width(),
                                      height: 0.04 * context.height(),
                                      color: ColorPallet.colorPalletSambucus,
                                      child: Row(children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                0.016 * context.width()),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  repIndex = -1;
                                                });
                                              },
                                              child: const Center(
                                                child: CircleAvatar(
                                                    backgroundColor: Colors.red,
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 14,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 7,
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      0.7 * context.width()),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        0.02 * context.width()),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxHeight: 0.04 *
                                                                  context
                                                                      .height(),
                                                              maxWidth: 0.3 *
                                                                  context
                                                                      .width()),
                                                      child: Text(
                                                        state
                                                                .comments[
                                                                    repIndex]
                                                                .writer
                                                                .fullName! +
                                                            ': ',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 14),
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                    Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxHeight: 0.04 *
                                                                  context
                                                                      .height(),
                                                              maxWidth: 0.5 *
                                                                  context
                                                                      .width()),
                                                      child: Text(
                                                        state.comments[repIndex]
                                                            .content,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ))
                                      ]))
                                  : Container(),
                              Container(
                                  width: context.width(),
                                  height: context.height() * 0.08,
                                  color: (ColorPallet.colorPalletDark)
                                      .withOpacity(0.9),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.06 * context.width()),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: TextFormField(
                                            controller: textEditingController,
                                            // onSaved: (String? value) {
                                            //   message = value!;
                                            // },

                                            decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'نظر دهید...',
                                                hintStyle: TextStyle(
                                                    color: Colors.white)),
                                            maxLines: 6,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() async {
                                                Comments? comment;
                                                if (textEditingController
                                                        .text !=
                                                    '') {
                                                  if (repIndex == -1) {
                                                    comment = await BlocProvider
                                                            .of<CommentCubit>(
                                                                context)
                                                        .sendCommentEvent(
                                                            adminId: widget
                                                                .artPiece.id!,
                                                            text:
                                                                textEditingController
                                                                    .text);
                                                  } else {
                                                    comment = await BlocProvider
                                                            .of<CommentCubit>(
                                                                context)
                                                        .sendCommentEvent(
                                                            adminId: widget
                                                                .artPiece.id!,
                                                            parentId: state
                                                                .comments[
                                                                    repIndex]
                                                                .id,
                                                            text:
                                                                textEditingController
                                                                    .text);
                                                  }

                                                  if (comment != null) {
                                                    BlocProvider.of<
                                                                CommentCubit>(
                                                            context)
                                                        .emit(CommentLoaded([
                                                      ...state.comments,
                                                      comment
                                                    ]));
                                                    toast(
                                                        'نظر با موفقیت ثبت شد');
                                                  } else {}
                                                  textEditingController.text =
                                                      '';
                                                }
                                              });
                                              // CreateNewComment(user: comments[1].user,text: message);
                                            },
                                            child: const Icon(Icons.send,
                                                size: 25, color: Colors.white),
                                          ),
                                        )
                                      ])),
                            ],
                          ),
                        ),
                      ],
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
            ),
          ),
        ),
      ),
    );
  }
}

class CommentTileWidget extends StatefulWidget {
  Comments comment;
  Function changeState;
  int index;

  CommentTileWidget(this.comment, this.index,
      {Key? key, required this.changeState})
      : super(key: key);

  @override
  State<CommentTileWidget> createState() => _CommentTileWidgetState();
}

class _CommentTileWidgetState extends State<CommentTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 27,
                  backgroundColor: Colors.white,
                  child: Container(
                    child: CachedNetworkImage(
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover, image: imageProvider)),
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
                      imageUrl: widget.comment.writer.profilePhoto.isEmptyOrNull
                          ? "http://188.121.110.151:8000/media/images/icons8-test-account-64.png"
                          : widget.comment.writer.profilePhoto!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                widget.comment.writer.fullName!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              15.height,
                              Text(
                                widget.comment.content,
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                widget.comment.createdAt!.hour.toString() +
                                    ":" +
                                    widget.comment.createdAt!.minute.toString(),
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w400),
                              ),
                              IconButton(
                                  onPressed: () {
                                    widget.changeState(widget.index);
                                  },
                                  icon: Icon(Icons.reply_rounded)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            if (widget.comment.childComments.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Container(
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
                              imageUrl: widget.comment.childComments[index]
                                      .writer.profilePhoto.isEmptyOrNull
                                  ? "http://188.121.110.151:8000/media/images/icons8-test-account-64.png"
                                  : widget.comment.childComments[index].writer
                                      .profilePhoto!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        widget.comment.childComments[index]
                                            .writer.fullName!,
                                        style: const TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      7.height,
                                      Text(
                                        widget.comment.childComments[index]
                                            .content,
                                        style: const TextStyle(
                                            color: Colors.white54,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.comment.childComments[index]
                                                .createdAt!.hour
                                                .toString() +
                                            ":" +
                                            widget.comment.childComments[index]
                                                .createdAt!.minute
                                                .toString(),
                                        style: const TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                  itemCount: widget.comment.childComments.length,
                ),
              )
          ],
        ));
  }
}
