import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jom_malaysia/core/models/authuser_model.dart';
import 'package:jom_malaysia/core/services/authentication/i_auth_service.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';
import 'package:jom_malaysia/core/services/gateway/exception/duplicate_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/invalid_credential_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/invalid_email_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/network_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/not_found_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/unknown_error_exception.dart';
import 'package:jom_malaysia/util/text_utils.dart';

class FirebaseAuthService extends IAuthenticationService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<AuthUser> registerWithEmailPassword(AuthRequest request) async {
    try {
      FirebaseUser result = (await _auth.createUserWithEmailAndPassword(
              email: request.email, password: request.password))
          .user;
      AuthUser user = new AuthUser(
          result.uid, result.displayName, result.photoUrl, result.email);
      return user;
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          throw InvalidEmailException("");
          break;
        case "ERROR_WEAK_PASSWORD":
          throw InvalidCredentialException("WEAK");
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          throw DuplicateException(status: 'exists');
          break;
        default:
          throw UnknownErrorException(error.toString());
      }
    }
  }

  Future<AuthUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser result = authResult.user;
      AuthUser user = new AuthUser(
          result.uid, result.displayName, result.photoUrl, result.email);
      return user;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  Future<AuthUser> signInWithEmailPassword(AuthRequest request) async {
    try {
      FirebaseUser result = (await _auth.signInWithEmailAndPassword(
              email: request.email, password: request.password))
          .user;
      AuthUser user = new AuthUser(
          result.uid, result.displayName, result.photoUrl, result.email);
      return user;
    } catch (error) {
      switch (error.code) {
        case "ERROR_WRONG_PASSWORD":
          throw InvalidCredentialException("");
          break;
        case "ERROR_USER_NOT_FOUND":
          throw NotFoundException("user");
          break;
      }
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> changeDisplayName(String displayName) async {
    try {
      var user = await _auth.currentUser();
      UserUpdateInfo updated = UserUpdateInfo();
      updated.displayName = TextUtils.capitalize(displayName.trim());
      user.updateProfile(updated);
    } catch (error) {
      switch (error.code) {
        case "ERROR_USER_NOT_FOUND":
          throw NotFoundException("user");
          break;
      }
    }
    return null;
  }

  @override
  Future getOtp(
    String phoneNumber, {
    Function(String, [int]) onCodeSent,
    @required Function onVerified,
    @required Function onCodeRetrievalTimeout,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 30),
        verificationCompleted: (cred) => _signIn,
        verificationFailed: (auth) => _verificationFailed,
        codeAutoRetrievalTimeout: onCodeRetrievalTimeout,
        codeSent: (str, [code]) => onCodeSent,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<void> signInWithPhoneNumber(
      {@required String verificationId, @required String vCode}) async {
    AuthCredential _cred = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: vCode);
    _signIn(_cred);
  }

  void _signIn(AuthCredential cred) async {
    await _auth.signInWithCredential(cred).then((AuthResult value) {
      if (value.user != null) {
        return value.user;
      } else {
        throw Exception('error creating user');
      }
    }).catchError((error) {
      throw error;
    });
  }

  PhoneVerificationFailed _verificationFailed(AuthException authException) {
    if (authException.code.contains("invalidCredential")) {
      throw FormatException(authException.message ?? authException.message);
    }
    if (authException.message.contains('not authorized'))
      throw Exception('Something has gone wrong, please try later');
    else if (authException.message.contains('Network'))
      throw NetworkException(
          503, 'Please check your internet connection and try again');
    else
      throw Exception('Something has gone wrong, please try later');
  }

  @override
  Future registerViaOtp(AuthRequest request) {
    // TODO: implement registerViaOtp
    return null;
  }

  @override
  Future resetPassword() {
    // TODO: implement resetPassword
    return null;
  }
}
