import 'package:city_eye/src/core/utils/validation/delegated_steps_validator.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';

class ValidateQuestionsUseCase {
  DelegatedStepsValidationState validateMandatoryQuestions(
      List<PageField> questions) {
    return DelegatedStepsValidator.validateMandatoryQuestions(questions);
  }
}
