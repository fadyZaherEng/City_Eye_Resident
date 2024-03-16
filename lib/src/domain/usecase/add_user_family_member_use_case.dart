import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/add_user_family_member_request.dart';
import 'package:city_eye/src/domain/entities/profile/family_member.dart';
import 'package:city_eye/src/domain/entities/profile/family_member_invitation.dart';
import 'package:city_eye/src/domain/repositories/profile_repository.dart';

class AddUserFamilyMemberUseCase {
  final ProfileRepository _profileRepository;

  AddUserFamilyMemberUseCase(this._profileRepository);

  Future<DataState<FamilyMemberInvitation>> call(AddUserFamilyMemberRequest request,String imagePath) async {
    return await _profileRepository.addUserFamilyMember(request,imagePath);
  }
}
