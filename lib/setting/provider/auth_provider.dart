import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/models/authuser_model.dart';

enum AuthState { ghost, user }

class AuthProvider extends ChangeNotifier {
  AuthUser _user;
  AuthUser get user => _user;

  AuthState _state;
  AuthState get state => _state;
}
