// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteStatus _$RemoteStatusFromJson(Map<String, dynamic> json) => RemoteStatus(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      colorCode: json['colorCode'] as String? ?? "",
      logo: json['logo'] as String? ?? "",
      isCompleted: json['isCompleted'] as bool? ?? false,
      isCurrent: json['isCurrent'] as bool? ?? false,
      captionStatusCode: json['captionStatusCode'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteStatusToJson(RemoteStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'colorCode': instance.colorCode,
      'logo': instance.logo,
      'isCompleted': instance.isCompleted,
      'isCurrent': instance.isCurrent,
      'captionStatusCode': instance.captionStatusCode,
    };
