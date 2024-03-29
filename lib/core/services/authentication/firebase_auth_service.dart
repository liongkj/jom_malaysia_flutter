import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/models/authuser_model.dart';
import 'package:jom_malaysia/core/services/authentication/i_auth_service.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';
import 'package:jom_malaysia/core/services/gateway/exception/account_in_use_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/duplicate_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/invalid_credential_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/invalid_email_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/not_found_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/operation_cancel_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/require_reauth_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/too_many_request_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/unknown_error_exception.dart';
import 'package:jom_malaysia/screens/tabs/account/models/platform_provider_model.dart';
import 'package:jom_malaysia/util/text_utils.dart';

class FirebaseAuthService extends IAuthenticationService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Map<AuthProviderEnum, String> providerMap = {
    AuthProviderEnum.GOOGLE: "google.com",
    AuthProviderEnum.PASSWORD: "password",
    AuthProviderEnum.FACEBOOK: "facebook"
  };

  @override
  Future<AuthUser> registerWithEmailPassword(AuthRequest request) async {
    try {
      FirebaseUser result = (await _auth.createUserWithEmailAndPassword(
              email: request.email, password: request.password))
          .user;
      AuthUser user = new AuthUser(result.uid, result.displayName,
          result.photoUrl, result.email, result.isEmailVerified);
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
      final AuthResult authResult =
          await _auth.signInWithCredential(await _getGoogleAuth());
      final FirebaseUser result = authResult.user;
      AuthUser user = new AuthUser(result.uid, result.displayName,
          result.photoUrl, result.email, result.isEmailVerified);
      return user;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<AuthCredential> _getGoogleAuth() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    if (googleSignInAccount == null) {
      throw OperationCancelledException("sign_in_cancelled");
    }
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    return credential;
    //cannot catch cancel exception
    //github issue: https://github.com/flutter/flutter/issues/26705
  }

  @override
  Future<AuthUser> signInWithEmailPassword(AuthRequest request) async {
    try {
      FirebaseUser result = (await _auth.signInWithEmailAndPassword(
              email: request.email, password: request.password))
          .user;
      AuthUser user = new AuthUser(result.uid, result.displayName,
          result.photoUrl, result.email, result.isEmailVerified);
      return user;
    } catch (error) {
      switch (error.code) {
        case "ERROR_WRONG_PASSWORD":
          throw InvalidCredentialException("");
          break;
        case "ERROR_USER_NOT_FOUND":
          throw NotFoundException("user");
          break;

        default:
          throw error;
      }
    }
  }

  @override
  Future<void> logout() async {
    if (await _googleSignIn.isSignedIn()) await _googleSignIn.disconnect();
    await _auth.signOut();
  }

  Future<AuthUser> changeDisplayName(String displayName) async {
    var user = await _auth.currentUser();
    try {
      UserUpdateInfo updated = UserUpdateInfo();
      updated.displayName = TextUtils.capitalize(displayName.trim());
      await user.updateProfile(updated);
      user.reload();
      user = await _auth.currentUser();
    } catch (error) {
      switch (error.code) {
        case "ERROR_USER_NOT_FOUND":
          throw NotFoundException("user");
          break;
      }
    }
    return new AuthUser(user.uid, user.displayName, user.photoUrl, user.email,
        user.isEmailVerified);
  }

  @override
  Future changePassword(AuthRequest request, {String locale = 'en'}) async {
    try {
      await _auth.setLanguageCode(locale);
      await _auth.sendPasswordResetEmail(email: request.email);
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          throw InvalidEmailException("user");
          break;
        case "ERROR_USER_NOT_FOUND":
          throw NotFoundException("user");
          break;
      }
      return null;
    }
  }

  @override
  Future<FirebaseUser> linkAccountWith(
    AuthProviderEnum type, {
    AuthRequest req,
  }) async {
    AuthCredential cred;
    try {
      var user = await _auth.currentUser();
      if (user == null) throw NotFoundException("user");

      switch (type) {
        case AuthProviderEnum.PASSWORD:
          cred = _getEmailAuth(req);
          await _reauthenticateUser();
          break;
        case AuthProviderEnum.GOOGLE:
          cred = await _getGoogleAuth();
          await _reauthenticateUser(request: req);
          break;
        default:
          throw InvalidCredentialException("");
      }

      final AuthResult authResult = await user.linkWithCredential(cred);

      return authResult.user;
    } catch (error) {
      switch (error.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
          throw AccountInUseException();
        case "ERROR_CREDENTIAL_ALREADY_IN_USE":
          throw AccountInUseException();
          break;
        case "ERROR_REQUIRES_RECENT_LOGIN":
          throw RequireReauthException();
          break;
        default:
          throw error;
      }
    }
  }

  @override
  Future<FirebaseUser> unlinkAccountWith(AuthProviderEnum type,
      {AuthRequest request}) async {
    try {
      var user = await _auth.currentUser();
      if (user == null) throw NotFoundException("user");
      String providerId = user.providerData
          .firstWhere((id) => providerMap[type] == id.providerId,
              orElse: () => null)
          .providerId;

      if (providerId == providerMap[AuthProviderEnum.PASSWORD]) {
        if (await _reauthenticateUser(request: request) == null)
          throw InvalidCredentialException;
      }
      if (providerId == providerMap[AuthProviderEnum.GOOGLE]) {
        await _googleSignIn.disconnect();
      }
      await user.unlinkFromProvider(providerId);
      await user.reload();
      return await _auth.currentUser();
    } catch (error) {
      switch (error.code) {
        case "REQUIRES_RECENT_LOGIN":
          throw RequireReauthException();
          break;
        case "ERROR_WRONG_PASSWORD":
          throw InvalidCredentialException("");
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          throw TooManyRequestException();
        default:
          debugPrint(error.code);
          throw error;
      }
    }
  }

  ///default to use google reauth, provider request to reauth wth password
  Future<AuthResult> _reauthenticateUser({AuthRequest request}) async {
    var user = await _auth.currentUser();
    var credential;
    if (request != null) {
      credential = _getEmailAuth(request);
    } else {
      if (_getConnectedAccount(user)
              .indexWhere((d) => d.provider == AuthProviderEnum.GOOGLE) >
          -1) {
        credential = await _googleRequest(() => _getGoogleAuth());
      }
    }
    return await user.reauthenticateWithCredential(credential);
  }

  Future<T> _googleRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on PlatformException catch (platformError, platformStacktrace) {
      debugPrint(
          'Caught a platform exception in GoogleSignIn\n$platformError, $platformStacktrace');
      try {
        debugPrint('Re-initializing _googleSignIn');

        await _init(_googleSignIn.scopes, suppressErrors: false);

        debugPrint('Retrying google');

        return await request();
      } catch (error, stacktrace) {
        debugPrint(
            'Failed to re-initialize _googleSignIn\n$error, $stacktrace');

        rethrow;
      }
    }
  }

  Future<void> _init(List<String> scopes, {bool suppressErrors = true}) async {
    _googleSignIn.signInSilently();
  }

  AuthCredential _getEmailAuth(AuthRequest req) {
    return EmailAuthProvider.getCredential(
      email: req.email,
      password: req.password,
    );
  }

  List<PlatformProviderModel> _getConnectedAccount(FirebaseUser fUser) {
    List<PlatformProviderModel> pList = [];
    fUser.providerData?.forEach((p) {
      if (p.providerId != "firebase") {
        pList.add(PlatformProviderModel.createModel(p.providerId, p.email));
      }
    });
    return pList;
  }

  @override
  Future<void> deleteAccount() {
    // TODO: implement deleteAccount
    return null;
  }

  Future<void> verifyUser() async {
    _auth.currentUser().then((u) => u.sendEmailVerification());
  }
}
