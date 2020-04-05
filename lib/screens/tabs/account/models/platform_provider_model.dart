import 'package:jom_malaysia/core/constants/common.dart';

class PlatformProviderModel {
  AuthProviderEnum provider;
  bool linked;
  String email;

  PlatformProviderModel.createModel(String providerId, String email,
      {bool linked = true}) {
    this.email = email;
    this.linked = linked;

    switch (providerId) {
      case 'google.com':
        this.provider = AuthProviderEnum.GOOGLE;
        break;
      case 'password':
        this.provider = AuthProviderEnum.PASSWORD;
        break;
      default:
        throw FormatException("Enum not found");
    }
  }

  PlatformProviderModel(this.provider, this.email, {this.linked = true});
}
