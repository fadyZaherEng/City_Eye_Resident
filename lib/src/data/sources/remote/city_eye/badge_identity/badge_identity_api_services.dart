import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/badge_identity/entity/remote_badge_identity.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'badge_identity_api_services.g.dart';

@RestApi()
abstract class BadgeIdentityApiServices {
  factory BadgeIdentityApiServices(Dio dio) = _BadgeIdentityApiServices;

  @POST(APIKeys.getBadgeIdentity)
  Future<HttpResponse<CityEyeResponse<RemoteBadgeIdentity>>> getBadgeIdentity(
      @Body() CityEyeRequest request);
}
