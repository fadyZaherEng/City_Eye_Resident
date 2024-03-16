import 'package:city_eye/src/domain/usecase/contact_us/validate_country_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/validate_email_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/validate_message_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/validate_mobile_number_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/validate_name_use_case.dart';

import '../../../core/utils/validation/contact_us_validator.dart';

class ContactUsValidationUseCase {

  final ValidateNameUseCase _validateNameUseCase;
  final ValidateEmailUseCase _validateEmailUseCase;
  final ValidateMobileNumberUseCase _validateMobileNumberUseCase;
  final ValidateCountryUseCase _validateCountryUseCase;
  final ValidateMessageUseCase _validateMessageUseCase;


  ContactUsValidationUseCase(
      this._validateNameUseCase,
      this._validateEmailUseCase,
      this._validateMobileNumberUseCase,
      this._validateCountryUseCase,
      this._validateMessageUseCase);

  List<ContactUsItemsValidationState> validateFormUseCase(
      {required String name,
      required String emailAddress,
      required String mobileNumber,
      required String country,
      required String message}) {
    List<ContactUsItemsValidationState> validations =
        List.empty(growable: true);

    ContactUsItemsValidationState validation;
    validation = _validateNameUseCase.validateName(name.trim());
    if (validation != ContactUsItemsValidationState.valid) {
      validations.add(validation);
    }

    validation = _validateEmailUseCase.validateEmailAddress(emailAddress.trim());
    if (validation != ContactUsItemsValidationState.valid) {
      validations.add(validation);
    }

    validation = _validateMobileNumberUseCase.validateMobileNumber(mobileNumber.trim());
    if (validation != ContactUsItemsValidationState.valid) {
      validations.add(validation);
    }

    validation = _validateCountryUseCase.validateCountry(country.trim());
    if (validation != ContactUsItemsValidationState.valid) {
      validations.add(validation);
    }

    validation = _validateMessageUseCase.validateMessage(message.trim());
    if (validation != ContactUsItemsValidationState.valid) {
      validations.add(validation);
    }

    return validations;
  }
}
