import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/add_user_family_member_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/delete_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/profile_document_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/update_info_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/update_user_family_member_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/update_user_unit_request.dart';
import 'package:city_eye/src/domain/entities/profile/family_member.dart';
import 'package:city_eye/src/domain/entities/profile/family_member_invitation.dart';
import 'package:city_eye/src/domain/entities/profile/profile.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/user_unit_car_request.dart';
import 'package:city_eye/src/domain/entities/profile/profile_image.dart';

abstract class ProfileRepository {
  Future<DataState<Profile>> getProfile();

  Future<DataState<ProfileImage>> updateUserImage(String imagePath);

  Future<DataState<Profile>> updateUserInfo(UpdateInfoRequest updateInfoRequest);

  Future<DataState> updateUserDocuments(
      List<ProfileDocumentRequest> profileDocumentRequest);

  Future<DataState<FamilyMemberInvitation>> addUserFamilyMember(
      AddUserFamilyMemberRequest addUserFamilyMemberRequest,String imagePath);

  Future<DataState> updateUserFamilyMember(
      UpdateUserFamilyMemberRequest updateUserFamilyMemberRequest,String imagePath);

  Future<DataState> deleteUserFamilyMember(DeleteRequest deleteRequest);

  Future<DataState> updateUserUnit(UpdateUserUnitRequest updateUserUnitRequest);

  Future<DataState> addUserUnitCar(UserUnitCarRequest addUserUnitCarRequest);

  Future<DataState> updateUserUnitCar(
      UserUnitCarRequest updateUserUnitCarRequest);

  Future<DataState> deleteUserUnitCar(DeleteRequest deleteUserUnitCarRequest);

}
