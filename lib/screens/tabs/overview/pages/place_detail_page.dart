import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jom_malaysia/core/models/image_model.dart';
import 'package:jom_malaysia/core/res/colors.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/description_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/operating_hours_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/listing_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/comment_section.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/merchant_info.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/operating_hours_dialog.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_info.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:jom_malaysia/widgets/my_section_divider.dart';
import 'package:jom_malaysia/widgets/sliver_appbar_delegate.dart';
import 'package:provider/provider.dart';

import '../../../../util/theme_utils.dart';

class PlaceDetailPage extends StatefulWidget {
  const PlaceDetailPage({@required this.placeId});

  final String placeId;
  @override
  PlaceDetailPageState createState() => PlaceDetailPageState();
}

const kExpandedHeight = 250.0;

class PlaceDetailPageState extends State<PlaceDetailPage> {
  bool isDark = false;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});

    _scrollController = ScrollController()..addListener(() => setState(() {}));
  }

  bool get _showTitle {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    isDark = ThemeUtils.isDark(context);
    final place = Provider.of<ListingProvider>(context, listen: false)
        .findById(widget.placeId);

    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          controller: _scrollController,
          key: const Key('place_detail'),
          slivers: _sliverBuilder(place),
        ),
      ),
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
              if (place.description != null)
                _PlaceDescription(place.description),
            ],
          ),
        ),
      ),
      SliverPersistentHeader(
        delegate: MySliverAppBarDelegate(
          Center(
            child: MySectionDivider(S.of(context).placeDetailInfoLabel),
          ),
          50,
        ),
      ),
      SliverToBoxAdapter(
        child: Gaps.vGap16,
      ),
      _PlaceImage(
        images: place.listingImages.ads,
      ),
      MerchantInfo(merchant: place.merchant),
      CommentSection(place.listingId),
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
          return LoadImage(
            images[index].url,
            fit: BoxFit.fill,
          );
        },
        childCount: images.length,
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
      backgroundColor: Colors.grey.shade200,
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
              background: _CoverPhotos(place),
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

class _PlaceDescription extends StatelessWidget {
  final DescriptionVM description;
  _PlaceDescription(this.description);

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context, listen: false).locale;
    return MyCard(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Flexible(
              child: Text(
                description
                    ?.getDescription(lang ?? Localizations.localeOf(context)),
                style: Theme.of(context).textTheme.body1,
              ),
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
    final _today = (DateTime.now().weekday == 7) ? 0 : DateTime.now().weekday;
    final _oh = operatingHours.firstWhere((x) => x.dayOfWeek.index == _today,
        orElse: () => null);
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
                                  S.of(context).placeDetailOperatingCloseLabel,
                                  style: TextStyle(
                                    color: Theme.of(context).errorColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              : !_oh.closingSoon
                                  ? Text(
                                      S
                                          .of(context)
                                          .placeDetailOperatingOpenLabel,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    )
                                  : Text(
                                      S
                                          .of(context)
                                          .placeDetailOperatingSoonLabel,
                                      style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    )
                        ])
                      : Row(
                          children: <Widget>[
                            Text(
                              S.of(context).placeDetailOperatingCloseLabel,
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
  _CoverPhotos(this.place);
  final ListingModel place;
  @override
  Widget build(BuildContext context) {
    List<String> swiper = place.listingImages.getCarousel;

    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          fit: StackFit.expand,
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            LoadImage(
              swiper[index] ?? "none",
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
  }
}
