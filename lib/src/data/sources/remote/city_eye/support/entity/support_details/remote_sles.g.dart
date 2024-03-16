// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_sles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteSles _$RemoteSlesFromJson(Map<String, dynamic> json) => RemoteSles(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
      noOfMinutes: json['noOfMinutes'] as int? ?? 0,
      isSLE: json['isSLE'] as bool? ?? false,
    );

Map<String, dynamic> _$RemoteSlesToJson(RemoteSles instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'noOfMinutes': instance.noOfMinutes,
      'isSLE': instance.isSLE,
    };
