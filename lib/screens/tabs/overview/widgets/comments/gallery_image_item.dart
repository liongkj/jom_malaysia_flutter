import 'package:flutter/material.dart';
import 'package:jom_malaysia/widgets/load_image.dart';

class GalleryImageItem {
  GalleryImageItem({
    this.tagId,
    this.url,
  });

  final String tagId;
  final String url;
}

class GalleryItemThumbnail extends StatelessWidget {
  const GalleryItemThumbnail({Key key, this.galleryItem, this.onTap})
      : super(key: key);

  final GalleryImageItem galleryItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: galleryItem.tagId,
          child: LoadImage(
            galleryItem.url,
            height: 80.0,
            width: 80,
          ),
        ),
      ),
    );
  }
}
