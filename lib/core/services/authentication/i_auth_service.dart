import 'package:jom_malaysia/core/models/authuser_model.dart';
import 'package:jom_malaysia/core/services/authentication/requests/otp_request.dart';

abstract class IAuthenticationService {
  Future<void> signUp(String email, String password);
  Future<AuthUser> signInWithGoogle();
  Future registerViaOtp(OtpRequest request);

  Future login();
  Future resetPassword();
}
