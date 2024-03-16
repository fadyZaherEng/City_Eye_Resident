// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_badge_user_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteBadgeUserType _$RemoteBadgeUserTypeFromJson(Map<String, dynamic> json) =>
    RemoteBadgeUserType(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteBadgeUserTypeToJson(
        RemoteBadgeUserType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
