import 'package:city_eye/src/core/utils/validation/otp_validator.dart';

class OTPValidationUseCase {

  OTPValidationState validateOtpNumber({
    required List<int> otpNumber,
  }) {
    return OTPValidator.validateOTPNumber(
      otpNumber,
    );
  }
}
