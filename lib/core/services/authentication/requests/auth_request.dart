class AuthRequest {
  String _phoneNumber;

  String get phoneNumber => _phoneNumber.toString();
  String otpCode;
  String verificationId;
  String email;
  String password;
  String newPassword;
  bool rememberMe = true;

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

  void setEmail(String value) {
    if (value != null && _hasValidEmail(value)) {
      email = value.toLowerCase();
    } else
      throw FormatException("email is invalid");
  }

  void setPassword(String value) {
    if (value != null) {
      password = value;
    }
  }

  void setNewPassword(String value) {
    if (value != null) {
      newPassword = value;
    }
  }

  void setRememberMe(bool value) {
    rememberMe = value;
  }

  String validateEmail(String value) {
    if (_hasValidEmail(value))
      return null;
    else {
      throw FormatException();
    }
  }

  bool _hasValidEmail(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }

  bool _hasValidLength(String value, int length) {
    return value.length >= length;
  }

  String validatePassword(String value, int lenght) {
    if (_hasValidLength(value, lenght))
      return null;
    else {
      throw FormatException();
    }
  }
}
