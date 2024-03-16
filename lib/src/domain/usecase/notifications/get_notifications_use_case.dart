import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/notification/notification_item.dart';
import 'package:city_eye/src/domain/repositories/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository _notificationRepository;

  GetNotificationsUseCase(this._notificationRepository);

  Future<DataState<List<NotificationItem>>> call() async =>
      await _notificationRepository.getNotifications();
}
