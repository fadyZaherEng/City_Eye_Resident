class ForgetPasswordValidator {
  static ForgetPasswordValidationState validateEmail(String email) {
    if (email.isEmpty) {
      return ForgetPasswordValidationState.emailEmpty;
    } else if (!isValidEmailFormat(email)) {
      return ForgetPasswordValidationState.format;
    } else {
      return ForgetPasswordValidationState.valid;
    }
  }

  static bool isValidEmailFormat(String email) {
    const emailRegex = r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
    final regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }
}

enum ForgetPasswordValidationState {
  emailEmpty,
  format,
  valid,
}
