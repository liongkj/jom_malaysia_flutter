// TODO kean phang design here

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:jom_malaysia/core/res/colors.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/place_detail_model.dart';
import 'package:provider/provider.dart';

import '../../../../util/theme_utils.dart';
import '../../nearby/provider/nearby_page_provider.dart';

class PlaceDetailPage extends StatefulWidget {
  @override
  _PlaceDetailPageState createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  NearbyPageProvider provider = NearbyPageProvider();

  bool isDark = false;
  var _isloading = false;
  var data;
  var informations;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    //Portrait Mode only
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    isLoaded();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void isLoaded() {
    data = [
      {
        "listingId": "5df090ab8430e205883f71db",
        "merchant": {
          "merchantId": "5df08adc8430e205883f71d8",
          "ssmId": "200301020432",
          "registrationName": "LUCKY PALACE RESTAURANT SDN. BHD."
        },
        "listingName": "Lucky Palace Restaurant Seremban 2",
        "description":
            "Lucky Palace Restaurant Sdn. Bhd. is an enterprise located in Malaysia, with the main office in Sere",
        "address": {
          "add1": "1324 Jalan S2 A36",
          "add2": "Central Park",
          "city": "Seremban",
          "state": "NSN",
          "postalCode": "70300",
          "country": "MY",
          "coordinates": {"longitude": 101.9108675, "latitude": 2.6983694}
        },
        "operatingHours": [
          {"dayOfWeek": 0, "openTime": "08:00:00", "closeTime": "22:30:00"},
          {"dayOfWeek": 1, "openTime": "08:00:00", "closeTime": "22:30:00"},
          {"dayOfWeek": 2, "openTime": "08:00:00", "closeTime": "22:30:00"},
          {"dayOfWeek": 3, "openTime": "08:00:00", "closeTime": "22:30:00"},
          {"dayOfWeek": 4, "openTime": "08:00:00", "closeTime": "22:30:00"},
          {"dayOfWeek": 5, "openTime": "08:00:00", "closeTime": "22:30:00"},
          {"dayOfWeek": 6, "openTime": "08:00:00", "closeTime": "22:30:00"}
        ],
        "category": {
          "category": "restaurant",
          "subcategory": "chinese",
          "categoryId": "5df08e508430e205883f71da"
        },
        "categoryType": 2,
        "tags": ["chinese", "cuisine", "wedding", "hall"],
        "listingImages": {
          "listingLogo": {
            "url":
                "https://res.cloudinary.com/jomn9-com/image/upload/c_scale,w_200/v1575257964/placeholder_xtcpy8.jpg"
          },
          "coverPhoto": {
            "url":
                "https://res.cloudinary.com/jomn9-com/image/upload/v1576046575/listing_images/yrpqfqh2fznoofx65obq.webp"
          },
          "ads": []
        },
        "publishStatus": {
          "status": "pending",
          "validityStart": "0001-01-01T00:00:00Z",
          "validityEnd": "0001-01-01T00:00:00Z"
        },
        "createdAt": "2019-12-11T06:46:03.777+00:00",
        "modifiedAt": "0001-01-01T00:00:00+00:00"
      }
    ];

    informations = PlaceDetails.fromJson(data[0]);
    print(informations);
    Future.delayed(const Duration(milliseconds: 5000), () {
      setState(() {
        _isloading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    isDark = ThemeUtils.isDark(context);
    super.build(context);
    final Color _iconColor = ThemeUtils.getIconColor(context);
    return ChangeNotifierProvider<NearbyPageProvider>(
        create: (_) => provider,
        child: Scaffold(
          body: _isloading
              ? Stack(
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(flex: 2, child: PlaceDetailsImages()),
                          Expanded(flex: 4, child: PlaceDetail()),
                        ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: ThemeUtils.isDark(context)
                              ? Colours.dark_text
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
        ));
  }
}

class PlaceDetail extends StatelessWidget {
  var top = 0.0;
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
                                      "Hoop Station @ Cheras",
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
                        'https://picsum.photos/id/1060/5598/3732',
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
  int _images = 3;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: _images,
        itemBuilder: (context, index) {
          return Stack(children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 2),
              child: Image.network(
                'https://picsum.photos/id/1060/5598/3732',
                fit: BoxFit.fill,
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
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 8,
              child: Text(
                "Hoop Station @ Cheras",
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
              Text('This is some short descriptions',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              Text('This is some short descriptions',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold))
            ]))
      ]),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        FlatButton.icon(
            onPressed: () => print('Location'),
            icon: Icon(Icons.location_on),
            label: Flexible(
                child: Text('This is the full address lai de ahhhhhh'))),
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
                  TextSpan(text: '10AM - 9PM '),
                  TextSpan(
                      text: ' Open', style: TextStyle(color: Colors.green)),
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
