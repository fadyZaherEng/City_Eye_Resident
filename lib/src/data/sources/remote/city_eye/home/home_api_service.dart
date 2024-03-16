import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_home_compound.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_notification_count.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_service.g.dart';

@RestApi()
abstract class GetHomeCompoundAPIService {
  factory GetHomeCompoundAPIService(Dio dio) = _GetHomeCompoundAPIService;

  @POST(APIKeys.getCompoundHome)
  Future<HttpResponse<CityEyeResponse<RemoteHomeCompound>>> getHomeCompound(
      @Body() CityEyeRequest request);

  @POST(APIKeys.getUserUnseenNotificationsCount)
  Future<HttpResponse<CityEyeResponse<RemoteNotificationCount>>> getUserUnseenNotificationsCount(
      @Body() CityEyeRequest request);
}
