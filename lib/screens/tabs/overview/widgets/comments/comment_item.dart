import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/comments/comment_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/comments/gallery_image_item.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/comments/gallery_photo_view.dart';
import 'package:jom_malaysia/widgets/load_image.dart';

class CommentItem extends StatelessWidget {
  CommentItem(
    this.comment, {
    Key key,
    this.showFull = false,
  });
  final CommentModel comment;
  final bool showFull;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: comment?.user?.profileImage != null
                ? NetworkImage(comment.user.profileImage)
                : AssetImage("assets/images/none.png"),
          ),
          Gaps.hGap16,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _Username(comment: comment),
                Gaps.vGap5,
                _CommentTime(comment: comment),
                Gaps.vGap5,
                _CommentTitle(comment: comment),
                Gaps.vGap12,
                //TODO use date util
                _CommentField(comment: comment, showFull: showFull),
                if (comment.images?.isNotEmpty)
                  _BuildImageThumbnail(comment.images, showListView: !showFull),
                Gaps.vGap16,
                Gaps.line
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentField extends StatelessWidget {
  const _CommentField({
    Key key,
    @required this.comment,
    @required this.showFull,
  }) : super(key: key);

  final CommentModel comment;
  final bool showFull;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        comment.commentText,
        maxLines: showFull ? 5 : 2,
      ),
    );
  }
}

class _CommentTitle extends StatelessWidget {
  const _CommentTitle({
    Key key,
    @required this.comment,
  }) : super(key: key);

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        comment.title,
        style: Theme.of(context).textTheme.body2,
      ),
    );
  }
}

class _CommentTime extends StatelessWidget {
  const _CommentTime({
    Key key,
    @required this.comment,
  }) : super(key: key);

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        comment.publishedTime.toString(),
        style: Theme.of(context).textTheme.subtitle,
      ),
    );
  }
}

class _Username extends StatelessWidget {
  const _Username({
    Key key,
    @required this.comment,
  }) : super(key: key);

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Text(
              "liongkj",
              style: TextStyle(
                  color: Colors.blueAccent, fontWeight: FontWeight.bold),
            ),
          ),
          Text(comment.rating?.toString() ?? "N/A"),
        ],
      ),
    );
  }
}

class _BuildImageThumbnail extends StatelessWidget {
  _BuildImageThumbnail(
    this.images, {
    this.showListView,
    Key key,
  }) : super(key: key);
  final List<String> images;
  final bool showListView;

  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoView(
          galleryItems: images
              .map(
                (f) => GalleryImageItem(
                    url: f,
                    tagId: showListView
                        ? "image-list-${images.indexOf(f)}"
                        : "image-grid-${images.indexOf(f)}"),
              )
              .toList(),
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const int MAXTHUMBNAIL = 3;
    bool hasMore = images.length > MAXTHUMBNAIL;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(minHeight: 50.0, maxHeight: showListView ? 70 : 200),
        child: showListView
            ? Stack(
                children: [
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: hasMore ? MAXTHUMBNAIL : images.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => _ThumbnailItem(
                      onTap: () => open(context, index),
                      index: index,
                      image: GalleryImageItem(
                          url: images[index], tagId: "image-list-$index"),
                    ),
                  ),
                  if (hasMore) _HasMoreIndicator(images: images),
                ],
              )
            : GridView.builder(
                shrinkWrap: true,
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                ),
                itemBuilder: (context, index) => _ThumbnailItem(
                  onTap: () => open(context, index),
                  index: index,
                  image: GalleryImageItem(
                      url: images[index], tagId: "image-grid-$index"),
                ),
                physics: NeverScrollableScrollPhysics(),
              ),
      ),
    );
  }
}

class _ThumbnailItem extends StatelessWidget {
  const _ThumbnailItem({
    this.image,
    Key key,
    this.index,
    this.onTap,
  }) : super(key: key);

  final GalleryImageItem image;
  final int index;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: GalleryItemThumbnail(
        onTap: onTap,
        galleryItem: image,
      ),
    );
  }
}

class _HasMoreIndicator extends StatelessWidget {
  const _HasMoreIndicator({
    Key key,
    @required this.images,
  }) : super(key: key);

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 8,
      bottom: 3,
      child: Card(
          color: Colors.grey,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Gaps.hGap4,
                const Icon(
                  Icons.image,
                  color: Colors.white,
                  size: 12,
                ),
                Gaps.hGap4,
                Text(
                  (images.length - 3).toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                Gaps.hGap4,
              ],
            ),
          )),
    );
  }
}
