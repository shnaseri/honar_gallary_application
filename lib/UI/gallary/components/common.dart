import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_api_v14/api.dart';
import 'package:honar_gallary/UI/Art_piece/art_piece_page.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:honar_gallary/logic/general_values.dart';
import 'package:honar_gallary/state_managment/gallery/gallery_cubit.dart';
import 'package:nb_utils/nb_utils.dart';

const _defaultColor = Color(0xFF34568B);

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    Key? key,
    required this.title,
    this.topPadding = 0,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: child,
      ),
    );
  }
}

class Tile extends StatefulWidget {
  const Tile({
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
  final InlineResponse2003Posts post;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
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
                  builder: (_) => ArtPiecePage(artId: widget.post.id))).then(
                  (value) =>
                  BlocProvider.of<GalleryCubit>(context)
                      .fetchGallery(ConfigGeneralValues
                      .getInstance()
                      .userId!));
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
              borderRadius: BorderRadius.circular(9),
              boxShadow: const [
                BoxShadow(color: Colors.black26, spreadRadius: 0.2)
              ]),
          child: Stack(
            children: [
              Center(
                  child: CachedNetworkImage(
                      color: Colors.white,
                      imageUrl: widget.post.image,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: context.width(),
                          height: context.height() * 0.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              image: DecorationImage(
                                  fit: BoxFit.cover, image: imageProvider)),
                        );
                      },
                      placeholder: (context, url) {
                        return Container(
                          height: context.height() * 0.3,
                          width: context.width(),
                          decoration: const BoxDecoration(color: Colors.grey),
                        );
                      })),
              Positioned(
                child: Row(
                  children: [
                    Text(
                      (widget.post.countLike ?? 0).toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: Colors.pink),
                    ),
                    2.width,
                    const Icon(
                      Icons.favorite_border_rounded,
                      color: Colors.pinkAccent,
                    ),
                  ],
                ),
                top: 0,
                left: 5,
              ),
              if (showTitle)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    child: Text(
                      widget.post.title,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
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

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
  }) : super(key: key);

  final int index;
  final int width;
  final int height;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://picsum.photos/$width/$height?random=$index',
      width: width.toDouble(),
      height: height.toDouble(),
      fit: BoxFit.cover,
    );
  }
}

// class InteractiveTile extends StatefulWidget {
//   const InteractiveTile({
//     Key? key,
//     required this.index,
//     this.extent,
//     this.bottomSpace,
//   }) : super(key: key);
//
//   final int index;
//   final double? extent;
//   final double? bottomSpace;
//
//   @override
//   _InteractiveTileState createState() => _InteractiveTileState();
// }
//
// class _InteractiveTileState extends State<InteractiveTile> {
//   Color color = _defaultColor;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           if (color == _defaultColor) {
//             color = Colors.red;
//           } else {
//             color = _defaultColor;
//           }
//         });
//       },
//       child: Tile(
//         index: widget.index,
//         extent: widget.extent,
//         backgroundColor: color,
//         bottomSpace: widget.bottomSpace,
//       ),
//     );
//   }
// }

class ExplorerTile extends StatefulWidget {
  const ExplorerTile(
      {Key? key,
      required this.index,
      this.extent,
      this.backgroundColor,
      this.bottomSpace,
      required this.artPiece})
      : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;
  final ArtPiece artPiece;

  @override
  State<ExplorerTile> createState() => _ExplorerTileState();
}

class _ExplorerTileState extends State<ExplorerTile> {
  @override
  Widget build(BuildContext context) {
    final child = GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ArtPiecePage(
                      artId: widget.artPiece.id,
                    ),));
        },
        child: Container(
          height: widget.extent,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              boxShadow: const [
                BoxShadow(color: Colors.black26, spreadRadius: 0.2)
              ]),
          child: Center(
              child: Container(
            height: widget.extent,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, spreadRadius: 0.2)
                ]),
            child: Stack(
              children: [
                Center(
                    child: CachedNetworkImage(
                        color: Colors.white,
                        imageUrl: widget.artPiece.cover.image,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            width: context.width(),
                            height: context.height() * 0.3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                image: DecorationImage(
                                    fit: BoxFit.cover, image: imageProvider)),
                          );
                        },
                        placeholder: (context, url) {
                          return Container(
                            height: context.height() * 0.3,
                            width: context.width(),
                            decoration: const BoxDecoration(color: Colors.grey),
                          );
                        })),
                Positioned(
                  child: Row(
                    children: [
                      Text(
                        (widget.artPiece.likeCount ?? 0).toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: Colors.pink),
                      ),
                      2.width,
                      const Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.pinkAccent,
                      ),
                    ],
                  ),
                  top: 0,
                  left: 5,
                ),
                // if (showTitle)
                //   Container(
                //     decoration: BoxDecoration(
                //       color: Colors.black54,
                //       borderRadius: BorderRadius.circular(9),
                //     ),
                //     child: Center(
                //       child: Text(
                //         widget.post.title,
                //         style: const TextStyle(
                //             color: Colors.white, fontWeight: FontWeight.w700),
                //       ),
                //     ),
                //   )
              ],
            ),
          )),
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

class SearchTile extends StatefulWidget {
  const SearchTile({
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
  final ArtPieceCompact post;

  @override
  State<SearchTile> createState() => _SearchTileState();
}

class _SearchTileState extends State<SearchTile> {
  late bool showTitle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showTitle = false;
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
                  builder: (_) => ArtPiecePage(artId: widget.post.id)));
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
              borderRadius: BorderRadius.circular(9),
              boxShadow: const [
                BoxShadow(color: Colors.black26, spreadRadius: 0.2)
              ]),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                    child: CachedNetworkImage(
                        color: Colors.white,
                        imageUrl: widget.post.cover.image,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(9),
                                    topRight: Radius.circular(9)),
                                image: DecorationImage(
                                    fit: BoxFit.cover, image: imageProvider)),
                          );
                        },
                        placeholder: (context, url) {
                          return Container(
                            height: context.height() * 0.3,
                            width: context.width(),
                            decoration: const BoxDecoration(color: Colors.grey),
                          );
                        })),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorPallet.colorPalletNightFog,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(9),
                          bottomRight: Radius.circular(9))),
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FractionallySizedBox(
                                  widthFactor: 1,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.post.title,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorPallet
                                                    .colorPalletNightFog),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Text(
                                          widget.post.category.name,
                                          style: TextStyle(
                                              color: ColorPallet
                                                  .colorPalletNightFog,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
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
