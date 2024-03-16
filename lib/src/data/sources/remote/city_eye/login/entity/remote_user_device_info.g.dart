// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_user_device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteUserDeviceInfo _$RemoteUserDeviceInfoFromJson(
        Map<String, dynamic> json) =>
    RemoteUserDeviceInfo(
      deviceToken: json['deviceToken'] as String? ?? '',
      isAllowNotification: json['isAllowNotification'] as bool? ?? false,
      isCurrentActive: json['isCurrentActive'] as bool? ?? true,
      lastLangCode: json['lastLangCode'] as String? ?? '',
    );

Map<String, dynamic> _$RemoteUserDeviceInfoToJson(
        RemoteUserDeviceInfo instance) =>
    <String, dynamic>{
      'deviceToken': instance.deviceToken,
      'isAllowNotification': instance.isAllowNotification,
      'isCurrentActive': instance.isCurrentActive,
      'lastLangCode': instance.lastLangCode,
    };
