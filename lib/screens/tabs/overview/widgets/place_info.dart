import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/enums/map_type.dart';
import 'package:jom_malaysia/core/models/coordinates_model.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/address_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/contact_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/contact_item.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
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
                  Text("1km"),
                  Icon(Icons.star)
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
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final ContactVM contact;
  final AddressVM address;
  _ContactCard({this.contact, this.address});

  @override
  _ContactCardState createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  @override
  Widget build(BuildContext context) {
    final phoneNo = widget.contact?.getContactNumber();
    return Column(
      children: <Widget>[
        ContactItem(
          icon: const LoadAssetImage("place/icon_address",
              width: 24.0, height: 24.0),
          label: widget.address.toString(),
          onTap: () => _showChooseMapDialog(widget.address.coordinates),
        ),
        if (phoneNo != null)
          ContactItem(
            icon: const LoadAssetImage("place/icon_phone",
                width: 24.0, height: 24.0),
            label: phoneNo,
            onTap: () => _showChooseContactDialog(widget.contact),
          ),
        if (widget?.contact?.email != null)
          ContactItem(
            icon: const LoadAssetImage("place/icon_phone",
                width: 24.0, height: 24.0),
            label: widget.contact.email,
            onTap: () => Utils.launchEmailURL(widget.contact.email),
          ),
        if (widget?.contact?.website != null)
          ContactItem(
            icon: Icon(Icons.link),
            label: widget.contact.email,
            onTap: () => Utils.launchWebURL(widget.contact.website),
          ),
      ],
    );
  }

  Future<void> _showChooseContactDialog(ContactVM contact) async {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Choose a contact method'),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (contact.mobileNumber != null &&
                      contact.mobileNumber.isNotEmpty)
                    SimpleDialogOption(
                      child: LoadAssetImage("place/icon_phone"),
                      onPressed: () {
                        Utils.launchTelURL(contact.mobileNumber);
                        NavigatorUtils.goBack(context);
                      },
                    ),
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
          );
        });
  }

  Future<void> _showChooseMapDialog(CoordinatesModel coordinates) async {
    switch (await showDialog<MapType>(
        context: context,
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
                      Navigator.pop(context, MapType.google);
                    },
                  ),
                  if (Platform.isIOS)
                    SimpleDialogOption(
                      child: LoadAssetImage("place/apple_maps"),
                      onPressed: () {
                        Navigator.pop(context, MapType.apple);
                      },
                    ),
                  SimpleDialogOption(
                    child: LoadAssetImage("place/waze"),
                    onPressed: () {
                      Navigator.pop(context, MapType.waze);
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
          );
        })) {
      case MapType.google:
        await Utils.launchMap(coordinates, MapType.google);

        break;
      case MapType.waze:
        await Utils.launchMap(coordinates, MapType.waze);
        break;
      case MapType.apple:
        Utils.launchMap(coordinates, MapType.apple);
        break;
    }
  }
}
