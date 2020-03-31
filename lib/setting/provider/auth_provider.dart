import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/models/authuser_model.dart';
import 'package:jom_malaysia/core/services/authentication/i_auth_service.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';
import 'package:jom_malaysia/core/services/gateway/exception/signin_cancelled_exception.dart';

class AuthProvider extends ChangeNotifier {
  final IAuthenticationService _service;
  AuthProvider({@required IAuthenticationService service}) : _service = service;

  String _token;
  DateTime _expiryDate;
  String _userId;

  AuthUser _user;
  AuthUser get user => _user;

  Future<void> signUp(AuthRequest request) async {
    var result = await _service.registerWithEmailPassword(request);
  }

  Future<void> logOut() async {
    var result = await _service.logout();
  }

  Future<void> signInWithGoogle() async {
    var result = await _service.signInWithGoogle();
    if (result == null) throw SignInCancelledException();
  }

  Future<void> signInWithEmailPassword(AuthRequest request) async {
    var result = await _service.signInWithEmailPassword(request);
  }

  Future<void> changeDisplayName(String dn) async {
    var result = await _service.changeDisplayName(dn);
    // notifyListeners();
  }
}
