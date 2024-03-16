import 'package:city_eye/src/core/utils/validation/delegated_steps_validator.dart';

class ValidateAuthorizedNameUseCase {
  DelegatedStepsValidationState validateName(String name) {
    return DelegatedStepsValidator.validateName(name.trim());
  }
}
