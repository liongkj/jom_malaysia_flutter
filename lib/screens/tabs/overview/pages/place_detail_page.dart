import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/models/image_model.dart';
import 'package:jom_malaysia/core/res/colors.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/gateway/api_const.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/listing_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/comments/comment_section.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/merchant_info.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_description.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_info.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_operating_hour.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
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

class PlaceDetailPageState extends State<PlaceDetailPage>
    with AutomaticKeepAliveClientMixin {
  bool isDark = false;
  bool _isVisible;
  var place;
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = new ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels >
            _scrollController.position.maxScrollExtent * 0.9) {
          if (_isVisible == true) {
            setState(() {
              _isVisible = false;
            });
          }
        } else {
          if (_isVisible == false) {
            setState(() {
              _isVisible = true;
            });
          }
        }
      });
    _isVisible = true;

    place = Provider.of<ListingProvider>(context, listen: false)
        .findById(widget.placeId);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    isDark = ThemeUtils.isDark(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          key: const Key('place_detail'),
          slivers: _sliverBuilder(place),
        ),
      ),
      floatingActionButton: Visibility(
        visible: _isVisible,
        child: FloatingActionButton.extended(
          heroTag: "btn_open_form",
          tooltip: "Rate",
          onPressed: () => NavigatorUtils.push(context,
              '${OverviewRouter.reviewPage}?title=${place.listingName}&placeId=${place.listingId}&userId=${"123"}'),
          icon: Icon(Icons.star),
          label: Text("Rate"),
        ),
      ),
    );
  }

  List<Widget> _sliverBuilder(ListingModel place) {
    return <Widget>[
      _AppBarWithSwiper(
        scrollController: _scrollController,
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
              OperatingHour(place.operatingHours),
              Gaps.vGap16,
              if (place.description != null)
                PlaceDescription(place.description),
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
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyCard(
            child: CommentSection(
              listingName: place.listingName,
              listingId: place.listingId,
            ),
          ),
        ),
      ),
      MerchantInfo(merchant: place.merchant),
    ];
  }

  @override
  bool get wantKeepAlive => true;
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

class _AppBarWithSwiper extends StatefulWidget {
  const _AppBarWithSwiper({
    Key key,
    @required this.context,
    @required this.place,
    @required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;
  final BuildContext context;
  final ListingModel place;

  @override
  __AppBarWithSwiperState createState() => __AppBarWithSwiperState();
}

class __AppBarWithSwiperState extends State<_AppBarWithSwiper> {
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.scrollController..addListener(() => _isShowTitle());
    });
  }

  void _isShowTitle() {
    setState(() => {
          _showTitle = (widget.scrollController.hasClients &&
              widget.scrollController.offset > kExpandedHeight - kToolbarHeight)
        });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      brightness: Brightness.dark,
      backgroundColor: Colors.grey.shade200,
      elevation: 0.0,
      titleSpacing: 0.0,
      leading: Card(
        color: Colors.transparent,
        elevation: _showTitle ? 0 : 1,
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: _showTitle ? Colours.text : ThemeUtils.getIconColor(context),
          onPressed: () => NavigatorUtils.goBack(context),
        ),
      ),
      centerTitle: true,
      title: _showTitle
          ? Text(
              '${widget.place.listingName}',
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(color: Colors.black54),
            )
          : null,
      expandedHeight: kExpandedHeight,
      floating: false, // 不随着滑动隐藏标题
      pinned: true, // 固定在顶部

      actions: <Widget>[
        if (Constant.enableFeedback)
          Card(
            color: Colors.transparent,
            child: PopupMenuButton<Choice>(
              onSelected: (result) {
                if (result == choices[0]) {
                  NavigatorUtils.goWebViewPage(
                      context,
                      widget.place.listingName,
                      "${WebUrl.reportPlaceError}/${widget.place.listingId}");
                }
              },
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList();
              },
            ),
          ),
      ],
      flexibleSpace: _showTitle
          ? null
          : FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
              collapseMode: CollapseMode.pin,
              background: _CoverPhotos(widget.place),
              centerTitle: true,
            ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Report Mistake', icon: Icons.feedback),
];

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
            Hero(
              tag: place.listingId,
              child: LoadImage(
                swiper[index] ?? "none",
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Card(
                color: Colors.transparent,
                child: FlatButton.icon(
                  color: Colors.white,
                  onPressed: null,
                  icon: Icon(Icons.photo_camera, color: Colors.white),
                  label: Text(
                    (index + 1).toString() + "/" + swiper.length.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
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
