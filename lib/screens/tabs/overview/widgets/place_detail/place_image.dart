import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/models/image_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/comments/single_photo_view.dart';
import 'package:jom_malaysia/widgets/load_image.dart';

class PlaceImage extends StatefulWidget {
  final List<ImageModel> images;
  const PlaceImage({
    Key key,
    this.images,
  }) : super(key: key);

  @override
  _PlaceImageState createState() => _PlaceImageState();
}

class _PlaceImageState extends State<PlaceImage> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SinglePhotoView(
                    imageProvider: NetworkImage(widget.images[index].url),
                    tagId: "image-ads-$index"),
              ),
            ),
            child: LoadImage(
              widget.images[index].url,
              fit: BoxFit.fitWidth,
            ),
          );
        },
        childCount: widget.images.length,
      ),
    );
  }
}
