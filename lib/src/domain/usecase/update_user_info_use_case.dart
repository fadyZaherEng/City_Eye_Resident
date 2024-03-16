import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/profile_document_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/update_info_request.dart';
import 'package:city_eye/src/domain/repositories/profile_repository.dart';

class UpdateUserInfoUseCase {
  final ProfileRepository _profileRepository;

  UpdateUserInfoUseCase(this._profileRepository);

  Future<DataState> call(UpdateInfoRequest request) async {
    return await _profileRepository.updateUserInfo(request);
  }
}