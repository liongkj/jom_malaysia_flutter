import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/enums/map_type.dart';
import 'package:jom_malaysia/core/models/coordinates_model.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/location/location_utils.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/address_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/contact_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/contact_item.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/setting/provider/user_current_location_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:provider/provider.dart';

class PlaceInfo extends StatelessWidget {
  PlaceInfo(this.place);
  final ListingModel place;
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context, listen: false).locale;
    return MyCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    place?.listingName,
                    maxLines: 3,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                if (Constant.enableFavourite)
                  IconButton(
                    icon: Icon(Icons.star_border, size: 30),
                    onPressed: () {},
                  )
              ],
            ),
            Gaps.vGap16,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Chip(
                  label: Text(
                      place.category
                          .getCategory(lang ?? Localizations.localeOf(context)),
                      style: Theme.of(context).textTheme.body1),
                ),
                Gaps.hGap15,
                Chip(
                  label: Text(
                      place.category.getSubcategory(
                          lang ?? Localizations.localeOf(context)),
                      style: Theme.of(context).textTheme.body1),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Consumer<UserCurrentLocationProvider>(
                    builder: (_, location, __) {
                      return FutureBuilder<String>(
                          future: LocationUtils.getDistanceBetween(
                              location.currentCoordinate,
                              place,
                              Provider.of<LocationProvider>(context,
                                      listen: false)
                                  .selected),
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? Text(
                                    snapshot.data,
                                    style: Theme.of(context).textTheme.subtitle,
                                  )
                                : CircularProgressIndicator();
                          });
                    },
                  ),
                ),
              ],
            ),
            Gaps.vGap16,
            _TagItem(
              isFeatured: place.isFeatured,
              tags: place.tags,
            ),
            Gaps.vGap16,
            _ContactCard(
              address: place.address,
              contact: place.officialContact,
            ),
          ],
        ),
      ),
    );
  }
}

class _TagItem extends StatelessWidget {
  const _TagItem({
    Key key,
    @required this.tags,
    @required this.isFeatured,
  }) : super(key: key);

  final List<String> tags;
  final bool isFeatured;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          if (isFeatured)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(2.0),
              ),
              height: 20.0,
              alignment: Alignment.center,
              child: Text(
                S.of(context).labelTagMustTry,
                style: TextStyle(
                    color: Colors.black54, fontSize: Dimens.font_sp14),
              ),
            ),
          if (isFeatured) Gaps.hGap8,
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              itemCount: tags.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  margin: const EdgeInsets.only(right: 4.0),
                  decoration: BoxDecoration(
                    color: index % 2 == 0
                        ? Theme.of(context).errorColor
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  height: 16.0,
                  alignment: Alignment.center,
                  child: Text(
                    tags[index],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimens.font_sp14,
                        fontWeight: FontWeight.w600),
                  ),
                );
              },
            ),
          ),
        ],
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
      mainAxisAlignment: MainAxisAlignment.start,
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
            icon: const LoadAssetImage("place/icon_email",
                width: 24.0, height: 24.0),
            label: widget.contact.email,
            onTap: () => Utils.launchEmailURL(widget.contact.email),
          ),
        if (widget?.contact?.website != null)
          ContactItem(
              icon: Icon(Icons.link),
              label: widget.contact.website,
              onTap: () => NavigatorUtils.goWebViewPage(
                  context, "Official Web", widget.contact.website)),
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
                      child: GestureDetector(
                        onTap: () {
                          Utils.launchTelURL(contact.mobileNumber);
                          NavigatorUtils.goBack(context);
                        },
                        child: LoadAssetImage(
                          "place/icon_call",
                          height: 50,
                        ),
                      ),
                    ),
                  SimpleDialogOption(
                    child: GestureDetector(
                      onTap: () {
                        Utils.launchWhatsAppURL(contact.mobileNumber);
                        NavigatorUtils.goBack(context);
                      },
                      child: LoadAssetImage(
                        "place/icon_whatsapp",
                      ),
                    ),
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
                    child: LoadAssetImage(
                      "place/google_maps",
                      height: 40,
                    ),
                    onPressed: () {
                      Navigator.pop(context, MapType.google);
                    },
                  ),
                  if (Platform.isIOS)
                    SimpleDialogOption(
                      child: LoadAssetImage(
                        "place/apple_maps",
                        height: 50,
                      ),
                      onPressed: () {
                        Navigator.pop(context, MapType.apple);
                      },
                    ),
                  SimpleDialogOption(
                    child: LoadAssetImage(
                      "place/waze",
                      height: 50,
                    ),
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
