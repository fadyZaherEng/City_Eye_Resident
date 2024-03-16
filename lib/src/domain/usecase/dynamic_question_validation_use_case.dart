import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/domain/entities/settings/validation.dart';

class DynamicQuestionValidationUseCase {
  Map<String, dynamic> call(
      {required List<Validation> validation,
      required String value,
      required String questionCode}) {
    return _isValid(validation, value, questionCode);
  }

  Map<String, dynamic> _isValid(
      List<Validation> validation, String value, String questionCode) {
    bool isAnswerValid = true;
    String validationMessage = "";
    try {
      for (int i = 0; i < validation.length; i++) {
        if (validation[i].validationRule.code == "=" &&
            questionCode != QuestionsCode.date) {
          if (int.parse(value) == int.parse(validation[i].valueOne)) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == ">") {
          if (int.parse(value) > int.parse(validation[i].valueOne)) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == "<") {
          if (int.parse(value) < int.parse(validation[i].valueOne)) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == ">=") {
          if (int.parse(value) >= int.parse(validation[i].valueOne)) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == "<=") {
          if (int.parse(value) <= int.parse(validation[i].valueOne)) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == "!=") {
          if (int.parse(value) != int.parse(validation[i].valueOne)) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == "REGX") {
          var regExp = RegExp(validation[i].valueOne);
          if (regExp.hasMatch(value)) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == "After") {
          if (DateTime.parse(value)
              .isAfter(DateTime.parse(validation[i].valueOne))) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == "Before") {
          if (DateTime.parse(value)
              .isBefore(DateTime.parse(validation[i].valueOne))) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == "=") {
          if (DateTime.parse(value)
              .isAtSameMomentAs(DateTime.parse(validation[i].valueOne))) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == "between") {
          if (DateTime.parse(value)
                  .isAfter(DateTime.parse(validation[i].valueOne)) &&
              DateTime.parse(value)
                  .isBefore(DateTime.parse(validation[i].valueTwo))) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        }
        if (!isAnswerValid) {
          break;
        }
      }
    } catch (e) {
      return {'isValid': true, 'validationMessage': ''};
    }

    return {
      'isValid': isAnswerValid,
      'validationMessage': validationMessage,
    };
  }
}
