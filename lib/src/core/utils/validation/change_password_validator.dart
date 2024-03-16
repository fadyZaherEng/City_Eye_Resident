class ChangePasswordValidator {
  static ChangePasswordValidationState validateOldPassword(String oldPassword) {
    if (oldPassword.isEmpty) {
      return ChangePasswordValidationState.oldPasswordEmpty;
    } else {
      return ChangePasswordValidationState.valid;
    }
  }

  static ChangePasswordValidationState validateNewPassword(String newPassword) {
    if (newPassword.isEmpty) {
      return ChangePasswordValidationState.newPasswordEmpty;
    } else if (newPassword.length <= 5) {
      return ChangePasswordValidationState.newPasswordMustBeSixCharacter;
    } else {
      return ChangePasswordValidationState.valid;
    }
  }

  static ChangePasswordValidationState validateConfirmPassword(
      String newPassword, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return ChangePasswordValidationState.confirmPasswordEmpty;
    } else if (newPassword != confirmPassword) {
      return ChangePasswordValidationState.confirmPasswordNotMatchNewPassword;
    } else {
      return ChangePasswordValidationState.valid;
    }
  }
}

enum ChangePasswordValidationState {
  oldPasswordEmpty,
  newPasswordEmpty,
  newPasswordMustBeSixCharacter,
  confirmPasswordEmpty,
  confirmPasswordNotMatchNewPassword,
  valid,
}
