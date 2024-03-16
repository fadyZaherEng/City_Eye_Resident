// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_notification_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteNotificationSource _$RemoteNotificationSourceFromJson(
        Map<String, dynamic> json) =>
    RemoteNotificationSource(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteNotificationSourceToJson(
        RemoteNotificationSource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
