import 'package:flutter/material.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/presenter/overview_page_presenter.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/overview_page_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_item.dart';
import 'package:jom_malaysia/setting/provider/base_list_provider.dart';
import 'package:jom_malaysia/widgets/my_refresh_list.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
import 'package:provider/provider.dart';

class PlaceList extends StatefulWidget {
  const PlaceList({
    Key key,
    @required this.index,
    @required this.presenter,
    @required this.controller,
    this.city,
  }) : super(key: key);

  final int index;
  final OverviewPagePresenter presenter;
  final String city;
  final ScrollController controller;
  @override
  _PlaceListState createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList>
    with AutomaticKeepAliveClientMixin<PlaceList> {
  /// 是否正在加载数据
  bool _isLoading = false;
  int _page = 1;
  final int _maxPage = 3;
  int _index = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _index = widget.index;
    print("init");
  }

  @override
  void didUpdateWidget(PlaceList oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("dcd");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onRefresh();
    });
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
        displacement:
            MediaQuery.of(context).size.height * 0.06, //40 + 120(header)
        child: Consumer<OverviewPageProvider>(
          builder: (_, provider, child) {
            return CustomScrollView(
              /// 这里指定controller可以与外层NestedScrollView的滚动分离，避免一处滑动，5个Tab中的列表同步滑动。
              /// 这种方法的缺点是会重新layout列表
              controller: _index != provider.index ? widget.controller : null,
              key: PageStorageKey<String>("$_index"),
              slivers: <Widget>[
                Consumer<BaseListProvider<ListingModel>>(
                  builder: (_, listingProvider, child) {
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      sliver: listingProvider.list.isEmpty
                          ? SliverFillRemaining(
                              child:
                                  StateLayout(type: listingProvider.stateType),
                            )
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return index < listingProvider.list.length
                                    ? PlaceItem(
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

  Future _onRefresh() async {
    widget.presenter.refresh(widget.index);
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
}
