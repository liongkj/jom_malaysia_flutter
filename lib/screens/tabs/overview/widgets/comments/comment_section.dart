import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  CommentSection({
    Key key,
    @required this.listingId,
    @required this.listingName,
    @required this.addNewReview,
  }) : super(key: key);
  final Function addNewReview;
  final String listingId;
  final String listingName;

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  List<CommentModel> comments = [];

  @override
  Widget build(BuildContext context) {
    final commentProvider =
        Provider.of<CommentsProvider>(context, listen: false);
    const int _MAXCOMMENTCOUNT = 3;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyCard(
        child: StreamBuilder(
            stream: commentProvider.fetchCommentsAsStream(widget.listingId),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                comments = snapshot.data.documents
                    .map(
                        (doc) => CommentModel.fromMap(doc.data, doc.documentID))
                    .toList();
                final hasMoreThanMax = comments.length > _MAXCOMMENTCOUNT;
                final shouldLoad = comments?.isNotEmpty;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: <Widget>[
                      _CommentHeader(
                          comments: comments,
                          shouldLoad: shouldLoad,
                          widget: widget),
                      Gaps.vGap16,
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) => CommentItem(
                            comments[index],
                            itemIndex: index,
                          ),
                          itemCount: hasMoreThanMax
                              ? _MAXCOMMENTCOUNT
                              : comments.length,
                        ),
                      ),
                      _CommentButton(
                        shouldLoad: shouldLoad,
                        listingId: widget.listingId,
                        listingName: widget.listingName,
                        addNewReview: widget.addNewReview,
                      ),
                    ],
                  ),
                );
              }
              return SpinKitSquareCircle(
                color: Theme.of(context).accentColor,
              );
            }),
      ),
    );
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
    @required this.addNewReview,
  }) : super(key: key);
  final Function addNewReview;
  final bool shouldLoad;
  final String listingName;
  final String listingId;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      icon: Icon(Icons.rate_review),
      text: shouldLoad
          ? S.of(context).labelAskReview
          : S.of(context).labelAskFirstReview,
      onPressed: addNewReview,
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
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        NavigatorUtils.push(context,
            '${OverviewRouter.commentPage}?&placeId=${widget.listingId}');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).placeDetailCommentCountLabel(comments.length ?? 0),
            style: Theme.of(context).textTheme.body1,
          ),
          if (shouldLoad)
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: LoadImage(
                  "ic_arrow_right",
                  height: 18,
                  fit: BoxFit.contain,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
