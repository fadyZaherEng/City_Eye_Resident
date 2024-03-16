class RegisterValidator {
  static RegisterValidationState validateCompoundName(String compoundName) {
    if (compoundName.isEmpty) {
      return RegisterValidationState.compoundNameEmpty;
    } else {
      return RegisterValidationState.valid;
    }
  }

  static RegisterValidationState validateUnitNumber(String unitNumber) {
    if (unitNumber.isEmpty) {
      return RegisterValidationState.unitNoEmpty;
    } else {
      return RegisterValidationState.valid;
    }
  }

  static RegisterValidationState validateFullName(String fullName) {
    if (fullName.isEmpty) {
      return RegisterValidationState.fullNameEmpty;
    } else {
      List<String> words = fullName.trim().split(' ');

      // if (!isEnglishName(fullName)) {
      if (false) {
        return RegisterValidationState.isNotEnglishName;
      } else if (words.length < 2 || words.any((word) => word.length < 2)) {
        return RegisterValidationState.invalidFullName;
      } else {
        return RegisterValidationState.valid;
      }
    }
  }

  static bool isEnglishName(String fullName) {
    final RegExp englishLetters = RegExp(r'^[a-zA-Z\s]+$');
    return englishLetters.hasMatch(fullName);
  }

  static RegisterValidationState validateEmailAddress(String emailAddress) {
    if (emailAddress.isEmpty) {
      return RegisterValidationState.emailAddressEmpty;
    } else if (!isValidEmailFormat(emailAddress)) {
      return RegisterValidationState.format;
    } else {
      return RegisterValidationState.valid;
    }
  }

  static RegisterValidationState validateMobileNumber(String mobileNumber) {
    if (mobileNumber.isEmpty) {
      return RegisterValidationState.mobileNumberEmpty;
    } else {
      return RegisterValidationState.valid;
    }
  }

  static RegisterValidationState validateType(int type) {
    if (type == 0) {
      return RegisterValidationState.type;
    } else {
      return RegisterValidationState.valid;
    }
  }

  static RegisterValidationState validatePassword(String password) {
    if (password.isEmpty) {
      return RegisterValidationState.passwordEmpty;
    } else if (password.length < 6) {
      return RegisterValidationState.format;
    } else {
      return RegisterValidationState.valid;
    }
  }

  static bool isValidEmailFormat(String email) {
    const emailRegex = r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
    final regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }
}

enum RegisterValidationState {
  compoundNameEmpty,
  unitNoEmpty,
  fullNameEmpty,
  invalidFullName,
  isNotEnglishName,
  emailAddressEmpty,
  format,
  mobileNumberEmpty,
  mobileNumberIvalid,
  type,
  valid,
  passwordEmpty,
}
