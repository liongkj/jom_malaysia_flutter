import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/city_model.dart';

class LocationProvider extends ChangeNotifier {
  bool rebuildHome = true;

  CityModel get selected {
    CityModel city =
        CityModel.fromJsonMap(SpUtil.getObject(Constant.prefLocation));
    return city;
  }

  clear() {
    SpUtil.remove(Constant.prefLocation);

    notifyListeners();
  }

  selectPlace(CityModel city) {
    SpUtil.putObject(Constant.prefLocation, city);

    rebuildHome = true;
    notifyListeners();
  }

  void syncLoc() {
    String loc = SpUtil.getString(Constant.prefLocation);
    if (loc.isNotEmpty) {
      notifyListeners();
    }
  }
}
