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

  static Future<String> getDistanceBetween(
      CoordinatesModel current, CoordinatesModel place,
      {bool precise = false}) async {
    double distance;

    if (current != null) {
      //user location is opened
      distance = await _geolocator.distanceBetween(
          current.latitude, current.longitude, place.latitude, place.longitude);
      var km = distance / 1000;
      String s;
      if (!precise) {
        if (km > 50) {
          return await _getDistanceToTown(place);
        } else {
          s = km < 1 ? "${km * 1000} m" : "${km.toStringAsFixed(2)} km";
        }
      } else {
        s = "${km.toStringAsFixed(1)} km";
      }
      return s;
    } else {
      return await _getDistanceToTown(place);
    }
  }

  static Future<String> _getDistanceToTown(CoordinatesModel place) async {
    final CoordinatesModel serembanTown =
        CoordinatesModel(longitude: 2.7297, latitude: 101.9381);
    var s = await _geolocator.distanceBetween(serembanTown.latitude,
        serembanTown.longitude, place.latitude, place.longitude);
    return "$s km to Seremban town ";
  }
}
