import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/models/coordinates_model.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/address_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/contact_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/util/utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_card.dart';

class PlaceInfo extends StatelessWidget {
  PlaceInfo(this.place);
  final ListingModel place;
  @override
  Widget build(BuildContext context) {
    final TextStyle textTextStyle =
        Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: MyCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: Text(
                      place.listingName,
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ),
                  Text("1km")
                ],
              ),
              Row(
                children: <Widget>[
                  Text("tags"),
                ],
              ),
              _ContactCard(
                address: place.address,
                contact: place.officialContact,
              ),
              Text("Operating hours")
            ],
          ),
        ),
        // SizedBox(height: 10),
        // Row(children: <Widget>[
        //   Expanded(
        //     flex: 2,
        //     child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: <Widget>[
        //           Text('5', textAlign: TextAlign.right),
        //           Icon(Icons.star)
        //         ]),
        //   ),
        //   Expanded(
        //       flex: 9,
        //       child: Wrap(runSpacing: 5, children: <Widget>[
        //         Text(place.category.category + ' ' + place.category.subcategory,
        //             style:
        //                 TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        //         Text(place.tags[0],
        //             style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold))
        //       ]))
        // ]),
        //
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final ContactVM contact;
  final AddressVM address;
  _ContactCard({this.contact, this.address});

  @override
  __ContactCardState createState() => __ContactCardState();
}

class __ContactCardState extends State<_ContactCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const LoadAssetImage("order/icon_address",
                      width: 24.0, height: 24.0),
                  Gaps.hGap12,
                  Expanded(
                    child: Text(
                      widget.address.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        _showChooseMapDialog(widget.address.coordinates),
                    child: Icon(
                      Icons.navigate_next,
                      color: ThemeUtils.getIconColor(context),
                    ),
                  ),
                ]),
          ),
          FlatButton.icon(
              onPressed: () => print('Calling'),
              icon: Icon(Icons.phone),
              label: Text('+60 18-762 7267')),
          FlatButton.icon(
              onPressed: () => print('Visit'),
              icon: Icon(Icons.link),
              label: Flexible(child: Text('www.cornhab.com')))
        ]);
  }

  void _showChooseMapDialog(CoordinatesModel coordinates) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Choose a map'),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SimpleDialogOption(
                    child: LoadAssetImage("place/google_maps"),
                    onPressed: () {
                      Utils.launchMap(coordinates, "google");
                      NavigatorUtils.goBack(context);
                    },
                  ),
                  if (Platform.isIOS)
                    SimpleDialogOption(
                      child: LoadAssetImage("place/apple_maps"),
                      onPressed: () {
                        Utils.launchMap(coordinates, "apple");
                        NavigatorUtils.goBack(context);
                      },
                    ),
                  SimpleDialogOption(
                    child: LoadAssetImage("place/waze"),
                    onPressed: () {
                      Utils.launchMap(coordinates, "waze");
                      NavigatorUtils.goBack(context);
                    },
                  )
                ],
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    onPressed: () => NavigatorUtils.goBack(context),
                    child: const Text('CANCEL'),
                  ),
                ],
              )
            ],
            // content: const Text("Which app to use for navigation?"),
            // actions: <Widget>[
            //   IconButton(
            //     icon: Icon(Icons.navigation),
            //     onPressed: () => NavigatorUtils.goBack(context),
            //   ),
            //   FlatButton(
            //     onPressed: () {
            //       Utils.launchMap(coordinates);
            //       NavigatorUtils.goBack(context);
            //     },
            //     textColor: Theme.of(context).errorColor,
            //     child: const Text('拨打'),
            //   ),
            // ],
          );
        });
  }
}
