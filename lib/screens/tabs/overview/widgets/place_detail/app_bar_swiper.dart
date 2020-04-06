import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';

class AppBarWithSwiper extends StatefulWidget {
  const AppBarWithSwiper({
    Key key,
    @required this.context,
    @required this.place,
    @required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;
  final BuildContext context;
  final ListingModel place;

  @override
  _AppBarWithSwiperState createState() => _AppBarWithSwiperState();
}

class _AppBarWithSwiperState extends State<AppBarWithSwiper> {
  bool _showTitle = false;

  final kExpandedHeight = 250.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.scrollController..addListener(() => _isShowTitle());
    });
  }

  void _isShowTitle() {
    var change = (widget.scrollController.hasClients &&
        widget.scrollController.offset > kExpandedHeight - kToolbarHeight);
    //reduce rebuild
    if (change != _showTitle) setState(() => _showTitle = change);
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
          icon: const Icon(Icons.arrow_back_ios),
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
      floating: false,
      // 不随着滑动隐藏标题
      pinned: true,
      // 固定在顶部

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

class _CoverPhotos extends StatelessWidget {
  _CoverPhotos(this.place);

  final ListingModel place;

  @override
  Widget build(BuildContext context) {
    List<String> swiper = place.listingImages?.getCarousel;

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

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Report Mistake', icon: Icons.feedback),
];
