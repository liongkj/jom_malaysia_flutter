import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/authentication/requests/otp_request.dart';

abstract class IAuthenticationService extends ChangeNotifier {
  Future<void> signUp(String email, String password);
  Future registerViaOtp(OtpRequest request);

  Future login();
  Future resetPassword();
}
