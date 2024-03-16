// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_notification_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteNotificationType _$RemoteNotificationTypeFromJson(
        Map<String, dynamic> json) =>
    RemoteNotificationType(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteNotificationTypeToJson(
        RemoteNotificationType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
