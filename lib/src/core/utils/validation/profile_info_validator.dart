
class ProfileInfoValidator {

  static ProfileInfoValidationState validateName(String name) {
    if (name.isEmpty) {
      return ProfileInfoValidationState.nameEmpty;
    } else {
      List<String> words = name.trim().split(' ');
      if (words.length < 2 || words.any((word) => word.length < 2)) {
        return ProfileInfoValidationState.invalidName;
      } else {
        return ProfileInfoValidationState.valid;
      }
    }
  }

  static ProfileInfoValidationState validateEmailAddress(String emailAddress) {
    if (emailAddress.isEmpty) {
      return ProfileInfoValidationState.invalidEmailAddress;
    } else if (!isValidEmailFormat(emailAddress)) {
      return ProfileInfoValidationState.invalidEmailAddress;
    } else {
      return ProfileInfoValidationState.valid;
    }
  }

  static bool isValidEmailFormat(String email) {
    const emailRegex = r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
    final regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

}

enum ProfileInfoValidationState {
  nameEmpty,
  invalidName,
  invalidEmailAddress,
  emailEmpty,
  valid,
}
