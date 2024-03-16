import 'package:city_eye/src/core/utils/validation/contact_us_validator.dart';

class ValidateEmailUseCase {

  ContactUsItemsValidationState validateEmailAddress(String email) {
    return ContactUsValidator.validateEmailAddress(email);
  }

}