// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_notification_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteNotificationItem _$RemoteNotificationItemFromJson(
        Map<String, dynamic> json) =>
    RemoteNotificationItem(
      id: json['id'] as int? ?? 0,
      notificationId: json['notificationId'] as String? ?? "",
      title: json['title'] as String? ?? "",
      body: json['body'] as String? ?? "",
      createDate: json['createDate'] as String? ?? "",
      attachment: json['attachment'] as String? ?? "",
      isSeen: json['isSeen'] as bool? ?? false,
      targetId: json['targetId'] as String? ?? "",
      notificationType: json['notificationType'] == null
          ? const RemoteNotificationType()
          : RemoteNotificationType.fromJson(
              json['notificationType'] as Map<String, dynamic>),
      notificationPriority: json['notificationPriority'] == null
          ? const RemoteNotificationPriority()
          : RemoteNotificationPriority.fromJson(
              json['notificationPriority'] as Map<String, dynamic>),
      notificationSource: json['notificationSource'] == null
          ? const RemoteNotificationSource()
          : RemoteNotificationSource.fromJson(
              json['notificationSource'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteNotificationItemToJson(
        RemoteNotificationItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'notificationId': instance.notificationId,
      'title': instance.title,
      'body': instance.body,
      'createDate': instance.createDate,
      'attachment': instance.attachment,
      'isSeen': instance.isSeen,
      'targetId': instance.targetId,
      'notificationType': instance.notificationType?.toJson(),
      'notificationPriority': instance.notificationPriority?.toJson(),
      'notificationSource': instance.notificationSource?.toJson(),
    };
