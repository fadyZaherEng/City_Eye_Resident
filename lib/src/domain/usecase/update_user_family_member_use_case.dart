import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/add_user_family_member_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/update_user_family_member_request.dart';
import 'package:city_eye/src/domain/repositories/profile_repository.dart';

class UpdateUserFamilyMemberUseCase {
  final ProfileRepository _profileRepository;

  UpdateUserFamilyMemberUseCase(this._profileRepository);

  Future<DataState> call(UpdateUserFamilyMemberRequest request,String imagePath) async {
    return await _profileRepository.updateUserFamilyMember(request,imagePath);
  }
}
