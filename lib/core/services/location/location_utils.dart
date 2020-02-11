import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jom_malaysia/core/models/coordinates_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/city_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
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
      CoordinatesModel current, ListingModel place, CityModel town) async {
    ///user select town from different city
    if (town != null) {
      if (place.address.city.toLowerCase() != town.cityName.toLowerCase())
        return "";
      if (current == null) {
        return await _getDistanceToTown(place.getCoord, town.coordinates);
      }
    } else if (current != null) {
      //user location is opened
      return _getDistanceToUser(current, place);
    }
    return "";
  }

  static Future<String> _getDistanceToUser(
      CoordinatesModel current, ListingModel place) async {
    double distance = await _geolocator.distanceBetween(current.latitude,
        current.longitude, place.getCoord.latitude, place.getCoord.longitude);

    return distance < 1000
        ? "${distance.toStringAsFixed(0)}m"
        : convertToKm(distance);
  }

  static Future<String> _getDistanceToTown(
      CoordinatesModel place, CoordinatesModel town) async {
    double s = await _geolocator.distanceBetween(
        town.latitude, town.longitude, place.latitude, place.longitude);
    String formattedDistance =
        s < 1 ? "${s.toStringAsFixed(0)}m" : convertToKm(s);
    return "$formattedDistance to town ";
  }

  static String convertToKm(double distance) {
    var converted = distance / 1000;
    var km = converted.toStringAsFixed(1);
    return "${km}km";
  }
}
