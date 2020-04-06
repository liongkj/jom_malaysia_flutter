import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/listing_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/comments/comment_section.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/overview/fab_scroll_scaffold.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_detail/app_bar_swiper.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_detail/merchant_info.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_detail/place_description.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_detail/place_image.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_detail/place_info.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_detail/place_operating_hour.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/my_section_divider.dart';
import 'package:jom_malaysia/widgets/sliver_appbar_delegate.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
import 'package:provider/provider.dart';

class PlaceDetailPage extends StatefulWidget {
  const PlaceDetailPage({@required this.placeId});

  final String placeId;

  @override
  PlaceDetailPageState createState() => PlaceDetailPageState();
}

class PlaceDetailPageState extends State<PlaceDetailPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController;
  Future<ListingModel> fetchListing;

  @override
  void initState() {
    _scrollController = new ScrollController();
    fetchListing = Provider.of<ListingProvider>(context, listen: false)
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
    return FutureBuilder<ListingModel>(
        future: fetchListing,
        builder: (ctx, snap) {
          if (snap.hasData) {
            return HideFabOnScrollScaffold(
              body: SafeArea(
                child: CustomScrollView(
                  controller: _scrollController,
                  key: const Key('place_detail'),
                  slivers: _sliverBuilder(snap.data),
                ),
              ),
              floatingActionButton: Builder(
                builder: (ctx) => FloatingActionButton.extended(
                  key: Key("FAB"),
                  heroTag: "btn_open_form",
                  tooltip: S.of(context).labelRatePlace,
                  onPressed: () => _addNewReview(snap.data),
                  icon: const Icon(Icons.star),
                  label: Text(S.of(context).labelRatePlace),
                ),
              ),
            );
          } else if (snap.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: StateLayout(
                type: StateType.loading,
              ),
            );
          }
          return Scaffold(
            body: StateLayout(
              type: Provider.of<ListingProvider>(context, listen: false)
                  .stateType,
            ),
          );
        });
  }

  _addNewReview(ListingModel place) {
    NavigatorUtils.tryAuthResult(
      context,
      '${OverviewRouter.reviewPage}?title=${place.listingName}&placeId=${place.listingId}',
      (result) => Scaffold.of(context).showSnackBar(result),
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
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 8.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

      // allow lazy building of comment section
      SliverList(
          delegate: SliverChildListDelegate([
        Gaps.vGap16,
        PlaceImage(
          images: place.listingImages?.ads,
        ),
        CommentSection(
          listingName: place.listingName,
          listingId: place.listingId,
          addNewReview: () => _addNewReview(place),
        ),
        MerchantInfo(merchant: place.merchant),
      ]))
    ];
  }

  @override
  bool get wantKeepAlive => true;
}
