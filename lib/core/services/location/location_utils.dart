import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jom_malaysia/setting/provider/user_current_location_provider.dart';
import 'package:provider/provider.dart';

class LocationUtils {
  static Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  //Get current location
  static Future<void> getCurrentLocation(BuildContext context) async {
    await geolocator
        .getCurrentPosition()
        .then((Position position) async =>
            await _getAddressFromLatLng(position, context))
        .catchError((e) {
      print(e);
    });
  }

  //Get Location Base on Latitude and Longtitude
  static Future<void> _getAddressFromLatLng(
      Position position, BuildContext context) async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = p[0];
      Provider.of<UserCurrentLocationProvider>(context, listen: false)
          .setCurrentLocation(place.locality);
      //, ${place.postalCode}, ${place.country}";

    } catch (e) {
      print(e);
    }
    return "";
  }
}
