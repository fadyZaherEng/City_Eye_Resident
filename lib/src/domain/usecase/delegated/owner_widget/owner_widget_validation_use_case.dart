import 'package:city_eye/src/core/utils/validation/delegated_steps_validator.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/validate_date_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/validate_id_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/validate_image_selection_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/validate_owner_message_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/validate_questions_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/validate_signature_use_case.dart';

class OwnerWidgetValidationUseCase {
  final ValidateOwnerMessageUseCase _validateMessageUseCase;
  final ValidateIdUseCase _validateIdUseCase;
  final ValidateDateUseCase _validateDateUseCase;
  final ValidateImageSelectionUseCase _validateImageSelectionUseCase;
  final ValidateSignatureUseCase _validateSignatureUseCase;
  final ValidateQuestionsUseCase _validateQuestionsUseCase;

  OwnerWidgetValidationUseCase(
    this._validateMessageUseCase,
    this._validateIdUseCase,
    this._validateDateUseCase,
    this._validateImageSelectionUseCase,
    this._validateSignatureUseCase,
    this._validateQuestionsUseCase,
  );

  List<DelegatedStepsValidationState> validateOwnerWidgetFormUseCase(
      {required String message,
      required String id,
      required String dateFrom,
      required String dateTo,
      required String imagePath,
      required String signature,
      required List<PageField> questions}) {
    List<DelegatedStepsValidationState> validations =
        List.empty(growable: true);

    DelegatedStepsValidationState validation;
    validation =
        _validateMessageUseCase.validateMessage(message.trim());
    if (validation != DelegatedStepsValidationState.valid) {
      validations.add(validation);
    }

    validation = _validateIdUseCase.validateId(id.trim());
    if (validation != DelegatedStepsValidationState.valid) {
      validations.add(validation);
    }

    validation = _validateDateUseCase.validateDate(dateFrom.trim());
    if (validation != DelegatedStepsValidationState.valid) {
      validations.add(validation);
    }

    validation = _validateDateUseCase.validateDate(dateTo.trim());
    if (validation != DelegatedStepsValidationState.valid) {
      validations.add(validation);
    }

    validation =
        _validateImageSelectionUseCase.validateImageSelected(imagePath.trim());
    if (validation != DelegatedStepsValidationState.valid) {
      validations.add(validation);
    }

    validation =
        _validateSignatureUseCase.validateSignatureCaptured(signature);
    if (validation != DelegatedStepsValidationState.valid) {
      validations.add(validation);
    }
    validation =
        _validateQuestionsUseCase.validateMandatoryQuestions(questions);
    if (validation != DelegatedStepsValidationState.valid) {
      validations.add(validation);
    }

    return validations;
  }
}
