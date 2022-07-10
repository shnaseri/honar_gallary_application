import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:honar_api_v18/api.dart';
import 'package:honar_gallary/UI/video_music_palyer/components/image_view.dart';
import 'package:nb_utils/nb_utils.dart';

class PhotoScroller extends StatelessWidget {
  const PhotoScroller(this.photoUrls, {Key? key}) : super(key: key);
  final List<ImageSerializer> photoUrls;

  Widget _buildPhoto(BuildContext context, int index) {
    var photo = photoUrls[index];

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ImageShowPage(
                      content: photo.image!,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: CachedNetworkImage(
                color: Colors.white,
                imageUrl: photo.image!,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: context.height() * 0.3,
                    width: context.width() * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        image: DecorationImage(
                            fit: BoxFit.cover, image: imageProvider)),
                  );
                },
                placeholder: (context, url) {
                  return Container(
                    height: context.height() * 0.3,
                    width: context.width() * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(11),
                    ),
                  );
                })),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'تصاویر',
            style: textTheme.subtitle1!.copyWith(fontSize: 18.0),
          ),
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(100.0),
          child: ListView.builder(
            itemCount: photoUrls.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 8.0, left: 20.0),
            itemBuilder: _buildPhoto,
          ),
        ),
      ],
    );
  }
}
