import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/tabs/overview/provider/overview_page_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_list.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/image_utils.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:jom_malaysia/widgets/my_flexible_space_bar.dart';
import 'package:provider/provider.dart';

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage>
    with
        AutomaticKeepAliveClientMixin<OverviewPage>,
        SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  TabController _tabController;
  OverviewPageProvider provider = OverviewPageProvider();
  PageController _pageController = PageController(initialPage: 0);

  _onPageChange(int index) async {
    provider.setIndex(index);
    _tabController.animateTo(index);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _preCacheImage();
    });
  }

  // _preCacheImage() {
  //   precacheImage(ImageUtils.getAssetImage("order/xdd_n"), context);
  //   precacheImage(ImageUtils.getAssetImage("order/dps_s"), context);
  //   precacheImage(ImageUtils.getAssetImage("order/dwc_s"), context);
  //   precacheImage(ImageUtils.getAssetImage("order/ywc_s"), context);
  //   precacheImage(ImageUtils.getAssetImage("order/yqx_s"), context);
  // }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    isDark = ThemeUtils.isDark(context);
    return ChangeNotifierProvider<OverviewPageProvider>(
      create: (_) => provider,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: SizedBox(
                height: 105,
                width: double.infinity,
                child: isDark
                    ? null
                    : const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: const [
                              Color(0xFF5793FA),
                              Color(0xFF4647FA)
                            ],
                          ),
                        ),
                      ),
              ),
            ),
            NestedScrollView(
              key: const Key('order_list'),
              physics: ClampingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return _sliverBuilder(context);
              },
              controller: new ScrollController(),
              body:
                  // new AdSwiper(),
                  PageView.builder(
                key: const Key('pageView'),
                itemCount: 5,
                onPageChanged: _onPageChange,
                controller: _pageController,
                itemBuilder: (_, index) {
                  return PlaceList(index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        child: SliverAppBar(
          leading: Gaps.empty,
          brightness: Brightness.dark,
          actions: <Widget>[
            GestureDetector(
              // key: _buttonKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Negeri Sembilan",
                      style: TextStyles.textBold16,
                    ),
                    IconButton(
                      onPressed: () {
                        NavigatorUtils.push(context, "");
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: ThemeUtils.getIconColor(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                NavigatorUtils.push(context, "");
              },
              tooltip: 'Search',
              icon: Icon(
                Icons.search,
                color: ThemeUtils.getIconColor(context),
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          expandedHeight: 140.0,
          floating: false, // 不随着滑动隐藏标题
          pinned: true, // 固定在顶部
          flexibleSpace: MyFlexibleSpaceBar(
            background: isDark
                ? Container(
                    height: 113.0,
                    color: Colours.dark_bg_color,
                  )
                : const LoadAssetImage(
                    "order/order_bg",
                    width: double.infinity,
                    height: 113.0,
                    fit: BoxFit.fill,
                  ),
            centerTitle: true,
            titlePadding:
                const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
            collapseMode: CollapseMode.pin,
            title: _CurrentLocation(),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          DecoratedBox(
            decoration: BoxDecoration(
                color: isDark ? Colours.dark_bg_color : null,
                image: isDark
                    ? null
                    : DecorationImage(
                        image: ImageUtils.getAssetImage("order/order_bg1"),
                        fit: BoxFit.fill)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _ListingTypeTab(
                  tabController: _tabController,
                  mounted: mounted,
                  pageController: _pageController),
            ),
          ),
          80.0,
        ),
      ),
    ];
  }
}

class _CurrentLocation extends StatelessWidget {
  const _CurrentLocation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            Icons.near_me,
            size: Dimens.font_sp16,
            color: ThemeUtils.getIconColor(context),
          ),
          Gaps.hGap8,
          Text(
            "Seremban",
            style: TextStyle(
                color: ThemeUtils.getIconColor(context),
                fontSize: Dimens.font_sp16),
          ),
        ],
      ),
    );
  }
}

class _ListingTypeTab extends StatelessWidget {
  const _ListingTypeTab({
    Key key,
    @required TabController tabController,
    @required this.mounted,
    @required PageController pageController,
  })  : _tabController = tabController,
        _pageController = pageController,
        super(key: key);

  final TabController _tabController;
  final bool mounted;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Container(
        height: 80.0,
        padding: const EdgeInsets.only(top: 8.0),
        child: TabBar(
          isScrollable: true,
          labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          controller: _tabController,
          labelColor:
              ThemeUtils.isDark(context) ? Colours.dark_text : Colours.text,
          unselectedLabelColor: ThemeUtils.isDark(context)
              ? Colours.dark_text_gray
              : Colours.text,
          labelStyle: TextStyles.textBold14,
          unselectedLabelStyle: const TextStyle(
            fontSize: Dimens.font_sp12,
          ),
          indicatorColor: Colors.transparent,
          tabs: const <Widget>[
            const _TabView(0, 'Shops', Icons.restaurant),
            const _TabView(1, 'Attractions', Icons.local_play),
            const _TabView(2, 'Government', Icons.location_city),
            const _TabView(3, 'Professional', Icons.work),
            const _TabView(4, 'NGO', Icons.people),
          ],
          onTap: (index) {
            if (!mounted) {
              return;
            }
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}

class AdSwiper extends StatelessWidget {
  const AdSwiper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "http://via.placeholder.com/288x188",
            fit: BoxFit.fill,
          );
        },
        itemCount: 10,
        viewportFraction: 0.8,
        scale: 0.9);
  }
}

class _TabView extends StatelessWidget {
  const _TabView(this.index, this.text, this.icon);

  final int index;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Consumer<OverviewPageProvider>(
      builder: (_, provider, child) {
        return Container(
          width: 80.0,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 24.0,
              ),
              Gaps.vGap4,
              Text(
                text,
                style: TextStyle(
                  fontSize: Dimens.font_sp14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;
  SliverAppBarDelegate(this.widget, this.height);

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
