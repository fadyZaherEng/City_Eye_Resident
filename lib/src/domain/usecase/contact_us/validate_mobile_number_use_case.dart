import 'package:city_eye/src/core/utils/validation/contact_us_validator.dart';

class ValidateMobileNumberUseCase {

  ContactUsItemsValidationState validateMobileNumber(String phone) {
    return ContactUsValidator.validatePhoneNumber(phone);
  }

}