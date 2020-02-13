import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/comments/comment_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/comments_provider.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_button.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class CommentSection extends StatefulWidget {
  CommentSection(this.listingId);
  final String listingId;

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
                                    onPressed: () {},
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
      width: 500,
      child: Row(
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
          Container(
            color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(comment.title),
                    Text("Rating *****"),
                  ],
                ),
                Text(comment.publishedTime ?? "2019/2/21"),
                Text("Rating *****"),
                Text(comment.commentText),
                Row(children: [
                  LoadImage(
                    "",
                    height: 80,
                  ),
                  Gaps.hGap4,
                  LoadImage(
                    "",
                    height: 80,
                  ),
                  Gaps.hGap4,
                  LoadImage(
                    "",
                    height: 80,
                  )
                ]),
                Gaps.vGap12,
                Gaps.line,
                Gaps.vGap12,
              ],
            ),
          )
        ],
      ),
    );
  }
}
