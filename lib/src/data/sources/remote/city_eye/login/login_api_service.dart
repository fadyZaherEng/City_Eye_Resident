import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/entity/remote_user.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/request/change_password_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/request/forgot_password_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/request/login_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';


part 'login_api_service.g.dart';

@RestApi()
abstract class LoginAPIService {
  factory LoginAPIService(Dio dio) = _LoginAPIService;

  @POST(APIKeys.login)
  Future<HttpResponse<CityEyeResponse<RemoteUser>>> login(
      @Body() CityEyeRequest<LoginRequest> request);

  @POST(APIKeys.forgotPassword)
  Future<HttpResponse<CityEyeResponse>> forgotPassword(
      @Body() CityEyeRequest<ForgotPasswordRequest> request);


  @POST(APIKeys.changePassword)
  Future<HttpResponse<CityEyeResponse>> changePassword(
      @Body() CityEyeRequest<ChangePasswordRequest> request);

}
