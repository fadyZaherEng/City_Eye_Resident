import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/home/notification_count.dart';
import 'package:city_eye/src/domain/repositories/home_repository.dart';

class GetNotificationsCountUseCase {
  final HomeRepository _homeRepository;

  GetNotificationsCountUseCase(this._homeRepository);

  Future<DataState<NotificationCount>> call() async {
    return await _homeRepository.getUserUnseenNotificationsCount();
  }
}