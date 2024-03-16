import 'package:city_eye/src/core/utils/validator.dart';

class ContactUsValidator {
  static ContactUsItemsValidationState validateName(String name) {
    if (name.isEmpty) {
      return ContactUsItemsValidationState.nameEmpty;
    } else if (!Validator.isFullNameValid(name)) {
      return ContactUsItemsValidationState.nameInvalid;
    } else {
      return ContactUsItemsValidationState.valid;
    }
  }

  static ContactUsItemsValidationState validateEmailAddress(
      String emailAddress) {
    if (emailAddress.isEmpty) {
      return ContactUsItemsValidationState.emailEmpty;
    } else if (!Validator.isEmailValid(emailAddress)) {
      return ContactUsItemsValidationState.emailInvalid;
    } else {
      return ContactUsItemsValidationState.valid;
    }
  }

  static ContactUsItemsValidationState validatePhoneNumber(
      String mobileNumber) {
    if (mobileNumber.isEmpty) {
      return ContactUsItemsValidationState.mobileNumberEmpty;
    }else {
      return ContactUsItemsValidationState.valid;
    }
  }

  static ContactUsItemsValidationState validateCountry(String countryCode) {
    if (countryCode.isEmpty) {
      return ContactUsItemsValidationState.countryEmpty;
    } else {
      return ContactUsItemsValidationState.valid;
    }
  }

  static ContactUsItemsValidationState validateMessage(String message) {
    if (message.isEmpty) {
      return ContactUsItemsValidationState.messageEmpty;
    } /*else if (message.length < 30) {
      return ContactUsItemsValidationState.messageInvalid;
    }*/ else {
      return ContactUsItemsValidationState.valid;
    }
  }

}

enum ContactUsItemsValidationState {
  nameEmpty,
  nameInvalid,
  emailEmpty,
  emailInvalid,
  mobileNumberEmpty,
  mobileNumberInvalid,
  countryEmpty,
  countryInvalid,
  messageEmpty,
  messageInvalid,
  valid,
}
