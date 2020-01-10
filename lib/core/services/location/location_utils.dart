import 'package:geolocator/geolocator.dart';

class LocationUtils {
  static Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  //Get current location
  static Future<String> getCurrentLocation() async {
    String loc;
    await geolocator
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
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = p[0];

      return "${place.locality}"; //, ${place.postalCode}, ${place.country}";

    } catch (e) {
      print(e);
    }
    return "";
  }
}
