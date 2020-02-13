import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/comments/comment_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/comments_provider.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
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
    final TextStyle textTextStyle =
        Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
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
                  Text(
                    S.of(context).placeDetailCommentLabel,
                    style: textTextStyle,
                  ),
                  Gaps.vGap12,
                  Container(
                      child: StreamBuilder(
                          stream: commentProvider
                              .fetchCommentsAsStream(widget.listingId),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            print(snapshot.data);
                            if (snapshot.hasData) {
                              comments = snapshot.data.documents
                                  .map((doc) => CommentModel.fromMap(
                                      doc.data, doc.documentID))
                                  .toList();

                              // print(comments);
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: comments.length,
                                itemBuilder: (buildContext, index) =>
                                    CommentCard(comments[index]),
                              );
                            } else {
                              return Text('fetching');
                            }
                          })),
                ]),
          ),
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  CommentCard(this.comment);
  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(comment.commentText),
    );
  }
}
