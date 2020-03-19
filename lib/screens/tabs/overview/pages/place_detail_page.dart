import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/listing_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/comments/comment_section.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/fab_scroll_scaffold.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_detail/app_bar_swiper.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_detail/merchant_info.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_detail/place_description.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_detail/place_image.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_detail/place_info.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_detail/place_operating_hour.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
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

class PlaceDetailPageState extends State<PlaceDetailPage>
    with AutomaticKeepAliveClientMixin {
  bool isDark = false;
  bool _isVisible;
  var place;
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = new ScrollController();
    //   ..addListener(() {
    //     if (_scrollController.position.pixels >
    //         _scrollController.position.maxScrollExtent * 0.9) {
    //       if (_isVisible == true) {
    //         setState(() {
    //           _isVisible = false;
    //         });
    //       }
    //     } else {
    //       if (_isVisible == false) {
    //         setState(() {
    //           _isVisible = true;
    //         });
    //       }
    //     }
    //   });
    // _isVisible = true;

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
    return HideFabOnScrollScaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          key: const Key('place_detail'),
          slivers: _sliverBuilder(place),
        ),
      ),
      controller: _scrollController,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "btn_open_form",
        tooltip: "Rate",
        onPressed: () => NavigatorUtils.push(context,
            '${OverviewRouter.reviewPage}?title=${place.listingName}&placeId=${place.listingId}&userId=${"123"}'),
        icon: Icon(Icons.star),
        label: Text("Rate"),
      ),
    );
  }

  List<Widget> _sliverBuilder(ListingModel place) {
    return <Widget>[
      AppBarWithSwiper(
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
      PlaceImage(
        images: place.listingImages.ads,
      ),
      SliverToBoxAdapter(
        child: CommentSection(
          listingName: place.listingName,
          listingId: place.listingId,
        ),
      ),
      MerchantInfo(merchant: place.merchant),
    ];
  }

  @override
  bool get wantKeepAlive => true;
}
