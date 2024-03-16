// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_compound_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCompoundType _$RemoteCompoundTypeFromJson(Map<String, dynamic> json) =>
    RemoteCompoundType(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteCompoundTypeToJson(RemoteCompoundType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
