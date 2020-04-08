import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/services/authentication/firebase_auth_service.dart';

class PlatformProviderModel {
  AuthProviderEnum provider;
  bool linked;
  String email;
  bool verified;

  PlatformProviderModel.createModel(String providerId, String email,
      {bool linked = true, this.verified}) {
    this.email = email;
    this.linked = linked;
    this.provider = FirebaseAuthService.providerMap.keys.firstWhere(
        (k) => FirebaseAuthService.providerMap[k] == providerId,
        orElse: () => throw FormatException("Enum not found"));
  }

  PlatformProviderModel(this.provider, this.email, {this.linked = true});

  @override
  bool operator ==(Object other) =>
      other is PlatformProviderModel && provider == other.provider;

  @override
  int get hashCode => provider.hashCode;
}
