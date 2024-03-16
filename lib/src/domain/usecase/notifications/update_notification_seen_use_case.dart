import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/notification/request/notification_seen_request.dart';
import 'package:city_eye/src/domain/repositories/notification_repository.dart';

class UpdateNotificationSeenUseCase {
  final NotificationRepository _notificationRepository;

  UpdateNotificationSeenUseCase(this._notificationRepository);

  Future<DataState> call(
          NotificationSeenRequest notificationSeenRequest) async =>
      await _notificationRepository
          .updateNotificationAsSeen(notificationSeenRequest);
}
