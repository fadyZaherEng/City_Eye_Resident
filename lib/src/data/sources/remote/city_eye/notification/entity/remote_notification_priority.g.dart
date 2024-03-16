// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_notification_priority.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteNotificationPriority _$RemoteNotificationPriorityFromJson(
        Map<String, dynamic> json) =>
    RemoteNotificationPriority(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
      extra1: json['extra1'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteNotificationPriorityToJson(
        RemoteNotificationPriority instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'extra1': instance.extra1,
    };
