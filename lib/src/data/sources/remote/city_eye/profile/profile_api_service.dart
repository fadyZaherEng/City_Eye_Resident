import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_family_member.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_car.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_family_member_invitation.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_profile_image.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/add_user_family_member_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/delete_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/update_user_family_member_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/update_user_unit_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_profile.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/user_unit_car_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api_service.g.dart';

@RestApi()
abstract class ProfileAPIService {
  factory ProfileAPIService(Dio dio) = _ProfileAPIService;

  @POST(APIKeys.addUserFamilyMember)
  @MultiPart()
  Future<HttpResponse<CityEyeResponse<RemoteFamilyMemberInvitation>>>
      requestAddUserFamilyMember(
    @Part(name: 'requestHeader') String requestHeader,
    @Part(name: "file") List<MultipartFile> files,
  );

  @POST(APIKeys.updateUserDocuments)
  @MultiPart()
  Future<HttpResponse<CityEyeResponse>> updateUserDocuments(
    @Part(name: 'requestHeader') String requestHeader,
    @Part(name: "Files") List<MultipartFile> files,
  );

  @POST(APIKeys.updateUserImage)
  @MultiPart()
  Future<HttpResponse<CityEyeResponse<RemoteProfileImage>>> updateUserImage(
    @Part(name: 'requestHeader') String requestHeader,
    @Part(name: "imageUser") List<MultipartFile> files,
  );

  @POST(APIKeys.updateUserInfo)
  @MultiPart()
  Future<HttpResponse<CityEyeResponse>> updateUserInfo(
    @Part(name: 'requestHeader') String requestHeader,
    @Part(name: "Files") List<MultipartFile> files,
  );

  @POST(APIKeys.updateUserFamilyMember)
  Future<HttpResponse<CityEyeResponse<List<RemoteFamilyMember>>>>
      requestUpdateUserFamilyMember(
    @Part(name: 'requestHeader') String requestHeader,
    @Part(name: "file") List<MultipartFile> files,
  );

  @POST(APIKeys.deleteUserFamilyMember)
  Future<HttpResponse<CityEyeResponse>> deleteUserFamilyMember(
      @Body() CityEyeRequest<DeleteRequest> request);

  @POST(APIKeys.updateUserUnit)
  Future<HttpResponse<CityEyeResponse>> updateUserUnit(
      @Body() CityEyeRequest<UpdateUserUnitRequest> request);

  @POST(APIKeys.userProfile)
  Future<HttpResponse<CityEyeResponse<RemoteProfile>>> getProfile(
      @Body() CityEyeRequest request);

  @POST(APIKeys.addUserCar)
  Future<HttpResponse<CityEyeResponse<List<RemoteCar>>>> addUserUnitCar(
      @Body() CityEyeRequest<UserUnitCarRequest> addUserUnitCarRequest);

  @POST(APIKeys.updateUserCar)
  Future<HttpResponse<CityEyeResponse<List<RemoteCar>>>> updateUserUnitCar(
      @Body() CityEyeRequest<UserUnitCarRequest> updateUserUnitCarRequest);

  @POST(APIKeys.deleteUserCar)
  Future<HttpResponse<CityEyeResponse>> deleteUserUnitCar(
      @Body() CityEyeRequest<DeleteRequest> deleteUserUnitCarRequest);
}
