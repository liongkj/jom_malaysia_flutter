import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/comments/comment_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/comments_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_button.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class CommentSection extends StatefulWidget {
  CommentSection({@required this.listingId, @required this.listingName});
  final String listingId;
  final String listingName;

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  List<CommentModel> comments = [];

  @override
  Widget build(BuildContext context) {
    final TextStyle sectionTitleStyle = Theme.of(context).textTheme.body1;
    final commentProvider =
        Provider.of<CommentsProvider>(context, listen: false);
    print(widget.listingId);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: MyCard(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: StreamBuilder(
                          stream: commentProvider
                              .fetchCommentsAsStream(widget.listingId),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              comments = snapshot.data.documents
                                  .map((doc) => CommentModel.fromMap(
                                      doc.data, doc.documentID))
                                  .toList();
                              final shouldLoad = comments.isNotEmpty;
                              return Column(children: <Widget>[
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        S.of(context).placeDetailCommentLabel(
                                            comments.length ?? 0),
                                        style:
                                            Theme.of(context).textTheme.body1,
                                      ),
                                      if (shouldLoad)
                                        GestureDetector(
                                          onTap: () {
                                            showToast("go to comment page");
                                          },
                                          child: LoadImage(
                                            "ic_arrow_right",
                                            height: 18,
                                          ),
                                        )
                                    ]),
                                Gaps.vGap16,
                                if (shouldLoad)
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: comments.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (buildContext, index) =>
                                        _BuildCommentCard(comments[index]),
                                  )
                                else
                                  MyButton(
                                    icon: Icon(Icons.rate_review),
                                    text: "Submit first review",
                                    onPressed: () {
                                      NavigatorUtils.push(context,
                                          '${OverviewRouter.reviewPage}?title=${widget.listingName}&placeId=${widget.listingId}&userId=${"123"}');
                                    },
                                  ),
                              ]);
                            } else {
                              return RefreshProgressIndicator();
                            }
                          })),
                ]),
          ),
        ),
      ),
    );
  }
}

class _BuildCommentCard extends StatelessWidget {
  _BuildCommentCard(this.comment);
  final CommentModel comment;

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
                    maxLines: 2,
                  ),

                  if (comment.images.isNotEmpty)
                    _BuildImageThumbnail(comment.images),
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
    Key key,
  }) : super(key: key);
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.0),
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemCount: images.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: LoadImage(
            images[index],
            height: 100,
            width: 110,
          ),
        ),
      ),
    );
  }
}
