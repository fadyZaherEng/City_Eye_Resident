class OTPValidator {
  static OTPValidationState validateOTPNumber(List<int> otpNumber) {
    if (otpNumber.isEmpty||otpNumber.length!=4) {
      return OTPValidationState.invalidLength;
    } else {
      return OTPValidationState.valid;
    }
  }
}

enum OTPValidationState {
  invalidLength,
  valid,
}
