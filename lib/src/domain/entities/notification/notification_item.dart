import 'package:city_eye/src/domain/entities/notification/notification_priority.dart';
import 'package:city_eye/src/domain/entities/notification/notification_source.dart';
import 'package:city_eye/src/domain/entities/notification/notification_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class NotificationItem extends Equatable {
  final int id;
  final String notificationId;
  final String title;
  final String body;
  final String createDate;
  final String attachment;
  final bool isSeen;
  final String targetId;
  final NotificationType notificationType;
  final NotificationPriority notificationPriority;
  final NotificationSource notificationSource;
  final GlobalKey? key;

  const NotificationItem({
    this.id = 0,
    this.notificationId = "",
    this.title = "",
    this.body = "",
    this.createDate = "",
    this.attachment = "",
    this.isSeen = false,
    this.targetId = "",
    this.notificationType = const NotificationType(),
    this.notificationPriority = const NotificationPriority(),
    this.notificationSource = const NotificationSource(),
    this.key,
  });

  NotificationItem copyWith({
    int? id,
    String? notificationId,
    String? title,
    String? body,
    String? createDate,
    String? attachment,
    bool? isSeen,
    String? targetId,
    NotificationType? notificationType,
    NotificationPriority? notificationPriority,
    NotificationSource? notificationSource,
    GlobalKey? key,
  }) =>
      NotificationItem(
        id: id ?? this.id,
        notificationId: notificationId ?? this.notificationId,
        title: title ?? this.title,
        body: body ?? this.body,
        createDate: createDate ?? this.createDate,
        attachment: attachment ?? this.attachment,
        isSeen: isSeen ?? this.isSeen,
        targetId: targetId ?? this.targetId,
        notificationType: notificationType ?? this.notificationType,
        notificationPriority: notificationPriority ?? this.notificationPriority,
        notificationSource: notificationSource ?? this.notificationSource,
        key: key ?? this.key,
      );

  @override
  List<Object> get props => [
        id,
        notificationId,
        title,
        body,
        createDate,
        attachment,
        isSeen,
        targetId,
        notificationType,
        notificationPriority,
        notificationSource,
      ];
}
