import 'package:city_eye/src/core/utils/validation/community_validator.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';

class CommunityValidateQuestionsUseCase {
  CommunityValidationState validateMandatoryQuestions(
      List<PageField> questions) {
    return CommunityValidator.validateMandatoryQuestions(questions);
  }
}
