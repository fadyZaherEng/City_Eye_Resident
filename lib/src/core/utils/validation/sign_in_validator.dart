class SignInValidator {
  static SignInValidationState validatePhoneNumber(String mobileNumber) {
    if (mobileNumber.isEmpty) {
      return SignInValidationState.mobileNumberEmpty;
    } else {
      return SignInValidationState.valid;
    }
  }

  static SignInValidationState validatePassword(String password) {
    if (password.isEmpty) {
      return SignInValidationState.passwordEmpty;
    } else {
      return SignInValidationState.valid;
    }
  }
}

enum SignInValidationState {
  mobileNumberEmpty,
  passwordEmpty,
  valid,
}
