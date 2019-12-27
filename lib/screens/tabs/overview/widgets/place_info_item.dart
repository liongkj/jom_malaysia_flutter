import 'package:flutter/material.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/widgets/my_card.dart';

class PlaceInfo extends StatelessWidget {
  PlaceInfo(this.place);
  final ListingModel place;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: MyCard(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 8,
                  child: Text(
                    place.merchant.registrationName,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
        // Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        //   FlatButton.icon(
        //       onPressed: () => print('Location'),
        //       icon: Icon(Icons.location_on),
        //       label: Flexible(
        //           child: Text(place.address.add1 +
        //               place.address.add2 +
        //               place.address.city +
        //               place.address.postalCode))),
        //   FlatButton.icon(
        //       onPressed: () => print('Calling'),
        //       icon: Icon(Icons.phone),
        //       label: Text('+60 18-762 7267')),
        //   FlatButton.icon(
        //       onPressed: () => print('Operating Hours'),
        //       icon: Icon(Icons.timer),
        //       label: Text.rich(
        //         TextSpan(
        //           children: <TextSpan>[
        //             TextSpan(
        //                 text: place.operatingHours[0].openTime +
        //                     '-' +
        //                     place.operatingHours[0].closeTime),
        //             TextSpan(
        //                 //Function to check time and decide open and close
        //                 text: ' Open',
        //                 style: TextStyle(color: Colors.green)),
        //           ],
        //         ),
        //       )),
        //   FlatButton.icon(
        //       onPressed: () => print('Visit'),
        //       icon: Icon(Icons.link),
        //       label: Flexible(child: Text('www.cornhab.com')))
        // ]
      ),
    );
  }
}
