import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/profile/profile.dart';
import 'package:city_eye/src/domain/repositories/profile_repository.dart';

class GetUserProfileUseCase {
  final ProfileRepository _profileRepository;

  GetUserProfileUseCase(this._profileRepository);

  Future<DataState<Profile>> call() async {
    return await _profileRepository.getProfile();
  }
}
