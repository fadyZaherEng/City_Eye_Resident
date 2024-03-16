import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/add_user_family_member_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/delete_request.dart';
import 'package:city_eye/src/domain/repositories/profile_repository.dart';

class DeleteUserFamilyMemberUseCase {
  final ProfileRepository _profileRepository;

  DeleteUserFamilyMemberUseCase(this._profileRepository);

  Future<DataState> call(DeleteRequest request) async {
    return await _profileRepository.deleteUserFamilyMember(request);
  }
}
