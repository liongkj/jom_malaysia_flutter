import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/listing_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/overview_page_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/overview/place_item.dart';
import 'package:jom_malaysia/widgets/shimmer_item.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class PlaceList extends StatefulWidget {
  const PlaceList({
    Key key,
    @required this.onRefresh,
    @required this.index,
  }) : super(key: key);

  final int index;
  final Function onRefresh;

  @override
  _PlaceListState createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList>
    with AutomaticKeepAliveClientMixin {
  int _index = 0;

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _index = widget.index;
    _controller = ScrollController();
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
        onRefresh: widget.onRefresh,
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

  Widget _buildShimmer() {
    return SliverFillRemaining(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, __) => ShimmerItem(),
          itemCount: 6,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
