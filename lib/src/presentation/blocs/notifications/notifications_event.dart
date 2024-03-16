part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsEvent {}

class GetNotificationsDataEvent extends NotificationsEvent {}

class NotificationsPopEvent extends NotificationsEvent {}

// ignore: must_be_immutable
class NotificationClickActionEvent extends NotificationsEvent {
  NotificationItem notificationItem;

  NotificationClickActionEvent(this.notificationItem);
}

class ScrollToItemEvent extends NotificationsEvent {
  final GlobalKey key;

  ScrollToItemEvent({required this.key});
}

class UpdateNotificationSeenEvent extends NotificationsEvent {
  final NotificationItem notificationItem;

  UpdateNotificationSeenEvent({required this.notificationItem});
}
