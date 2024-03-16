import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/reset_password/entity/remote_reset_password.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'reset_password_services.g.dart';

@RestApi()
abstract class ResetPasswordService {
  factory ResetPasswordService(Dio dio) = _ResetPasswordService;

  @POST(APIKeys.invitationResetPassword)
  Future<HttpResponse<CityEyeResponse<RemoteResetPassword>>> invitationResetPassword(
    @Body() CityEyeRequest request,
  );
}
