import 'package:city_eye/src/core/utils/validation/delegated_steps_validator.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/usecase/delegated/authorized_widget/validate_authorized_mobile_number_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/authorized_widget/validate_authorized_name_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/validate_id_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/validate_image_selection_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/validate_questions_use_case.dart';

class AuthorizedWidgetValidationUseCase {
  final ValidateIdUseCase _validateIdUseCase;
  final ValidateAuthorizedNameUseCase _authorizedNameUseCase;
  final ValidateAuthorizedMobileNumberUseCase _authorizedMobileNumberUseCase;
  final ValidateImageSelectionUseCase _validateImageSelectionUseCase;
  final ValidateQuestionsUseCase _validateQuestionsUseCase;

  AuthorizedWidgetValidationUseCase(
      this._validateIdUseCase,
      this._authorizedNameUseCase,
      this._authorizedMobileNumberUseCase,
      this._validateImageSelectionUseCase,
      this._validateQuestionsUseCase);

  List<DelegatedStepsValidationState> validateAuthorizedWidgetFormUseCase(
      {required String name,
      required String id,
      required String mobileNumber,
      required String imagePath,
      required List<PageField> questions}) {
    List<DelegatedStepsValidationState> validations =
        List.empty(growable: true);

    DelegatedStepsValidationState validation;
    validation = _authorizedNameUseCase.validateName(name.trim());
    if (validation != DelegatedStepsValidationState.valid) {
      validations.add(validation);
    }

    validation = _validateIdUseCase.validateId(id.trim());
    if (validation != DelegatedStepsValidationState.valid) {
      validations.add(validation);
    }

    validation = _authorizedMobileNumberUseCase
        .validateMobileNumber(mobileNumber.trim());
    if (validation != DelegatedStepsValidationState.valid) {
      validations.add(validation);
    }

    validation =
        _validateImageSelectionUseCase.validateImageSelected(imagePath.trim());
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
