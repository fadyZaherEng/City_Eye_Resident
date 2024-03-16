import 'package:city_eye/src/domain/entities/settings/page_field.dart';

class CommunityValidator {
  static CommunityValidationState validateMandatoryQuestions(
      List<PageField> questions) {
    bool isAllQuestionAnswered = true;
    for (var i=0; i < questions.length; i++) {
      if (questions[i].isRequired ?? false) {
        if (questions[i].value == "") {
          questions[i] = questions[i].copyWith(
            notAnswered: true,
          );
          isAllQuestionAnswered = false;
        } else {
          questions[i] = questions[i].copyWith(
            notAnswered: false,
          );
        }
      }
    }
    if (isAllQuestionAnswered) {
      return CommunityValidationState.valid;
    } else {
      return CommunityValidationState.invalidQuestions;
    }
  }
}

enum CommunityValidationState { invalidQuestions, valid }
