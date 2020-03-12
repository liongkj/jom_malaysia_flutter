import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/comments/comment_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/comments_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/comments/comment_item.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_button.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
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
    const int _MAXCOMMENTCOUNT = 3;
    return StreamBuilder(
        stream: commentProvider.fetchCommentsAsStream(widget.listingId),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            comments = snapshot.data.documents
                .map((doc) => CommentModel.fromMap(doc.data, doc.documentID))
                .toList();
            final shouldLoad = comments?.isNotEmpty;
            return Column(
              children: <Widget>[
                _CommentHeader(
                    comments: comments, shouldLoad: shouldLoad, widget: widget),
                Gaps.vGap16,
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) => CommentItem(
                      comments[index],
                    ),
                    // return CommentItem(comments[index]);

                    itemCount: comments.length > _MAXCOMMENTCOUNT
                        ? _MAXCOMMENTCOUNT
                        : comments.length,
                  ),
                ),
                _CommentButton(
                    shouldLoad: shouldLoad,
                    listingId: widget.listingId,
                    listingName: widget.listingName),
              ],
            );
          }
          return SliverToBoxAdapter(
            child: Text(""),
          );
        });
  }

  // Widget _buildComment(Stream<QuerySnapshot> stream) {

  //   return ;
  // }
}

class _CommentButton extends StatelessWidget {
  const _CommentButton({
    Key key,
    @required this.shouldLoad,
    @required this.listingName,
    @required this.listingId,
  }) : super(key: key);

  final bool shouldLoad;
  final String listingName;
  final String listingId;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      icon: Icon(Icons.rate_review),
      text: shouldLoad ? "Say Something" : "Submit first review",
      onPressed: () {
        NavigatorUtils.push(context,
            '${OverviewRouter.reviewPage}?title=$listingName&placeId=$listingId&userId=${"123"}');
      },
    );
  }
}

class _CommentHeader extends StatelessWidget {
  const _CommentHeader({
    Key key,
    @required this.comments,
    @required this.shouldLoad,
    @required this.widget,
  }) : super(key: key);

  final List<CommentModel> comments;
  final bool shouldLoad;
  final CommentSection widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).placeDetailCommentLabel(comments.length ?? 0),
          style: Theme.of(context).textTheme.body1,
        ),
        if (shouldLoad)
          GestureDetector(
            onTap: () {
              NavigatorUtils.push(context,
                  '${OverviewRouter.commentPage}?&placeId=${widget.listingId}');
            },
            child: LoadImage(
              "ic_arrow_right",
              height: 18,
            ),
          )
      ],
    );
  }
}