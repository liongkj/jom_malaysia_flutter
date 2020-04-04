class PlatformProviderModel {
  String providerId;
  bool linked;
  String email;

  PlatformProviderModel(this.providerId, this.email, {this.linked = true});
}
