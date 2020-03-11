import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/comments/comment_model.dart';
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
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: LoadImage(
              "",
              width: 50,
              height: 50,
            ),
          ),
          Gaps.hGap16,
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        "liongkj",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      )),
                      Text(comment.rating?.toString() ?? "N/A"),
                    ],
                  ),
                  Gaps.vGap5,
                  Text(
                    comment.publishedTime.toString(),
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  Gaps.vGap5,
                  Text(
                    comment.title,
                    style: Theme.of(context).textTheme.body2,
                  ),
                  Gaps.vGap12,
                  //TODO use date util
                  Text(
                    comment.commentText,
                    maxLines: showFull ? 5 : 2,
                  ),

                  if (comment.images?.isNotEmpty)
                    _BuildImageThumbnail(comment.images, showList: showFull),
                  Gaps.vGap16,
                  Gaps.vGap4,
                  Gaps.line
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildImageThumbnail extends StatelessWidget {
  _BuildImageThumbnail(
    this.images, {
    this.showList,
    Key key,
  }) : super(key: key);
  final List<String> images;
  final bool showList;
  @override
  Widget build(BuildContext context) {
    if (showList)
      return Container(
        padding: EdgeInsets.only(top: 16.0),
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          itemCount: images.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => _ThumbnailItem(
            images[index],
          ),
        ),
      );
    else {
      return Container(
        padding: EdgeInsets.only(top: 16.0),
        height: 120,
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) => _ThumbnailItem(images[index]),
        ),
      );
    }
  }
}

class _ThumbnailItem extends StatelessWidget {
  const _ThumbnailItem(
    this.image, {
    Key key,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: LoadImage(
        image,
        height: 100,
        width: 110,
      ),
    );
  }
}
