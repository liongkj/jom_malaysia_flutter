import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/comments/comment_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/comments_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/comments/comment_item.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:provider/provider.dart';

class CommentList extends StatefulWidget {
  CommentList(this.placeId);

  final String placeId;

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList>
    with AutomaticKeepAliveClientMixin {
  List<CommentModel> commentList = [];
  CommentsProvider commentsProvider;

  @override
  void initState() {
    commentsProvider = Provider.of<CommentsProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: MyAppBar(
        centerTitle: S.of(context).labelPageComment,
        backImg: "assets/images/ic_close.png",
      ),
      body: NotificationListener(
        onNotification: (ScrollNotification note) {
          if (note.metrics.pixels == note.metrics.maxScrollExtent) {
            _loadMore();
          }
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyCard(
            child: StreamBuilder(
              stream: commentsProvider.fetchCommentsAsStream(
                widget.placeId,
              ),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  commentList = snapshot.data.documents
                      .map((doc) =>
                          CommentModel.fromMap(doc.data, doc.documentID))
                      .toList();
                  commentList.sort(
                      (a, b) => (a.publishedTime).compareTo(b.publishedTime));
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 8.0, right: 16.0),
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => CommentItem(
                                    commentList[index],
                                    itemIndex: index,
                                    showFull: true,
                                  ),
                              childCount: commentList.length),
                        )
                      ],
                    ),
                  );
                } else {
                  //TODO handle no data error
                  return Center(child: RefreshProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future _loadMore() async {}

  @override
  bool get wantKeepAlive => true;
}
