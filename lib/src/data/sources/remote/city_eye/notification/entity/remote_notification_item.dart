import 'package:city_eye/src/data/sources/remote/city_eye/notification/entity/remote_notification_priority.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/notification/entity/remote_notification_source.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/notification/entity/remote_notification_type.dart';
import 'package:city_eye/src/domain/entities/notification/notification_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_notification_item.g.dart';

@JsonSerializable(explicitToJson: true)
final class RemoteNotificationItem {
  final int? id;
  final String? notificationId;
  final String? title;
  final String? body;
  final String? createDate;
  final String? attachment;
  final bool? isSeen;
  final String? targetId;
  final RemoteNotificationType? notificationType;
  final RemoteNotificationPriority? notificationPriority;
  final RemoteNotificationSource? notificationSource;

  const RemoteNotificationItem({
    this.id = 0,
    this.notificationId = "",
    this.title = "",
    this.body = "",
    this.createDate = "",
    this.attachment = "",
    this.isSeen = false,
    this.targetId = "",
    this.notificationType = const RemoteNotificationType(),
    this.notificationPriority = const RemoteNotificationPriority(),
    this.notificationSource = const RemoteNotificationSource(),
  });

  factory RemoteNotificationItem.fromJson(Map<String, dynamic> json) =>
      _$RemoteNotificationItemFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteNotificationItemToJson(this);
}

extension RemoteNotificationItemExtension on RemoteNotificationItem {
  NotificationItem mapToDomain() => NotificationItem(
        id: id ?? 0,
        notificationId: notificationId ?? "",
        title: title ?? "",
        body: body ?? "",
        createDate: createDate ?? "",
        attachment: attachment ?? "",
        isSeen: isSeen ?? false,
        targetId: targetId ?? "",
        notificationType: (notificationType ?? const RemoteNotificationType()).mapToDomain(),
        notificationPriority: (notificationPriority ?? const RemoteNotificationPriority()).mapToDomain(),
        notificationSource: (notificationSource ?? const RemoteNotificationSource()).mapToDomain(),
      );
}

extension RemoteNotificationItemListExtension on List<RemoteNotificationItem>? {
  List<NotificationItem> mapToDomain() =>
      this!.map((notification) => notification.mapToDomain()).toList();
}
