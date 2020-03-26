import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/authentication/requests/otp_request.dart';

abstract class IAuthenticationService extends ChangeNotifier {
  Future register();
  Future registerViaOtp(OtpRequest request);
  Future<void> getOtp(
    String phoneNumber, {
    @required Function onVerified,
    @required Function onCodeRetrievalTimeout,
    @required Function(String, [int]) onCodeSent,
  });
  Future signInWithPhoneNumber(
      {@required String verificationId, @required String vCode});
  Future login();
  Future resetPassword();
}
