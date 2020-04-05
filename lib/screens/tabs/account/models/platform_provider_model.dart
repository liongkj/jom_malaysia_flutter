import 'package:jom_malaysia/core/constants/common.dart';

class PlatformProviderModel {
  AuthProviderEnum provider;
  bool linked;
  String email;

  PlatformProviderModel.createModel(String providerId, String email,
      {bool linked = true}) {
    this.email = email;
    this.linked = linked;
    this.provider = AuthProviderEnum.values.firstWhere(
        (f) => f.toString().toLowerCase().contains(providerId),
        orElse: () => null);
  }

  PlatformProviderModel(this.provider, this.email, {this.linked = true});
}
