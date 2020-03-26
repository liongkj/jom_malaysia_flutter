import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/authentication/requests/otp_request.dart';

abstract class IAuthenticationService {
  Future register();
  Future registerViaOtp(OtpRequest request);
  Future getOtp(
    String phoneNumber, {
    @required Function onVerified,
    @required Function onCodeRetrievalTimeout,
    Function onRequestCode,
    Function onCodeSent,
  });
  Future login();
  Future resetPassword();
}
