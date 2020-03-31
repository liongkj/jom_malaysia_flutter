import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/gaps.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/listing_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/overview_page_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/overview/place_item.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
    with AutomaticKeepAliveClientMixin {
  /// 是否正在加载数据
  bool _isLoading = false;
  int _page = 1;
  final int _maxPage = 3;
  int _index = 0;

  ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _index = widget.index;
    _controller = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final height = MediaQuery.of(context).size.height * 0.1;

    return NotificationListener(
      onNotification: (ScrollNotification note) {
        if (note.metrics.pixels == note.metrics.maxScrollExtent) {
          // _loadMore();
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        displacement: height, //40 + 120(header)
        child: Consumer<OverviewPageProvider>(
          builder: (_, provider, placeListChild) {
            return CustomScrollView(
              /// 这里指定controller可以与外层NestedScrollView的滚动分离，避免一处滑动，5个Tab中的列表同步滑动。
              /// 这种方法的缺点是会重新layout列表
              controller: _index != provider.index ? _controller : null,
              key: PageStorageKey<String>("$_index"),
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                placeListChild
              ],
            );
          },
          child: Consumer<ListingProvider>(
            builder: (_, listing, child) {
              final placeList =
                  Provider.of<ListingProvider>(context, listen: false)
                      .fetchListingByType(_index);
              return SliverPadding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                sliver: placeList.isEmpty
                    ? StateType.loading == listing.stateType
                        ? _buildShimmer()
                        : SliverFillRemaining(
                            child: StateLayout(type: listing.stateType),
                          )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return PlaceItem(
                            key: Key('order_item_$index'),
                            index: index,
                            tabIndex: _index,
                            listing: placeList[index],
                          );
                        }, childCount: placeList.length),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildShimmer() {
    return SliverToBoxAdapter(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: ListView.builder(
          itemCount: 6,
          shrinkWrap: true,
          itemBuilder: (_, __) => Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                8.0,
                0.0,
                16.0,
                8.0,
              ),
              child: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        height: 80.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: 40.0,
                              height: 8.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List _list = [];

  Future _onRefresh() async {
    var loc = Provider.of<LocationProvider>(context, listen: false)
        .selected
        ?.cityName;
    Provider.of<ListingProvider>(context, listen: false)
        .fetchAndInitPlaces(city: loc, refresh: true);
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
