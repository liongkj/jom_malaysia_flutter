import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/services/authentication/i_auth_service.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';
import 'package:jom_malaysia/screens/tabs/account/models/platform_provider_model.dart';

class PlatformProvider extends ChangeNotifier {
  final IAuthenticationService _service;

  PlatformProvider({@required IAuthenticationService service})
      : _service = service;

  List<PlatformProviderModel> _list;

  List<PlatformProviderModel> get list => _list;

  Future<void> linkAccount(AuthProviderEnum type) async {
    var user = await _service.linkAccountWith(type);
    setProviders(user);
  }

  Future<void> unlinkAccount(AuthProviderEnum type) async {
    var user = await _service.unlinkAccountWith(type);
    setProviders(user);
  }

  Future<void> sendSignInWithEmailLink(AuthRequest req) async {
    await _service.sendSignInWithEmailLink(req.email);
  }

  setProviders(FirebaseUser fUser) {
    if (fUser != null) {
      List<PlatformProviderModel> pList = [];
      fUser.providerData?.forEach((p) {
        if (p.providerId != "firebase") {
          pList.add(PlatformProviderModel.createModel(p.providerId, p.email));
        }
      });

      _list = pList;
      notifyListeners();
    }
  }
}
