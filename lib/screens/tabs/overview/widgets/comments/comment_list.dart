import 'package:flutter/material.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/comments_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/comments/comment_item.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
import 'package:provider/provider.dart';

class CommentList extends StatefulWidget {
  CommentList(String placeId);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList>
    with AutomaticKeepAliveClientMixin {
  int _page = 1;
  final int _maxPage = 3;

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final height = MediaQuery.of(context).size.height * 0.1;

    return NotificationListener(
        onNotification: (ScrollNotification note) {
          if (note.metrics.pixels == note.metrics.maxScrollExtent) {
            _loadMore();
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: Consumer<CommentsProvider>(
            builder: (_, listingProvider, child) {
              // final placeList = listingProvider.fetchListingByType(_index);
              final commentList = null;
              // Provider.of<CommentsProvider>(context, listen: false)
              //     .fetchListingByType(_index);
              return SliverPadding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 10),
                sliver: commentList.isEmpty
                    ? SliverFillRemaining(
                        child: StateLayout(type: listingProvider.stateType),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return CommentItem(
                            commentList[index],
                            key: Key('order_item_$index'),
                          );
                        }, childCount: commentList.length),
                      ),
              );
            },
          ),
        ));
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
