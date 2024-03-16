import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/update_user_unit_request.dart';
import 'package:city_eye/src/domain/repositories/profile_repository.dart';

class UpdateUserUnitUseCase {
  final ProfileRepository _profileRepository;

  UpdateUserUnitUseCase(this._profileRepository);

  Future<DataState> call(UpdateUserUnitRequest request) async {
    return await _profileRepository.updateUserUnit(request);
  }
}
