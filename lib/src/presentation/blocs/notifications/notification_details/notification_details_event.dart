part of 'notification_details_bloc.dart';

@immutable
abstract class NotificationDetailsEvent {}

class BackEvent extends NotificationDetailsEvent {}

class ShowSkeletonEvent extends NotificationDetailsEvent {}

class HideSkeletonEvent extends NotificationDetailsEvent {}

class GetRemoteNotificationDetailsDataEvent extends NotificationDetailsEvent {
  final int id;

  GetRemoteNotificationDetailsDataEvent({
    required this.id,
  });
}

class SetLocalNotificationDetailsDataEvent extends NotificationDetailsEvent {
  final NotificationItem localNotificationDetails;

  SetLocalNotificationDetailsDataEvent(
      {required this.localNotificationDetails});
}

