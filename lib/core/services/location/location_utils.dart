import 'package:geolocator/geolocator.dart';
import 'package:jom_malaysia/core/models/coordinates_model.dart';

class LocationUtils {
  static Geolocator _geolocator = Geolocator()..forceAndroidLocationManager;

  //Get current location
  static Future<String> getCurrentLocation() async {
    String loc;
    await _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async =>
            loc = await _getAddressFromLatLng(position))
        .catchError((e) {
      print(e);
    });
    return loc;
  }

  //Get Location Base on Latitude and Longtitude
  static Future<String> _getAddressFromLatLng(position) async {
    try {
      List<Placemark> p = await _geolocator.placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = p[0];

      return "${place.locality}"; //, ${place.postalCode}, ${place.country}";

    } catch (e) {
      print(e);
    }
    return "";
  }

  static Future<String> getDistanceBetween(
      CoordinatesModel coordinates) async {
        await _geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude)
      }
}
