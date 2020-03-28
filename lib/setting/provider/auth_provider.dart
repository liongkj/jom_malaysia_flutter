import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/models/authuser_model.dart';
import 'package:jom_malaysia/core/services/authentication/i_auth_service.dart';
import 'package:jom_malaysia/core/services/gateway/exception/signin_cancelled_exception.dart';

enum AuthState { ghost, user }

class AuthProvider extends ChangeNotifier {
  final IAuthenticationService _service;
  AuthProvider({@required IAuthenticationService service}) : _service = service;

  String _token;
  DateTime _expiryDate;
  String _userId;

  AuthUser _user;
  AuthUser get user => _user;

  AuthState _state;
  AuthState get state => _state;

  Future<void> signUp(String email, String password) async {
    var user = await _service.signUp(email, password);
  }

  Future<void> signInWithGoogle() async {
    if (await _service.signInWithGoogle() == null)
      throw SignInCancelledException();
  }
}
