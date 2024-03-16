part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class ShowSkeletonState extends NotificationsState {}

class ShowLoadingState extends NotificationsState {}

class HideLoadingState extends NotificationsState {}

class NotificationsPopState extends NotificationsState {}

// ignore: must_be_immutable
class NotificationClickActionState extends NotificationsState {
  NotificationItem notificationItem;

  NotificationClickActionState(this.notificationItem);
}

class SuccessFetchNotificationsDataState extends NotificationsState {
  final List<NotificationItem> notifications;

  SuccessFetchNotificationsDataState({required this.notifications});
}

class FailedFetchNotificationsDataState extends NotificationsState {
  final String errorMessage;

  FailedFetchNotificationsDataState({required this.errorMessage});
}

class ScrollToItemState extends NotificationsState {
  final GlobalKey key;

  ScrollToItemState({required this.key});
}

class UpdateNotificationSeenSuccessState extends NotificationsState {
  final String message;
  final NotificationItem notificationItem;

  UpdateNotificationSeenSuccessState(this.message, this.notificationItem);
}

class UpdateNotificationSeenFailedState extends NotificationsState {
  final String errorMessage;
  final NotificationItem notificationItem;

  UpdateNotificationSeenFailedState(this.errorMessage, this.notificationItem);
}
