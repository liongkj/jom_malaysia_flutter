import 'package:flutter/material.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/category_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/overview_page_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/ads_space.dart';
import 'package:jom_malaysia/setting/provider/base_list_provider.dart';
import 'package:jom_malaysia/widgets/my_refresh_list.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'category_item.dart';

class PlaceList extends StatefulWidget {
  const PlaceList({
    Key key,
    @required this.index,
  }) : super(key: key);

  final int index;

  @override
  _PlaceListState createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList>
    with AutomaticKeepAliveClientMixin<PlaceList> {
  /// 是否正在加载数据
  bool _isLoading = false;
  int _page = 1;
  final int _maxPage = 3;
  StateType _stateType = StateType.loading;
  int _index = 0;
  ScrollController _controller = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _index = widget.index;
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener(
      onNotification: (ScrollNotification note) {
        if (note.metrics.pixels == note.metrics.maxScrollExtent) {
          _loadMore();
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        displacement: 160.0, //40 + 120(header)
        child: Consumer<OverviewPageProvider>(
          builder: (_, provider, child) {
            return CustomScrollView(
              /// 这里指定controller可以与外层NestedScrollView的滚动分离，避免一处滑动，5个Tab中的列表同步滑动。
              /// 这种方法的缺点是会重新layout列表
              controller:
                  // _index != provider.index ?
                  _controller,
              key: PageStorageKey<String>("$_index"),

              slivers: <Widget>[
                // SliverOverlapInjector(
                //   ///SliverAppBar的expandedHeight高度,避免重叠
                //   handle:
                //       NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                // ),
                // SliverPersistentHeader(
                //   pinned: true,
                //   delegate: _SliverAppBarDelegate(
                //     minHeight: 60.0,
                //     maxHeight: 200.0,
                //     child: AdsSpace(),
                //   ),
                // ),
                Consumer<BaseListProvider<ListingModel>>(
                  builder: (_, listingProvider, child) {
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 8.0,
                      ),
                      sliver: listingProvider.list.isEmpty
                          ? SliverFillRemaining(
                              child: StateLayout(type: _stateType),
                            )
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return index < listingProvider.list.length
                                    ? CategoryItem(
                                        key: Key('order_item_$index'),
                                        index: index,
                                        tabIndex: _index,
                                        listing: listingProvider.list[index],
                                      )
                                    : MoreWidget(listingProvider.list.length,
                                        listingProvider.hasMore, 10);
                              }, childCount: listingProvider.list.length + 1),
                            ),
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }

  List _list = [];

  Future _onRefresh() async {}

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
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
