import 'package:flutter/material.dart';
import 'package:jom_malaysia/util/text_utils.dart';

class PlaceSearchResult {
  String objectId;
  Merchant merchant;
  String listingName;
  String photo;
  // Description description;
  Address address;
  Category category;
  String categoryType;
  List<String> tags;
  Geoloc geoloc;

  PlaceSearchResult(
      {this.merchant,
      this.listingName,
      this.photo,
      // this.description,
      this.address,
      this.category,
      this.categoryType,
      this.tags,
      this.geoloc});

  PlaceSearchResult.fromJson(String objectId, Map<String, dynamic> json) {
    this.objectId = objectId;
    merchant = json['merchant'] != null
        ? new Merchant.fromJson(json['merchant'])
        : null;
    listingName = json['listingName'];
    photo = json['photo'];
    // description = json['description'] != null
    //     ? new Description.fromJson(json['description'])
    //     : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    categoryType = json['categoryType'];
    tags = json['_tags'].cast<String>();
    geoloc =
        json['_geoloc'] != null ? new Geoloc.fromJson(json['_geoloc']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.merchant != null) {
      data['merchant'] = this.merchant.toJson();
    }
    data['listingName'] = this.listingName;
    data['photo'] = this.photo;
    // if (this.description != null) {
    //   data['description'] = this.description.toJson();
    // }
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['categoryType'] = this.categoryType;
    data['_tags'] = this.tags;
    if (this.geoloc != null) {
      data['_geoloc'] = this.geoloc.toJson();
    }
    return data;
  }
}

class Merchant {
  String ssmId;
  String registrationName;

  Merchant({this.ssmId, this.registrationName});

  Merchant.fromJson(Map<String, dynamic> json) {
    ssmId = json['ssmId'];
    registrationName = json['registrationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ssmId'] = this.ssmId;
    data['registrationName'] = this.registrationName;
    return data;
  }
}

class Description {
  List<String> en;
  List<String> zh;
  List<String> ms;

  Description({this.en, this.zh, this.ms});

  Description.fromJson(Map<String, dynamic> json) {
    en = json['en'].cast<String>();
    zh = json['zh'].cast<String>();
    ms = json['ms'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['zh'] = this.zh;
    data['ms'] = this.ms;
    return data;
  }
}

class Address {
  String add1;
  String add2;
  String city;

  Address({this.add1, this.add2, this.city});

  Address.fromJson(Map<String, dynamic> json) {
    add1 = json['add1'];
    add2 = json['add2'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['add1'] = this.add1;
    data['add2'] = this.add2;
    data['city'] = this.city;
    return data;
  }
}

class Category {
  List<String> en;
  List<String> zh;
  List<String> ms;

  Category({this.en, this.zh, this.ms});

  String getTranslated(Locale lang, int index) {
    String text;
    switch (lang.languageCode) {
      case 'ms':
        text = ms[index];
        break;
      case 'zh':
        text = zh[index];
        break;
      case 'en':
        text = en[index];
        break;
      default:
        break;
    }
    return TextUtils.capitalize(text);
  }

  Category.fromJson(Map<String, dynamic> json) {
    en = json['en'].cast<String>();
    zh = json['zh'].cast<String>();
    ms = json['ms'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['zh'] = this.zh;
    data['ms'] = this.ms;
    return data;
  }
}

class Geoloc {
  double lat;
  double lng;

  Geoloc({this.lat, this.lng});

  Geoloc.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
