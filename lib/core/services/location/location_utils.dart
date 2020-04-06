import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jom_malaysia/core/models/coordinates_model.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/city_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/setting/provider/user_current_location_provider.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class LocationUtils {
  static Geolocator _geolocator = Geolocator();
  static UserCurrentLocationProvider _getProvider(BuildContext context) {
    return Provider.of<UserCurrentLocationProvider>(context, listen: false);
  }

  ///check if location service is disabled
  static Future<bool> _handlePermission(BuildContext context) async {
    var gpsNotOpened = !await _locationServiceIsEnabled();
    var doNotHavePermit = !await _permissionIsGranted();

    if (gpsNotOpened || doNotHavePermit) {
      if (doNotHavePermit) {
        showToast(S.of(context).locationServicePromptEnableGps,
            dismissOtherToast: true);
      } else if (gpsNotOpened)
        showToast(S.of(context).locationServicePromptPermission,
            dismissOtherToast: true);
      _getProvider(context).setLoading(LocationState.noPermit);
      return false;
    }
    _getProvider(context).setLoading(LocationState.granted);
    return true;
  }

  ///Get current location
  ///need a [context] object to get provider context
  static Future<Position> getCurrentLocation(BuildContext context) async {
    try {
      Position position = await _geolocator.getLastKnownPosition();
      if (position == null) {
        _getProvider(context).setLoading(LocationState.loading);
        position = await Geolocator()
            .getCurrentPosition()
            .timeout(Duration(seconds: 3))
            .then(throw Exception("Gps not open"));
      }
      await _saveUserCoordinate(context, position);
      return position;
    } catch (_) {
      // _getProvider(context).setLoading(LocationState.noPermit);
      await _handlePermission(context);
      return null;
    }
  }

  /// Calculate distance between user current location to selected place, provided town is not null
  /// receive a [current] user location and [place]
  /// if [town] is null, distance is not shown
  static Future<String> getDistanceBetween(
      CoordinatesModel userCurrent, ListingModel place, CityModel town) async {
    if (town != null) {
      //if user gps not open
      if (userCurrent == null) {
        return await _getDistanceToTown(place.getCoord, town.coordinates);
      } else {
        //get user located town
        String userTown = (await _reverseGeocode(
                latitude: userCurrent.latitude,
                longitude: userCurrent.longitude))
            .locality;

        ///if selected place same city
        if (userTown == town.cityName)
          return _getDistanceToUser(userCurrent, place);
        return "";
      }
    }
    return "";
  }

  static Future<bool> _locationServiceIsEnabled() async {
    return await _geolocator.isLocationServiceEnabled();
  }

  static Future<bool> _permissionIsGranted() async {
    return await _geolocator.checkGeolocationPermissionStatus() ==
        GeolocationStatus.granted;
  }

  ///save user located city and coordinate to provider
  static _saveUserCoordinate(BuildContext context, Position position) async {
    Placemark place = await _reverseGeocode(
        latitude: position.latitude, longitude: position.longitude);

    _getProvider(context).setCurrentLocation(place.locality, position);
  }

  /// Get Location Base on Latitude and Longtitude
  /// receive a [latitude] and [longitude]
  /// returns a placemark
  /// etc. placemark.country to get a country string
  static Future<Placemark> _reverseGeocode(
      {double latitude, double longitude}) async {
    List<Placemark> p =
        await _geolocator.placemarkFromCoordinates(latitude, longitude);
    return p[0];
  }

  /// Calculate distance between user current location to selected place
  /// receive a [current] user location and [place]
  /// returns a distance string
  static Future<String> _getDistanceToUser(
      CoordinatesModel current, ListingModel place) async {
    double distance = await _geolocator.distanceBetween(current.latitude,
        current.longitude, place.getCoord.latitude, place.getCoord.longitude);

    return distance < 1000
        ? "${distance.toStringAsFixed(0)}m"
        : _convertToKm(distance);
  }

  /// Calculate distance between town to selected place
  /// receive a [place] user location and [town]
  /// returns a distance string
  static Future<String> _getDistanceToTown(
      CoordinatesModel place, CoordinatesModel town) async {
    double s = await _geolocator.distanceBetween(
        town.latitude, town.longitude, place.latitude, place.longitude);
    String formattedDistance =
        s < 1 ? "${s.toStringAsFixed(0)}m" : _convertToKm(s);
    return "$formattedDistance to town ";
  }

  /// Utility method convert meter to kilometer
  /// receive a [distance] in meters
  /// returns a distance string in km
  static String _convertToKm(double distance) {
    var converted = distance / 1000;
    var km = converted.toStringAsFixed(1);
    return "${km}km";
  }
}
