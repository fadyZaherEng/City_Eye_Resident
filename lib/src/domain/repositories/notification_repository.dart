import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/notification/request/notification_details_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/notification/request/notification_seen_request.dart';
import 'package:city_eye/src/domain/entities/notification/notification_item.dart';

abstract interface class NotificationRepository {
  Future<DataState<List<NotificationItem>>> getNotifications();

  Future<DataState<NotificationItem>> getNotificationDetails(
      NotificationDetailsRequest request);

  Future<DataState> updateNotificationAsSeen(NotificationSeenRequest notificationSeenRequest);
}
