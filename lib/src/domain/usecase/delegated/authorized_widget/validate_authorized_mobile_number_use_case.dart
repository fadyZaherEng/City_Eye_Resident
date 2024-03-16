import 'package:city_eye/src/core/utils/validation/delegated_steps_validator.dart';

class ValidateAuthorizedMobileNumberUseCase {

  DelegatedStepsValidationState validateMobileNumber(String phone) {
    return DelegatedStepsValidator.validateMobileNumber(phone);
  }

}