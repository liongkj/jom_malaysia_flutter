class OtpRequest {
  String _phoneNumber;
  String get phoneNumber => _phoneNumber.toString();
  String optCode;

  void setPhone(String phone) {
    _phoneNumber = phone;
  }

  bool hasValidPhone() {
    Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    return _phoneNumber != null && regExp.hasMatch(_phoneNumber);
  }
}
