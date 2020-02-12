import 'package:flutter/material.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/listing_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/overview_page_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_item.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
import 'package:provider/provider.dart';

class PlaceList extends StatefulWidget {
  const PlaceList({
    Key key,
    @required this.index,
    @required this.controller,
  }) : super(key: key);

  final int index;

  final ScrollController controller;

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
  bool _isInit = true;
  StateType _stateType = StateType.places;
  String _selectedCity;

  @override
  void initState() {
    super.initState();
    _index = widget.index;
    _selectedCity =
        Provider.of<LocationProvider>(context, listen: false).selected;
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final location = Provider.of<LocationProvider>(context, listen: false);
      if (_isInit || location.rebuildHome) {
        Provider.of<ListingProvider>(context, listen: false).fetchAndInitPlaces(
            city: location.selected, refresh: location.rebuildHome);
      }
      Provider.of<LocationProvider>(context, listen: false).rebuildHome = false;
      _isInit = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final height = MediaQuery.of(context).size.height * 0.06;

    return NotificationListener(
      onNotification: (ScrollNotification note) {
        if (note.metrics.pixels == note.metrics.maxScrollExtent) {
          _loadMore();
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        displacement: height, //40 + 120(header)
        child: Consumer<OverviewPageProvider>(
          builder: (_, provider, child) {
            return CustomScrollView(
              /// 这里指定controller可以与外层NestedScrollView的滚动分离，避免一处滑动，5个Tab中的列表同步滑动。
              /// 这种方法的缺点是会重新layout列表
              controller: _index != provider.index ? widget.controller : null,
              key: PageStorageKey<String>("$_index"),

              slivers: <Widget>[child],
            );
          },
          child: Consumer<ListingProvider>(
            builder: (_, listingProvider, child) {
              // final placeList = listingProvider.fetchListingByType(_index);
              final placeList =
                  Provider.of<ListingProvider>(context, listen: false)
                      .fetchListingByType(_index);
              return SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                sliver: placeList.isEmpty
                    ? SliverFillRemaining(
                        child: StateLayout(type: _stateType),
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

  List _list = [];

  Future _onRefresh() async {
    Provider.of<ListingProvider>(context, listen: false)
        .fetchAndInitPlaces(city: _selectedCity, refresh: true);
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
