import 'package:city_eye/src/core/utils/validation/delegated_steps_validator.dart';

class ValidateSignatureUseCase {
  DelegatedStepsValidationState validateSignatureCaptured(String bytes) {
    return DelegatedStepsValidator.validateSignatureCaptured(bytes);
  }
}
