import 'package:city_eye/src/core/utils/validation/contact_us_validator.dart';

class ValidateCountryUseCase {

  ContactUsItemsValidationState validateCountry(String country) {
    return ContactUsValidator.validateCountry(country);
  }

}