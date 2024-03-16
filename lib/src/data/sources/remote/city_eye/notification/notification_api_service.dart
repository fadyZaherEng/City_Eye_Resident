import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/notification/entity/remote_notification_item.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/notification/request/notification_details_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/notification/request/notification_seen_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'notification_api_service.g.dart';

@RestApi()
abstract class NotificationApiService {
  factory NotificationApiService(Dio dio) = _NotificationApiService;

  @POST(APIKeys.notifications)
  Future<HttpResponse<CityEyeResponse<List<RemoteNotificationItem>>>>
      getNotifications(@Body() CityEyeRequest request);

  @POST(APIKeys.notificationDetail)
  Future<HttpResponse<CityEyeResponse<RemoteNotificationItem>>>
      getNotificationById(
    @Body() CityEyeRequest<NotificationDetailsRequest> request,
  );

  @POST(APIKeys.updateNotificationAsSeen)
  Future<HttpResponse<CityEyeResponse>> updateNotificationAsSeen(
    @Body() CityEyeRequest<NotificationSeenRequest> request,
  );
}
