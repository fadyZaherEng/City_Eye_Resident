import 'package:city_eye/src/core/utils/validation/forget_password_validation.dart';

class ForgetPasswordValidationUseCase {
  List<ForgetPasswordValidationState> validateFormUseCase(
      {required String email}) {
    List<ForgetPasswordValidationState> validations =
        List.empty(growable: true);
    ForgetPasswordValidationState validation;
    validation = validateEmailAddress(
      email: email,
    );
    if (validation != ForgetPasswordValidationState.valid) {
      validations.add(
        validation,
      );
    }
    return validations;
  }

  ForgetPasswordValidationState validateEmailAddress({
    required String email,
  }) {
    return ForgetPasswordValidator.validateEmail(
      email,
    );
  }
}
