import 'package:city_eye/src/core/utils/validation/delegated_steps_validator.dart';

class ValidateIdUseCase {
  DelegatedStepsValidationState validateId(String id) {
    return DelegatedStepsValidator.validateId(id);
  }
}