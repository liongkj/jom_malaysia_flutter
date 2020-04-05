import 'package:firebase_auth/firebase_auth.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/models/authuser_model.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';

abstract class IAuthenticationService {
  Future<AuthUser> registerWithEmailPassword(AuthRequest request);

  Future<AuthUser> signInWithGoogle();

  Future<AuthUser> signInWithEmailPassword(AuthRequest request);

  Future<void> logout();

  Future<FirebaseUser> linkAccountWith(AuthProviderEnum type);

  Future<FirebaseUser> unlinkAccountWith(AuthProviderEnum type);

  Future<AuthUser> changeDisplayName(String displayName);

  Future<void> changePassword(AuthRequest request);

  Future<void> deleteAccount();
}
