import 'package:city_eye/src/core/utils/validation/profile_info_validator.dart';
import 'package:city_eye/src/domain/entities/profile/info.dart';

class ProfileInfoFormValidationUseCase {
  List<ProfileInfoValidationState> call(Info info) {
    List<ProfileInfoValidationState> validations = List.empty(growable: true);

    ProfileInfoValidationState validation = validateName(info.name);
    if (validation != ProfileInfoValidationState.valid) {
      validations.add(
        validation,
      );
    }

    validation = validateEmailAddress(info.email);
    if (validation != ProfileInfoValidationState.valid) {
      validations.add(validation);
    }

    return validations;
  }

  ProfileInfoValidationState validateName(String name) {
    return ProfileInfoValidator.validateName(
      name,
    );
  }

  ProfileInfoValidationState validateEmailAddress(String emailAddress) {
    return ProfileInfoValidator.validateEmailAddress(
      emailAddress,
    );
  }
}
