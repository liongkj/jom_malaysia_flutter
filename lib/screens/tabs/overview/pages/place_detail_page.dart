import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jom_malaysia/core/mvp/base_page_state.dart';
import 'package:jom_malaysia/core/res/colors.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/overview_page.dart';
import 'package:jom_malaysia/screens/tabs/overview/presenter/place_detail_page_presenter.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/place_detail_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/image_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:jom_malaysia/widgets/my_flexible_space_bar.dart';
import 'package:jom_malaysia/widgets/my_rating.dart';
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
  var _isloading = false;

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
                slivers: _sliverBuilder(place),
              ),
            ),
          );
        }));
  }

  List<Widget> _sliverBuilder(ListingModel place) {
    final List<String> images = [place.listingImages.coverPhoto.url];
    images.addAll(place.listingImages.ads.map((x) => x.url).toList());
    return <Widget>[
      SliverAppBar(
        // brightness: Brightness.dark,
        backgroundColor: ThemeUtils.getBackgroundColor(context),
        titleSpacing: 0.0,
        leading: Icon(
          Icons.arrow_back_ios,
          color: _showTitle ? Colors.black : ThemeUtils.getIconColor(context),
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
                background: _CoverPhotos(images),
                centerTitle: true,
              ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color:
                  _showTitle ? Colors.black : ThemeUtils.getIconColor(context),
            ),
            onPressed: () {},
          )
        ],
      ),
      SliverPersistentHeader(
        delegate: SliverAppBarDelegate(
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: MyCard(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: LoadImage(
                          place.listingImages.coverPhoto.url,
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Gaps.hGap10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              place.listingName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Gaps.vGap8,
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Rating(rating: 4),
                                ),
                                Text(
                                  place.tags[0],
                                  style: TextStyle(
                                      fontSize: Dimens.font_sp12,
                                      color: Theme.of(context).errorColor),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            120),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _PlaceInfo(place),
              _PlaceInfo(place),
              _PlaceInfo(place),
              _PlaceInfo(place),
              _PlaceInfo(place),
              _PlaceInfo(place),
              _PlaceInfo(place),
              _PlaceInfo(place),
              _PlaceInfo(place),
            ],
          ),
        ),
      ),
    ];
  }
}

class _CoverPhotos extends StatelessWidget {
  _CoverPhotos(this.swiperImage);
  final List<String> swiperImage;

  @override
  Widget build(BuildContext context) {
    final int count = swiperImage.length;
    //  ListView.separated(
    //   scrollDirection: Axis.horizontal,
    //   separatorBuilder: (BuildContext context, int index) => Divider(),
    //   itemCount: count,
    //   itemBuilder: (context, index) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          swiperImage[index],
          fit: BoxFit.cover,
        );
      },
      itemCount: count,
      loop: false,
    );
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

class PlaceInfo extends StatelessWidget {
  PlaceInfo(this.place);
  final ListingModel place;
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 8,
              child: Text(
                place.merchant.registrationName,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              )),
          Expanded(
              flex: 2,
              //Is favorite?
              child: Icon(
                Icons.star_border,
                size: 30,
              ))
        ],
      ),
      SizedBox(height: 10),
      Row(children: <Widget>[
        Expanded(
          flex: 2,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('5', textAlign: TextAlign.right),
                Icon(Icons.star)
              ]),
        ),
        Expanded(
            flex: 9,
            child: Wrap(runSpacing: 5, children: <Widget>[
              Text(place.category.category + ' ' + place.category.subcategory,
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              Text(place.tags[0],
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold))
            ]))
      ]),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        FlatButton.icon(
            onPressed: () => print('Location'),
            icon: Icon(Icons.location_on),
            label: Flexible(
                child: Text(place.address.add1 +
                    place.address.add2 +
                    place.address.city +
                    place.address.postalCode))),
        FlatButton.icon(
            onPressed: () => print('Calling'),
            icon: Icon(Icons.phone),
            label: Text('+60 18-762 7267')),
        FlatButton.icon(
            onPressed: () => print('Operating Hours'),
            icon: Icon(Icons.timer),
            label: Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: place.operatingHours[0].openTime +
                          '-' +
                          place.operatingHours[0].closeTime),
                  TextSpan(
                      //Function to check time and decide open and close
                      text: ' Open',
                      style: TextStyle(color: Colors.green)),
                ],
              ),
            )),
        FlatButton.icon(
            onPressed: () => print('Visit'),
            icon: Icon(Icons.link),
            label: Flexible(child: Text('www.cornhab.com')))
      ])
    ]);
  }
}
