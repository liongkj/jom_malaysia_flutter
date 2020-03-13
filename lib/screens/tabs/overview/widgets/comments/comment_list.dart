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
  int _page = 1;
  final int _maxPage = 3;
  bool _isLoading = false;
  List<CommentModel> commentList = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final commentProvider =
        Provider.of<CommentsProvider>(context, listen: false);
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
              stream: commentProvider.fetchCommentsAsStream(
                widget.placeId,
              ),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  commentList = snapshot.data.documents
                      .map((doc) =>
                          CommentModel.fromMap(doc.data, doc.documentID))
                      .toList();
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 8.0, right: 16.0),
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => CommentItem(
                                    commentList[index],
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
        // SliverToBoxAdapter(
        //   child: Container(
        //     padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        //     child: MyCard(
        //       child: Container(
        //         child: SliverPadding(
        //           padding: const EdgeInsets.all(16.0),
        //           sliver:
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }

  List _list = [];

  Future _onRefresh() async {
    // var loc = Provider.of<CommentsProvider>(context, listen: false)
    //     .selected
    //     ?.cityName;
    // Provider.of<CommentsProvider>(context, listen: false)
    //     .fetchAndInitPlaces(city: loc, refresh: true);
  }

  bool _hasMore() {
    return _page < _maxPage;
  }

  Future _loadMore() async {
    if (_isLoading) {
      return;
    }
    if (!_hasMore()) {
      return;
    }
    _isLoading = true;
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _list.addAll(List.generate(10, (i) => 'newItem：$i'));
        _page++;
        _isLoading = false;
      });
    });
  }

  @override
  bool get wantKeepAlive => true;
}
