import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jom_malaysia/core/mvp/base_page_state.dart';
import 'package:jom_malaysia/core/res/colors.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/operating_hours_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/overview_page.dart';
import 'package:jom_malaysia/screens/tabs/overview/presenter/place_detail_page_presenter.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/place_detail_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_info_item.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/image_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:jom_malaysia/widgets/my_flexible_space_bar.dart';
import 'package:jom_malaysia/widgets/my_rating.dart';
import 'package:jom_malaysia/widgets/sliver_appbar_delegate.dart';
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
              Icons.star_border,
              color:
                  _showTitle ? Colors.black : ThemeUtils.getIconColor(context),
            ),
            onPressed: () {},
          ),
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
              Gaps.vGap8,
              Gaps.line,
              Gaps.vGap8,
              _PlaceDescription(place),
              Gaps.vGap8,
              Gaps.line,
              Gaps.vGap8,
              // _OperatingHour(place.operatingHours),
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
    return Container(
        child: Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: operatingHours[0].openTime +
                  '-' +
                  operatingHours[0].closeTime),
          TextSpan(
              //Function to check time and decide open and close
              text: ' Open',
              style: TextStyle(color: Colors.green)),
        ],
      ),
    ));
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
