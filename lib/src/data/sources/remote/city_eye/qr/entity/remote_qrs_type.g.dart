// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_qrs_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteQrsType _$RemoteQrsTypeFromJson(Map<String, dynamic> json) =>
    RemoteQrsType(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteQrsTypeToJson(RemoteQrsType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
