import 'package:city_eye/src/core/utils/validation/delegated_steps_validator.dart';

class ValidateOwnerMessageUseCase {
  DelegatedStepsValidationState validateMessage(String message) {
    return DelegatedStepsValidator.validateMessage(message);
  }
}
