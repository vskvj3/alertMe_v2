class PhoneValidator {
  static bool validatePhoneNumber(String phoneNumber) {
    String numPattern = r'^[6-9]{1}[0-9]{9}$';
    RegExp regexNum = RegExp(numPattern);
    return regexNum.hasMatch(phoneNumber);
  }
}
