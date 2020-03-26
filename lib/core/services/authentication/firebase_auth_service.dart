import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jom_malaysia/core/services/authentication/i_auth_service.dart';
import 'package:jom_malaysia/core/services/authentication/requests/otp_request.dart';
import 'package:jom_malaysia/core/services/gateway/exception/network_exception.dart';

class FirebaseAuthService extends IAuthenticationService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<FirebaseUser> login() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }

  @override
  Future register() {
    // TODO: implement register
    return null;
  }

  @override
  Future resetPassword() {
    // TODO: implement resetPassword
    return null;
  }

  @override
  Future registerViaOtp(OtpRequest request) {
    // TODO: implement resetPassword
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

  Future signInWithPhoneNumber(
      {@required String verificationId, @required String vCode}) async {
    AuthCredential _cred = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: vCode);
    await _signIn(_cred);
  }

  void _signIn(AuthCredential cred) async {
    await _auth.signInWithCredential(cred).then((AuthResult value) {
      if (value.user != null) {
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
}
