// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteType _$RemoteTypeFromJson(Map<String, dynamic> json) => RemoteType(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteTypeToJson(RemoteType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
