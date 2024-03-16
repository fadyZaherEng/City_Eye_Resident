import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/profile/profile_image.dart';
import 'package:city_eye/src/domain/repositories/profile_repository.dart';

class UpdateUserImageUseCase {
  final ProfileRepository _profileRepository;

  UpdateUserImageUseCase(this._profileRepository);

  Future<DataState<ProfileImage>> call(String image) async {
    return await _profileRepository.updateUserImage(image);
  }
}