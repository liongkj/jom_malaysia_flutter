import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jom_malaysia/core/mvp/base_page_state.dart';
import 'package:jom_malaysia/core/res/colors.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/operating_hours_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/presenter/place_detail_page_presenter.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/place_detail_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_info.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/date_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
import 'package:provider/provider.dart';

import '../../../../util/theme_utils.dart';

class PlaceDetailPage extends StatefulWidget {
  const PlaceDetailPage(this.placeId);

  final String placeId;
  @override
  PlaceDetailPageState createState() => PlaceDetailPageState();
}

const kExpandedHeight = 250.0;

class PlaceDetailPageState
    extends BasePageState<PlaceDetailPage, PlaceDetailPagePresenter> {
  bool isDark = false;
  PlaceDetailProvider provider = PlaceDetailProvider();

  void setPlace(ListingModel place) {
    provider.setPlace(place);
  }

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    provider.setStateTypeNotNotify(StateType.empty);
    _scrollController = ScrollController()..addListener(() => setState(() {}));
  }

  @override
  PlaceDetailPagePresenter createPresenter() {
    return PlaceDetailPagePresenter();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool get _showTitle {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    isDark = ThemeUtils.isDark(context);
    return ChangeNotifierProvider<PlaceDetailProvider>(
        create: (_) => provider,
        child: Consumer<PlaceDetailProvider>(builder: (_, detail, __) {
          final place = detail.place;
          return Scaffold(
            body: SafeArea(
                child: CustomScrollView(
              controller: _scrollController,
              key: const Key('place_detail'),
              physics: BouncingScrollPhysics(),
              slivers: detail.stateType != StateType.loading
                  ? <Widget>[]
                  : _sliverBuilder(place),
            )),
          );
        }));
  }

  List<Widget> _sliverBuilder(ListingModel place) {
    return <Widget>[
      SliverAppBar(
        // brightness: Brightness.dark,
        backgroundColor: ThemeUtils.getBackgroundColor(context),
        titleSpacing: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: _showTitle ? Colors.black : ThemeUtils.getIconColor(context),
          onPressed: () => NavigatorUtils.goBack(context),
        ),
        centerTitle: true,
        title: _showTitle
            ? Text(
                '${place.category.getCategory()} detail',
                style: Theme.of(context).textTheme.title,
              )
            : null,
        expandedHeight: kExpandedHeight,
        floating: false, // 不随着滑动隐藏标题
        pinned: true, // 固定在顶部
        flexibleSpace: _showTitle
            ? null
            : FlexibleSpaceBar(
                titlePadding:
                    const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
                collapseMode: CollapseMode.pin,
                background: _CoverPhotos(),
                centerTitle: true,
              ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color:
                  _showTitle ? Colors.black : ThemeUtils.getIconColor(context),
            ),
            onPressed: () {},
          )
        ],
      ),
      SliverFillRemaining(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PlaceInfo(place),
              Gaps.vGap16,
              _OperatingHour(place.operatingHours),
              Gaps.vGap16,
              _PlaceDescription(place),
              Gaps.vGap16,
              Text("ads"),
              Gaps.vGap8,
              Gaps.vGap8,
              Text("Merchant info"),
            ],
          ),
        ),
      ),
    ];
  }
}

class _PlaceDescription extends StatelessWidget {
  final ListingModel place;
  _PlaceDescription(this.place);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(place.description),
    );
  }
}

class _OperatingHour extends StatelessWidget {
  final List<OperatingHours> operatingHours;

  _OperatingHour(this.operatingHours);
  @override
  Widget build(BuildContext context) {
    //weekday returns 1-7
    final _today = DateTime.now().weekday - 1;
    return Material(
      child: InkWell(
        onTap: () => {},
        child: MyCard(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const LoadAssetImage("place/icon_wait",
                    width: 18.0, height: 18.0),
                Gaps.hGap12,
                Expanded(
                  flex: 6,
                  child: operatingHours[_today] != null
                      ? Row(children: <Widget>[
                          Text(
                              '${operatingHours[_today].openHour} - ${operatingHours[_today].closeHour}'),
                          Gaps.hGap15,
                          operatingHours[_today].closingSoon
                              ? Text(
                                  'OPEN',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              : Text(
                                  'CLOSING SOON',
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                        ])
                      : Row(
                          children: <Widget>[
                            Text(
                              'CLOSED',
                              style: TextStyle(
                                  color: Theme.of(context).errorColor),
                            )
                          ],
                        ),
                ),
                Gaps.vLine,
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.navigate_next,
                    size: 24,
                    color: ThemeUtils.getIconColor(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CoverPhotos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  ListView.separated(
    //   scrollDirection: Axis.horizontal,
    //   separatorBuilder: (BuildContext context, int index) => Divider(),
    //   itemCount: count,
    //   itemBuilder: (context, index) {
    return Consumer<PlaceDetailProvider>(builder: (_, provider, child) {
      List<String> swiper = provider.place.listingImages.getCarousel;
      return Swiper(
        itemBuilder: (BuildContext context, int index) {
          return LoadImage(
            provider.stateType == StateType.loading ? (swiper[index]) : "none",
            fit: BoxFit.cover,
          );
        },
        itemCount: swiper.length,
        loop: false,
      );
    });
    //   return Stack(children: <Widget>[
    //     Container(
    //       width: MediaQuery.of(context).size.width,
    //       padding: EdgeInsets.all(5),
    //       child: Image.network(
    //         cover.url,
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     Positioned(
    //         top: 200,
    //         left: 260,
    //         child: FlatButton.icon(
    //             color: Colors.white,
    //             onPressed: null,
    //             icon: Icon(Icons.photo_camera, color: Colors.white),
    //             label: Text(
    //               (index + 1).toString() + "/" + count.toString(),
    //               style: TextStyle(color: Colors.white),
    //             )))
    //   ]);
  }
}

class _PlaceInfo extends StatelessWidget {
  _PlaceInfo(this.place);

  final ListingModel place;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: MyCard(
        child: Container(
          alignment: Alignment.center,
          height: 120.0,
          child: Text(
            place.merchant.registrationName,
            style: TextStyle(
                fontSize: 20.0,
                color: ThemeUtils.isDark(context)
                    ? Colours.dark_text
                    : Colours.text),
          ),
        ),
      ),
    );
  }
}
