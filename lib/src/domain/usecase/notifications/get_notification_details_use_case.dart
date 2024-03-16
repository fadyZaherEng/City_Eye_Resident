import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/notification/request/notification_details_request.dart';
import 'package:city_eye/src/domain/entities/notification/notification_item.dart';
import 'package:city_eye/src/domain/repositories/notification_repository.dart';

class GetNotificationDetailsUseCase {
  final NotificationRepository _notificationRepository;

  GetNotificationDetailsUseCase(this._notificationRepository);

  Future<DataState<NotificationItem>> call(
          NotificationDetailsRequest request) async =>
      await _notificationRepository.getNotificationDetails(request);
}
