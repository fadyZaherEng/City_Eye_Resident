import 'package:city_eye/src/core/utils/validator.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';

class DelegatedStepsValidator {
  static DelegatedStepsValidationState validateName(String name) {
    if (name.isEmpty) {
      return DelegatedStepsValidationState.nameEmpty;
    } else if (!Validator.isFullNameValid(name)) {
      return DelegatedStepsValidationState.nameInvalid;
    } else {
      return DelegatedStepsValidationState.valid;
    }
  }

  static DelegatedStepsValidationState validateMobileNumber(
      String mobileNumber) {
    if (mobileNumber.isEmpty) {
      return DelegatedStepsValidationState.mobileNumberEmpty;
    } else {
      return DelegatedStepsValidationState.valid;
    }
  }

  static DelegatedStepsValidationState validateMessage(String message) {
    if (message.isEmpty) {
      return DelegatedStepsValidationState.messageEmpty;
    } else {
      return DelegatedStepsValidationState.valid;
    }
  }

  static DelegatedStepsValidationState validateId(String id) {
    if (id.isEmpty) {
      return DelegatedStepsValidationState.idEmpty;
    } else {
      return DelegatedStepsValidationState.valid;
    }
  }

  static DelegatedStepsValidationState validateDate(String date) {
    if (date.isEmpty) {
      return DelegatedStepsValidationState.dateEmpty;
    } else {
      return DelegatedStepsValidationState.valid;
    }
  }

  static DelegatedStepsValidationState validateImageSelected(String imagePath) {
    if (imagePath.isEmpty) {
      return DelegatedStepsValidationState.imageEmpty;
    } else {
      return DelegatedStepsValidationState.valid;
    }
  }

  static DelegatedStepsValidationState validateSignatureCaptured(String bytes) {
    if (bytes.isEmpty) {
      return DelegatedStepsValidationState.signatureEmpty;
    } else {
      return DelegatedStepsValidationState.valid;
    }
  }

  static DelegatedStepsValidationState validateMandatoryQuestions(
      List<PageField> questions) {
    bool isAllQuestionAnswered = true;
    for (var i = 0; i < questions.length; i++) {
      if (questions[i].isRequired ?? false) {
        if (questions[i].value == "" || questions[i].value == null) {
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
      return DelegatedStepsValidationState.valid;
    } else {
      return DelegatedStepsValidationState.invalidQuestions;
    }
  }
}

enum DelegatedStepsValidationState {
  messageEmpty,
  messageInvalid,
  nameEmpty,
  nameInvalid,
  idEmpty,
  idInvalid,
  unitNoEmpty,
  dateEmpty,
  dateFromEmpty,
  dateToEmpty,
  imageEmpty,
  mobileNumberEmpty,
  signatureEmpty,
  invalidQuestions,
  valid
}
