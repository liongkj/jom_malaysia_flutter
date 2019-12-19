class Merchant {
  String merchantId;
  String ssmId;
  String registrationName;

  Merchant(this.merchantId, this.ssmId, this.registrationName);

  Merchant.fromJson(Map<String, dynamic> json)
      : merchantId = json['merchantId'],
        ssmId = json['ssmId'],
        registrationName = json['registrationName'];
}