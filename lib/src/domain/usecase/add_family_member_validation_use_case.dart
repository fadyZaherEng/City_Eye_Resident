import 'package:city_eye/src/core/utils/validation/family_member_validator.dart';
import 'package:city_eye/src/domain/entities/profile/family_member_type.dart';

class AddFamilyMemberValidationUseCase {
  List<FamilyMemberValidationState> validateAddFamilyMemberFormUseCase({
    required String name,
    required String mobileNumber,
    required List<FamilyMemberType> familyMemberTypes,
    required String emailAddress,
    required String imagePath,
  }) {
    List<FamilyMemberValidationState> validations = List.empty(growable: true);
    FamilyMemberValidationState validation;
    validation = validateName(name);
    if (validation != FamilyMemberValidationState.valid) {
      validations.add(
        validation,
      );
    }

    validation = validateMobileNumber(mobileNumber);
    if (validation != FamilyMemberValidationState.valid) {
      validations.add(validation);
    }

    validation = validateFamilyMemberType(familyMemberTypes);
    if (validation != FamilyMemberValidationState.valid) {
      validations.add(validation);
    }

    validation = validateEmailAddress(emailAddress);
    if (validation != FamilyMemberValidationState.valid) {
      validations.add(validation);
    }

    validation = validateImageSelection(imagePath);
    if (validation != FamilyMemberValidationState.valid) {
      validations.add(validation);
    }


    return validations;
  }

  FamilyMemberValidationState validateName(String name) {
    return FamilyMemberValidator.validateName(
      name,
    );
  }

  FamilyMemberValidationState validateMobileNumber(String mobileNumber) {
    return FamilyMemberValidator.validateMobileNumber(
      mobileNumber,
    );
  }

  FamilyMemberValidationState validateFamilyMemberType(List<FamilyMemberType> familyMemberTypes) {
    return FamilyMemberValidator.validateFamilyMemberType(
      familyMemberTypes,
    );
  }

  FamilyMemberValidationState validateEmailAddress(String emailAddress) {
    return FamilyMemberValidator.validateEmailAddress(
      emailAddress,
    );
  }

  FamilyMemberValidationState validateImageSelection(String imagePath) {
    return FamilyMemberValidator.validateImageSelection(
      imagePath,
    );
  }

}
