import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jom_malaysia/core/models/coordinates_model.dart';
import 'package:jom_malaysia/setting/provider/user_current_location_provider.dart';
import 'package:provider/provider.dart';

class LocationUtils {
  static Geolocator _geolocator = Geolocator();

  //Get current location
  static Future<void> getCurrentLocation(BuildContext context) async {
    await _geolocator
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
      List<Placemark> p = await _geolocator.placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = p[0];
      Provider.of<UserCurrentLocationProvider>(context, listen: false)
          .setCurrentLocation(place.locality, position);
      //, ${place.postalCode}, ${place.country}";

    } catch (e) {
      print(e);
    }
    return "";
  }

  static Future<double> getDistanceBetween(
      CoordinatesModel current, CoordinatesModel place) async {
    return await _geolocator.distanceBetween(
        current.latitude, current.longitude, place.latitude, place.longitude);
  }
}
