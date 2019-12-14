// TODO kean phang design here

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

  var _isloading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    isLoaded();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void isLoaded() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        _isloading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          Expanded(flex: 4, child: PlaceDetails()),
                        ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
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

class PlaceDetails extends StatelessWidget {
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
                                          fontSize: 20.0, color: Colors.black),
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
                                    color: Colors.black, width: 2.0)),
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
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
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
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              Text('This is some short descriptions',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold))
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
