import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/models/authuser_model.dart';
import 'package:jom_malaysia/core/services/authentication/i_auth_service.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';
import 'package:jom_malaysia/core/services/gateway/exception/signin_cancelled_exception.dart';

class AuthProvider extends ChangeNotifier {
  final IAuthenticationService _service;
  AuthProvider({@required IAuthenticationService service}) : _service = service;

  AuthUser _user;
  AuthUser get user => _user;

  void setUser(FirebaseUser fUser) {
    if (fUser != null) {
      print(fUser.email + fUser?.displayName);
      _user = new AuthUser(
          fUser.uid, fUser.displayName, fUser.photoUrl, fUser.photoUrl);
    } else {
      _user = null;
    }

    notifyListeners();
  }

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
  }
}
