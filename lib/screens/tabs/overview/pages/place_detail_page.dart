// TODO kean phang design here

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:jom_malaysia/core/mvp/base_page_state.dart';
import 'package:jom_malaysia/core/res/colors.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/presenter/place_detail_page_presenter.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/place_detail_provider.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
import 'package:provider/provider.dart';

import '../../../../util/theme_utils.dart';
import '../../nearby/provider/nearby_page_provider.dart';

class PlaceDetailPage extends StatefulWidget {
  const PlaceDetailPage(this.placeId);

  final String placeId;
  @override
  PlaceDetailPageState createState() => PlaceDetailPageState();
}

class PlaceDetailPageState
    extends BasePageState<PlaceDetailPage, PlaceDetailPagePresenter> {
  bool isDark = false;
  var _isloading = true;

  PlaceDetailProvider provider = PlaceDetailProvider();

  void setPlace(ListingModel place) {
    provider.setPlace(place);
  }

  @override
  void initState() {
    super.initState();
    provider.setStateTypeNotNotify(StateType.empty);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   presenter.fetchDetail(widget.placeId);
    // });
  }

  @override
  PlaceDetailPagePresenter createPresenter() {
    return PlaceDetailPagePresenter();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // isDark = ThemeUtils.isDark(context);
    print("detail page build");
    // final Color _iconColor = ThemeUtils.getIconColor(context);
    return ChangeNotifierProvider<PlaceDetailProvider>(
      create: (_) => provider,
      child: Consumer<PlaceDetailProvider>(
        builder: (_, detail, __) => Scaffold(
          body: _isloading
              ? Stack(
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          // Text(detail.place.listingId),
                          Expanded(
                              flex: 2, child: PlaceDetailsImages(detail.place)),
                          Expanded(flex: 4, child: PlaceDetail(detail.place)),
                        ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: ThemeUtils.isDark(context)
                              ? Colors.black54
                              : Colours.text,
                        ),
                        onPressed: () => Navigator.pop(context, false),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}

class PlaceDetail extends StatelessWidget {
  double top = 0.0;
  final ListingModel place;
  PlaceDetail(this.place);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    automaticallyImplyLeading: false,
                    expandedHeight: 250.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      top = constraints.biggest.height;
                      return FlexibleSpaceBar(
                          centerTitle: true,
                          title: AnimatedOpacity(
                              duration: Duration(milliseconds: 300),
                              opacity: 1.0,
                              child: top == 83.0
                                  ? Text(
                                      place.merchant.registrationName,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: ThemeUtils.isDark(context)
                                              ? Colours.dark_text
                                              : Colours.text),
                                    )
                                  : Text(
                                      top.toString(),
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.transparent),
                                    )),
                          background: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(20.0),
                                    topRight: const Radius.circular(20.0)),
                                border: Border.all(
                                    color: ThemeUtils.isDark(context)
                                        ? Colours.dark_text
                                        : Colours.text,
                                    width: 2.0)),
                            child: Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: PlaceInfo()),
                          ));
                    })),
              ];
            },
            body: GridView.count(
                crossAxisCount: 3,
                padding: EdgeInsets.all(2.0),
                children: List<Widget>.generate(15, (index) {
                  return GridTile(
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.network(
                        place.listingImages.listingLogo.url,
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  );
                }))));
  }
}

class PlaceDetailsImages extends StatelessWidget {
  final int _images = 3;
  final ListingModel place;
  PlaceDetailsImages(this.place);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: _images,
        itemBuilder: (context, index) {
          return Stack(children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(5),
              child: Image.network(
                place.listingImages.coverPhoto.url,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                top: 200,
                left: 260,
                child: FlatButton.icon(
                    color: Colors.white,
                    onPressed: null,
                    icon: Icon(Icons.photo_camera, color: Colors.white),
                    label: Text(
                      (index + 1).toString() + "/" + _images.toString(),
                      style: TextStyle(color: Colors.white),
                    )))
          ]);
        });
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
