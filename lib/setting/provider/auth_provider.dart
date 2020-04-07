import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/models/authuser_model.dart';
import 'package:jom_malaysia/core/services/authentication/i_auth_service.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';
import 'package:jom_malaysia/core/services/gateway/exception/signin_cancelled_exception.dart';
import 'package:jom_malaysia/screens/tabs/account/models/platform_provider_model.dart';

class AuthProvider extends ChangeNotifier {
  final IAuthenticationService _service;

  AuthProvider({@required IAuthenticationService service}) : _service = service;

  AuthUser _user;

  AuthUser get user => _user;

  List<PlatformProviderModel> _providerList = [];

  List<PlatformProviderModel> get providerList => [..._providerList];

  void setUser(FirebaseUser fUser) {
    if (fUser != null) {
      _user = new AuthUser(fUser.uid, fUser.displayName, fUser.photoUrl,
          fUser.email, fUser.isEmailVerified);
      notifyListeners();
    } else {
      if (_user != null) {
        _user = null;
        notifyListeners();
      }
    }
  }

  Future<void> signUp(AuthRequest request) async {
    await _service.registerWithEmailPassword(request);
  }

  Future<void> logOut() async {
    await _service.logout();
  }

  Future<void> signInWithGoogle() async {
    var result = await _service.signInWithGoogle();
    if (result == null) throw SignInCancelledException();
  }

  Future<void> signInWithEmailPassword(AuthRequest request) async {
    await _service.signInWithEmailPassword(request);
  }

  Future<void> changeDisplayName(String dn) async {
    _user = await _service.changeDisplayName(dn);
    notifyListeners();
  }

  Future<void> changePassword(AuthRequest request) async {
    await _service.changePassword(request);
  }

  Future<void> destroy() async {
    await _service.deleteAccount();
  }
}
