import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/landing/entity/remote_landing.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'landing_api_service.g.dart';

@RestApi()
abstract class LandingAPIService {
  factory LandingAPIService(Dio dio) = _LandingAPIService;

  @POST(APIKeys.landing)
  Future<HttpResponse<CityEyeResponse<RemoteLanding>>> getLanding(
      @Body() CityEyeRequest request);
}
