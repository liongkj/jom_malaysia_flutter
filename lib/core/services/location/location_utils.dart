import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jom_malaysia/core/models/coordinates_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/city_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/setting/provider/user_current_location_provider.dart';
import 'package:provider/provider.dart';

class LocationUtils {
  static Geolocator _geolocator = Geolocator();

  static Future<bool> isLocationServiceDisabled() async {
    return await _geolocator.checkGeolocationPermissionStatus() ==
        GeolocationStatus.disabled;
  }

  ///Get current location
  static Future<void> getCurrentLocation(BuildContext context) async {
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    if (position == null) {
      await _geolocator.getCurrentPosition().then((Position position) async {
        Placemark place = await _getAddressFromLatLng(
            latitude: position.latitude, longitude: position.longitude);
        Provider.of<UserCurrentLocationProvider>(context, listen: false)
            .setCurrentLocation(place.locality, position);
      }).catchError((e) {
        print(e);
      });
    } else {
      Placemark place = await _getAddressFromLatLng(
          latitude: position.latitude, longitude: position.longitude);
      Provider.of<UserCurrentLocationProvider>(context, listen: false)
          .setCurrentLocation(place.locality, position);
    }
  }

  //Get Location Base on Latitude and Longtitude
  static Future<Placemark> _getAddressFromLatLng(
      {double latitude, double longitude}) async {
    try {
      List<Placemark> p =
          await _geolocator.placemarkFromCoordinates(latitude, longitude);
      return p[0];
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<String> getDistanceBetween(
      CoordinatesModel current, ListingModel place, CityModel town) async {
    //town null check
    if (town != null) {
      //if user gps not open
      if (await isLocationServiceDisabled() || current == null) {
        return await _getDistanceToTown(place.getCoord, town.coordinates);
        //user gps is opened
      } else {
        //get user located town
        String userTown = (await _getAddressFromLatLng(
                latitude: current.latitude, longitude: current.longitude))
            .locality;

        ///if selected place is from different city
        if (userTown != town.cityName)
          return "";
        else {
          return _getDistanceToUser(current, place);
        }
      }
    }
    return "";
  }

  static Future<String> _getDistanceToUser(
      CoordinatesModel current, ListingModel place) async {
    double distance = await _geolocator.distanceBetween(current.latitude,
        current.longitude, place.getCoord.latitude, place.getCoord.longitude);

    return distance < 1000
        ? "${distance.toStringAsFixed(0)}m"
        : _convertToKm(distance);
  }

  static Future<String> _getDistanceToTown(
      CoordinatesModel place, CoordinatesModel town) async {
    double s = await _geolocator.distanceBetween(
        town.latitude, town.longitude, place.latitude, place.longitude);
    String formattedDistance =
        s < 1 ? "${s.toStringAsFixed(0)}m" : _convertToKm(s);
    return "$formattedDistance to town ";
  }

  static String _convertToKm(double distance) {
    var converted = distance / 1000;
    var km = converted.toStringAsFixed(1);
    return "${km}km";
  }
}
