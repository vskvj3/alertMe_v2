class PhoneValidator {
  static bool validatePhoneNumber(String phoneNumber) {
    String numPattern = r'^[6-9]{1}[0-9]{9}$';
    RegExp regexNum = RegExp(numPattern);
    return regexNum.hasMatch(phoneNumber);
  }
  static bool checkDuplicate(List<List<String>> emergencyContactList,String phoneNumString){
    for (var temp in emergencyContactList){
      if(temp.contains(phoneNumString)){
        return true;
      }
    }
    return false;
  }
}
