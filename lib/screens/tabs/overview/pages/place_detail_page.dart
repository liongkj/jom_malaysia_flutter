import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jom_malaysia/core/models/image_model.dart';
import 'package:jom_malaysia/core/mvp/base_page_state.dart';
import 'package:jom_malaysia/core/res/colors.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/operating_hours_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/presenter/place_detail_page_presenter.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/place_detail_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/operating_hours_dialog.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_info.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:jom_malaysia/widgets/my_section_divider.dart';
import 'package:jom_malaysia/widgets/sliver_appbar_delegate.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
import 'package:provider/provider.dart';

import '../../../../util/theme_utils.dart';

class PlaceDetailPage extends StatefulWidget {
  const PlaceDetailPage({@required this.placeId});

  final String placeId;
  @override
  PlaceDetailPageState createState() => PlaceDetailPageState();
}

const kExpandedHeight = 250.0;

class PlaceDetailPageState
    extends BasePageState<PlaceDetailPage, PlaceDetailPagePresenter> {
  bool isDark = false;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // provider.setStateTypeNotNotify(StateType.empty);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // presenter.fetchDetail(widget.placeId);
    });

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
    print("place detail page ");
    final place =
        Provider.of<PlaceDetailProvider>(context, listen: false).place;

    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        controller: _scrollController,
        key: const Key('place_detail'),
        // physics: ClampingScrollPhysics(),
        slivers: _sliverBuilder(place),
      )),
    );
  }

  List<Widget> _sliverBuilder(ListingModel place) {
    return <Widget>[
      _AppBarWithSwiper(
        showTitle: _showTitle,
        context: context,
        place: place,
      ),
      SliverToBoxAdapter(
        child: Gaps.vGap8,
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PlaceInfo(place),
              Gaps.vGap16,
              _OperatingHour(place.operatingHours),
              Gaps.vGap16,
              if (place.description != null) _PlaceDescription(place),
            ],
          ),
        ),
      ),
      SliverPersistentHeader(
        delegate: MySliverAppBarDelegate(
          Center(child: MySectionDivider("Detail")),
          50,
        ),
      ),
      SliverToBoxAdapter(
        child: Gaps.vGap16,
      ),
      if (place.listingImages.ads != null && place.listingImages.ads.length > 0)
        _PlaceImage(
          images: place.listingImages.ads,
        ),
      _MerchantInfo(merchant: place.merchant),
    ];
  }
}

class _PlaceImage extends StatelessWidget {
  final List<ImageModel> images;
  const _PlaceImage({
    Key key,
    this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return LoadImage(images[index].url);
        },
      ),
    );
  }
}

class _AppBarWithSwiper extends StatelessWidget {
  const _AppBarWithSwiper({
    Key key,
    @required bool showTitle,
    @required this.context,
    @required this.place,
  })  : _showTitle = showTitle,
        super(key: key);

  final bool _showTitle;
  final BuildContext context;
  final ListingModel place;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      brightness: Brightness.dark,
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleSpacing: 0.0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: _showTitle ? Colours.text : ThemeUtils.getIconColor(context),
        onPressed: () => NavigatorUtils.goBack(context),
      ),
      centerTitle: true,
      title: _showTitle
          ? Text(
              '${place.listingName}',
              style: Theme.of(context).textTheme.subtitle,
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
            color: _showTitle ? Colors.black : ThemeUtils.getIconColor(context),
          ),
          onPressed: () {},
        )
      ],
    );
  }
}

class _MerchantInfo extends StatelessWidget {
  const _MerchantInfo({
    Key key,
    @required this.merchant,
  }) : super(key: key);

  final MerchantVM merchant;

  @override
  Widget build(BuildContext context) {
    final TextStyle textTextStyle =
        Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: MyCard(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Merchant Info",
                  style: textTextStyle,
                ),
                Gaps.vGap12,
                _MerchantInfoItem(
                  title: "Registration Name",
                  data: merchant.registrationName,
                ),
                Gaps.vGap12,
                _MerchantInfoItem(
                  title: "SSM ID",
                  data: merchant.ssmId,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MerchantInfoItem extends StatelessWidget {
  const _MerchantInfoItem({
    @required this.title,
    this.data,
    Key key,
  }) : super(key: key);
  final String title;
  final String data;
  @override
  Widget build(BuildContext context) {
    final TextStyle textTextStyle =
        Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
    return Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: textTextStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Gaps.vGap12,
        Expanded(
          flex: 5,
          child: Text(
            data,
            style: Theme.of(context).textTheme.subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}

class _PlaceDescription extends StatelessWidget {
  final ListingModel place;
  _PlaceDescription(this.place);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Text(
              place.description.getDescription(),
              style: Theme.of(context).textTheme.body1,
            ),
          ],
        ),
      ),
    );
  }
}

class _OperatingHour extends StatelessWidget {
  final List<OperatingHours> operatingHours;

  _OperatingHour(this.operatingHours);
  @override
  Widget build(BuildContext context) {
    //weekday returns 1-7
    final _today = DateTime.now().weekday;
    final _oh = operatingHours[_today == 7 ? 0 : _today];
    return Material(
      child: InkWell(
        onTap: () => {},
        child: MyCard(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const LoadAssetImage("place/icon_wait",
                    width: 18.0, height: 18.0),
                Gaps.hGap12,
                Expanded(
                  flex: 6,
                  child: _oh != null
                      ? Row(children: <Widget>[
                          Text('${_oh.openHour} - ${_oh.closeHour}'),
                          Gaps.hGap15,
                          !_oh.isOpen
                              ? Text(
                                  'CLOSED',
                                  style: TextStyle(
                                    color: Theme.of(context).errorColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              : _oh.closingSoon
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
                                    )
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
                  child: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      size: 24,
                      color: ThemeUtils.getIconColor(context),
                    ),
                    onPressed: () {
                      showElasticDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return OperatingHoursDialog(
                              hours: operatingHours,
                            );
                          });
                    },
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
    return Consumer<PlaceDetailProvider>(builder: (_, provider, child) {
      List<String> swiper = provider.place.listingImages.getCarousel;
      return Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            fit: StackFit.expand,
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              LoadImage(
                provider.stateType == StateType.loading
                    ? (swiper[index])
                    : "none",
                fit: BoxFit.fill,
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: FlatButton.icon(
                  color: Colors.white,
                  onPressed: null,
                  icon: Icon(Icons.photo_camera, color: Colors.white),
                  label: Text(
                    (index + 1).toString() + "/" + swiper.length.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          );
        },
        itemCount: swiper.length,
        loop: false,
      );
    });
  }
}
