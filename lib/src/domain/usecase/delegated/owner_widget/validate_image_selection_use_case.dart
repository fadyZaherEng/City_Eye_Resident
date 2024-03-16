import 'package:city_eye/src/core/utils/validation/delegated_steps_validator.dart';

class ValidateImageSelectionUseCase {

  DelegatedStepsValidationState validateImageSelected(String imagePath) {
    return DelegatedStepsValidator.validateImageSelected(imagePath);
  }
}
