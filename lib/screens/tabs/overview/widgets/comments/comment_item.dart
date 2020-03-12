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
          Flexible(
            flex: 2,
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
                  _BuildImageThumbnail(comment.images, showList: !showFull),
                Gaps.vGap16,
                Gaps.vGap4,
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
    this.showList,
    Key key,
  }) : super(key: key);
  final List<String> images;
  final bool showList;

  @override
  Widget build(BuildContext context) {
    const int MAXTHUMBNAIL = 3;
    bool hasMore = images.length > MAXTHUMBNAIL;
    return Container(
      height: 100,
      padding: EdgeInsets.only(top: 16.0),
      child: showList
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hasMore ? MAXTHUMBNAIL : images.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => hasMore &&
                      index == MAXTHUMBNAIL - 1
                  ? Stack(children: [
                      _ThumbnailItem(
                        images[index],
                      ),
                      Positioned(
                        right: 8,
                        bottom: 3,
                        child: Card(
                            color: Colors.grey,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Gaps.hGap4,
                                  Icon(
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
                      )
                    ])
                  : _ThumbnailItem(
                      images[index],
                    ),

              //TODO add stack image count
            )
          : GridView.builder(
              itemCount: images.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) => _ThumbnailItem(images[index]),
            ),
    );
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
        width: 80,
      ),
    );
  }
}
