import 'dart:ui';

import 'package:azlistview/azlistview.dart';
import 'package:jom_malaysia/util/text_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel extends ISuspensionBean {
  CityModel({
    this.cityName,
    this.cityNameZh,
    this.isHot,
    this.firstChar,
    this.firstCharZh,
    this.tagIndex,
  });
  String cityName;
  String cityNameZh;
  String firstChar;
  String firstCharZh;
  String tagIndex;
  bool isHot;

  CityModel.fromJsonMap(Map<String, dynamic> map)
      : cityName = map['cityName'],
        cityNameZh = map['cityNameZh'],
        isHot = map['isHot'],
        firstCharZh = map['firstCharZh'],
        firstChar = map['firstChar'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityName'] = cityName;
    data['cityNameZh'] = cityNameZh;
    data['firstChar'] = firstChar;
    data['isHot'] = isHot;
    data['firstCharZh'] = firstCharZh;
    return data;
  }

  @override
  String getSuspensionTag() {
    return tagIndex;
  }

  String getCityName(Locale lang) {
    if (lang.languageCode == 'zh') return TextUtils.capitalize(cityNameZh);

    return TextUtils.capitalize(cityName);
  }

  String getFirstChar(Locale lang) {
    if (lang.languageCode == 'zh') return TextUtils.capitalize(firstCharZh);

    return TextUtils.capitalize(firstChar);
  }
}
