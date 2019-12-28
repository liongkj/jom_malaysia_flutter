import 'dart:html';

import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/address_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/contact_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
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
                  Text("Rating"),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("tags"),
                ],
              ),
              Text("Official Contacts"),
              Text("Address"),
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

class _contactCard extends StatelessWidget {
  final ContactVM contactVM;
  final AddressVM address;
  _contactCard({this.contactVM, this.address});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FlatButton.icon(
              onPressed: () => print('Location'),
              icon: Icon(Icons.location_on),
              label: Flexible(
                  child: Text(address.add1 +
                      address.add2 +
                      address.city +
                      address.postalCode))),
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
}
