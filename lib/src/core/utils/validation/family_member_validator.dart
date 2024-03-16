import 'package:city_eye/src/domain/entities/profile/family_member_type.dart';

class FamilyMemberValidator {
  static FamilyMemberValidationState validateName(String name) {
    if (name.isEmpty) {
      return FamilyMemberValidationState.nameEmpty;
    } else {
      List<String> words = name.trim().split(' ');
      if (words.length < 2 || words.any((word) => word.length < 2)) {
        return FamilyMemberValidationState.invalidName;
      } else {
        return FamilyMemberValidationState.valid;
      }
    }
  }


  static FamilyMemberValidationState validateMobileNumber(String mobileNumber) {
    if (mobileNumber.isEmpty) {
      return FamilyMemberValidationState.invalidMobileNumber;
    } else {
      return FamilyMemberValidationState.valid;
    }
  }

  static FamilyMemberValidationState validateFamilyMemberType(List<FamilyMemberType> familyMemberType) {
    bool isValid = false;
    for(var index = 0; index < familyMemberType.length; index++) {
      if(familyMemberType[index].isSelected) {
        isValid = true;
        break;
      }
    }
    if (!isValid) {
      return FamilyMemberValidationState.invalidFamilyMemberType;
    } else {
      return FamilyMemberValidationState.valid;
    }
  }

  static FamilyMemberValidationState validateImageSelection(String imagePath) {
    if (imagePath.isEmpty) {
      return FamilyMemberValidationState.invalidImage;
    } else {
      return FamilyMemberValidationState.valid;
    }
  }

  static FamilyMemberValidationState validateEmailAddress(String emailAddress) {
    if (emailAddress.isEmpty) {
      return FamilyMemberValidationState.emailAddressEmpty;
    } else if (!isValidEmailFormat(emailAddress)) {
      return FamilyMemberValidationState.emailFormat;
    } else {
      return FamilyMemberValidationState.valid;
    }
  }

  static bool isValidEmailFormat(String email) {
    const emailRegex = r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
    final regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }
}

enum FamilyMemberValidationState {
  nameEmpty,
  invalidName,
  invalidMobileNumber,
  invalidFamilyMemberType,
  valid,
  emailAddressEmpty,
  emailFormat,
  invalidImage,
}
