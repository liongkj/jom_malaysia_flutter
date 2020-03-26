class OtpRequest {
  String _phoneNumber;
  String get phoneNumber => _phoneNumber.toString();
  String otpCode;
  String verificationId;

  void setPhone(String phone) {
    if (phone != null) {
      _phoneNumber = "+$phone";
    } else
      throw FormatException("Number is null");
  }

  bool hasValidPhone() {
    Pattern pattern = r'(^(\+?6?01)[0-46-9]-*[0-9]{7,8}$)';
    RegExp regExp = new RegExp(pattern);
    var isValid = _phoneNumber != null && regExp.hasMatch(_phoneNumber);
    return isValid;
  }
}
