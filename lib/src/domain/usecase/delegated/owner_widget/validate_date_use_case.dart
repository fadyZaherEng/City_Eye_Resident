import 'package:city_eye/src/core/utils/validation/delegated_steps_validator.dart';

class ValidateDateUseCase {
  DelegatedStepsValidationState validateDate(String date) {
    return DelegatedStepsValidator.validateDate(date);
  }
}