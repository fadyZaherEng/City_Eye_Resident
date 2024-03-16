part of 'notification_details_bloc.dart';

@immutable
abstract class NotificationDetailsState {}

class NotificationDetailsInitial extends NotificationDetailsState {}

class ShowSkeletonState extends NotificationDetailsState {}

class HideSkeletonState extends NotificationDetailsState {}

class BackState extends NotificationDetailsState {}

class SuccessGetNotificationDetailsDataState extends NotificationDetailsState {
  final NotificationItem notificationItem;

  SuccessGetNotificationDetailsDataState(this.notificationItem);
}

class FailedNotificationDetailsDataState extends NotificationDetailsState {
  final String errorMessage;

  FailedNotificationDetailsDataState(this.errorMessage);
}

class SetLocalNotificationDetailsDataState extends NotificationDetailsState {
  final NotificationItem localNotificationItem;

  SetLocalNotificationDetailsDataState(this.localNotificationItem);
}
