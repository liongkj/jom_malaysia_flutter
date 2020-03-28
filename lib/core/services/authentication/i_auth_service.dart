import 'package:jom_malaysia/core/models/authuser_model.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';

abstract class IAuthenticationService {
  Future<void> signUp(String email, String password);
  Future<AuthUser> signInWithGoogle();
  Future registerViaOtp(AuthRequest request);

  Future login();
  Future resetPassword();
}
