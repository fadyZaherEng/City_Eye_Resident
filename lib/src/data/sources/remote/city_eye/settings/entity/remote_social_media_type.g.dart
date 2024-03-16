// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_social_media_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteSocialMediaType _$RemoteSocialMediaTypeFromJson(
        Map<String, dynamic> json) =>
    RemoteSocialMediaType(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
      logo: json['logo'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteSocialMediaTypeToJson(
        RemoteSocialMediaType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'logo': instance.logo,
    };
