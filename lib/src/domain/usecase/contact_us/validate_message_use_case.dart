import 'package:city_eye/src/core/utils/validation/contact_us_validator.dart';

class ValidateMessageUseCase {

  ContactUsItemsValidationState validateMessage(String message) {
    return ContactUsValidator.validateMessage(message);
  }

}