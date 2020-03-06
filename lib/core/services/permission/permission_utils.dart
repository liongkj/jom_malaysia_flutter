import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  final PermissionHandler _permissionHandler = PermissionHandler();

  Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> hasPermission(PermissionGroup permission) async {
    var permissionStatus =
        await _permissionHandler.checkPermissionStatus(permission);
    return permissionStatus == PermissionStatus.granted;
  }

  /// Requests the users permission to read their location when the app is in use
  Future<bool> requestLocationPermission() async {
    return _requestPermission(PermissionGroup.locationWhenInUse);
  }

  /// Requests the users permission to read their location when the app is in use
  Future<bool> requestCameraPermission() async {
    return _requestPermission(PermissionGroup.camera);
  }

  /// Requests the users permission to read their location when the app is in use
  Future<bool> requestStoragePermission() async {
    return _requestPermission(PermissionGroup.photos);
  }
}
