import 'dart:ui';

import 'package:azlistview/azlistview.dart';
import 'package:jom_malaysia/core/models/coordinates_model.dart';
import 'package:jom_malaysia/util/text_utils.dart';
import 'package:lpinyin/lpinyin.dart';

class CityModel extends ISuspensionBean {
  CityModel(
      {this.cityName,
      this.cityNameZh,
      this.isHot,
      this.firstChar,
      this.firstCharZh,
      this.tagIndex,
      this.coordinates});

  String cityName;
  String cityNameZh;
  String firstChar;
  String firstCharZh;
  String tagIndex;
  bool isHot;
  CoordinatesModel coordinates;

  CityModel.fromJsonMap(Map<String, dynamic> map)
      : cityName = map['cityName'] ?? "",
        cityNameZh = map['cityNameZh'] ?? "",
        isHot = map['isHot'] ?? false,
        firstCharZh = map['firstCharZh'] ?? '',
        coordinates = map['coordinates'] == null
            ? null
            : CoordinatesModel.fromJson(
                map['coordinates'] as Map<String, dynamic>),
        firstChar = map['firstChar'] == null ? "" : map['firstChar'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityName'] = cityName;
    data['cityNameZh'] = cityNameZh;
    data['firstChar'] = firstChar;
    data['isHot'] = isHot;
    data['coordinates'] = coordinates;
    return data;
  }

  @override
  String getSuspensionTag() {
    return tagIndex;
  }

  String getCityName(Locale lang, {bool fullName = false}) {
    if (lang.languageCode == 'zh') return cityNameZh;
    return fullName
        ? TextUtils.capitalize(cityName)
        : TextUtils.shorten(cityName);
  }

  String getFirstChar(Locale lang) {
    if (lang.languageCode == 'zh')
      return TextUtils.capitalize(
        PinyinHelper.getPinyin(cityNameZh).substring(0, 1),
      );

    return TextUtils.capitalize(firstChar);
  }
}
