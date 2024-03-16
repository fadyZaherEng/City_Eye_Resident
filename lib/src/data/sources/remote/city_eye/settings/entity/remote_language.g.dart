// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteLanguage _$RemoteLanguageFromJson(Map<String, dynamic> json) =>
    RemoteLanguage(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
      logo: json['logo'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteLanguageToJson(RemoteLanguage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'logo': instance.logo,
    };
