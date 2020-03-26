class OtpRequest {
  String _phoneNumber;
  String get phoneNumber => _phoneNumber.toString();
  String otpCode;
  String verificationId;

  void setPhone(String phone) {
    _phoneNumber = phone;
  }

  bool hasValidPhone() {
    Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    var isValid = _phoneNumber != null && regExp.hasMatch(_phoneNumber);
    return isValid;
  }
}
