import 'package:city_eye/src/core/utils/validation/sign_in_validator.dart';

class LoginValidationUseCase {
  List<SignInValidationState> validateFormUseCase(
      {required String mobileNumber, required String password}) {
    List<SignInValidationState> validations = List.empty(growable: true);
    SignInValidationState validation;
    validation = validateMobileNumber(mobileNumber.trim());
    if (validation != SignInValidationState.valid) {
      validations.add(validation);
    }
    validation = validatePassword(password.trim());
    if (validation != SignInValidationState.valid) {
      validations.add(
        validation,
      );
    }
    return validations;
  }

  SignInValidationState validateMobileNumber(String phoneNumber) {
    return SignInValidator.validatePhoneNumber(
      phoneNumber,
    );
  }

  SignInValidationState validatePassword(String password) {
    return SignInValidator.validatePassword(
      password,
    );
  }
}
