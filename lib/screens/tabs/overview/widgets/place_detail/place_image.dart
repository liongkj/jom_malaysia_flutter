import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/models/image_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/comments/single_photo_view.dart';
import 'package:jom_malaysia/widgets/load_image.dart';

class PlaceImage extends StatelessWidget {
  final List<ImageModel> images;
  const PlaceImage({
    Key key,
    this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SinglePhotoView(
                        imageProvider: NetworkImage(images[index].url),
                        tagId: "image-ads-$index"),
                  ),
                ),
                child: LoadImage(
                  images[index].url,
                  fit: BoxFit.fitWidth,
                ),
              );
            },
            itemCount: images.length,
          ),
        ),
      ],
    );
  }
}
