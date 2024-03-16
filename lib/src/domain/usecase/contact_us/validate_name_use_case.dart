import 'package:city_eye/src/core/utils/validation/contact_us_validator.dart';

class ValidateNameUseCase {

  ContactUsItemsValidationState validateName(String name) {
    return ContactUsValidator.validateName(name);
  }

}