import 'package:city_eye/src/core/utils/validation/register.dart';

class RegisterValidationUseCase {
  List<RegisterValidationState> validateProfileFormUseCase({
    required String fullName,
    required String mobileNumber,
    required String emailAddress,
    required String password,
  }) {
    List<RegisterValidationState> validations = List.empty(growable: true);
    RegisterValidationState validation;
    validation = validateFullName(fullName.trim());
    if (validation != RegisterValidationState.valid) {
      validations.add(
        validation,
      );
    }

    validation = validateMobileNumber(mobileNumber.trim());
    if (validation != RegisterValidationState.valid) {
      validations.add(validation);
    }
    validation = validatePassword(password);
    if (validation != RegisterValidationState.valid) {
      validations.add(validation);
    }

    validation = validateEmailAddress(emailAddress.trim());
    if (validation != RegisterValidationState.valid) {
      validations.add(validation);
    }
    return validations;
  }

  List<RegisterValidationState> validateCompoundFormUseCase({
    required String compoundName,
    required String unitNumber,
  }) {
    List<RegisterValidationState> validations = List.empty(growable: true);
    RegisterValidationState validation;
    validation = validateCompoundName(compoundName.trim());
    if (validation != RegisterValidationState.valid) {
      validations.add(
        validation,
      );
    }

    validation = validateUnitNumber(unitNumber.trim());
    if (validation != RegisterValidationState.valid) {
      validations.add(validation);
    }

    return validations;
  }

  RegisterValidationState validateFullName(String fullName) {
    return RegisterValidator.validateFullName(
      fullName,
    );
  }

  RegisterValidationState validateMobileNumber(String mobileNumber) {
    return RegisterValidator.validateMobileNumber(
      mobileNumber,
    );
  }

  RegisterValidationState validateEmailAddress(String emailAddress) {
    return RegisterValidator.validateEmailAddress(
      emailAddress,
    );
  }

  RegisterValidationState validateCompoundName(String compoundName) {
    return RegisterValidator.validateCompoundName(
      compoundName,
    );
  }

  RegisterValidationState validateUnitNumber(String unitNumber) {
    return RegisterValidator.validateUnitNumber(
      unitNumber,
    );
  }

  RegisterValidationState validatePassword(String password) {
    return RegisterValidator.validatePassword(
      password,
    );
  }
}
