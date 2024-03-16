import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/entity/remote_user.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/entity/remote_city_compound.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/entity/remote_compound_unit.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/entity/remote_edit_mobile_number.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/entity/remote_otp.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/compound_units_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/edit_mobile_number_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/request_otp_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/validate_mobile_number_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/verify_otp_request.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'register_api_service.g.dart';

@RestApi()
abstract class RegisterAPIService {
  factory RegisterAPIService(Dio dio) = _RegisterAPIService;

  @POST(APIKeys.register)
  @MultiPart()
  Future<HttpResponse<CityEyeResponse<RemoteOTP>>> register(
    @Part(name: 'requestHeader') String requestHeader,
    @Part(name: "Files") List<MultipartFile> files,
  );

  @POST(APIKeys.validateMobile)
  Future<HttpResponse<CityEyeResponse>> validateMobileNumber(
      @Body() CityEyeRequest<ValidateMobileNumberRequest> request);

  @POST(APIKeys.requestOTP)
  Future<HttpResponse<CityEyeResponse<RemoteOTP>>> requestOTP(
      @Body() CityEyeRequest<RequestOTPRequest> request);

  @POST(APIKeys.verifyOTP)
  Future<HttpResponse<CityEyeResponse<RemoteUser>>> verifyOTP(
      @Body() CityEyeRequest<VerifyOTPRequest> request);

  @POST(APIKeys.cityCompounds)
  Future<HttpResponse<CityEyeResponse<List<RemoteCityCompound>>>>
      getCityCompounds(@Body() CityEyeRequest request);

  @POST(APIKeys.compoundUnits)
  Future<HttpResponse<CityEyeResponse<List<RemoteCompoundUnit>>>>
      getCompoundUnits(@Body() CityEyeRequest<CompoundUnitsRequest> request);

  @POST(APIKeys.editMobileNumber)
  Future<HttpResponse<CityEyeResponse<RemoteEditMobileNumber>>> editMobileNumber(
      @Body() CityEyeRequest<EditMobileNumberRequest> request);
}
