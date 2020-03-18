import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/models/image_model.dart';
import 'package:jom_malaysia/widgets/load_image.dart';

class PlaceImage extends StatelessWidget {
  final List<ImageModel> images;
  const PlaceImage({
    Key key,
    this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return LoadImage(
            images[index].url,
            fit: BoxFit.fill,
          );
        },
        childCount: images.length,
      ),
    );
  }
}
