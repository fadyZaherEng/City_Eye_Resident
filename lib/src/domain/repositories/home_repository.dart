import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/home/home_compound.dart';
import 'package:city_eye/src/domain/entities/home/notification_count.dart';

abstract interface class HomeRepository {
  Future<DataState<HomeCompound>> getHomeCompound();

  Future<DataState<NotificationCount>> getUserUnseenNotificationsCount();
}
