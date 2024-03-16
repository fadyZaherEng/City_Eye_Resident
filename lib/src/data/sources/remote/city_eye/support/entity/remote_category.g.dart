// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCategory _$RemoteCategoryFromJson(Map<String, dynamic> json) =>
    RemoteCategory(
      id: json['id'] as int? ?? 0,
      code: json['code'] as String? ?? "",
      name: json['name'] as String? ?? "",
      logo: json['logo'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteCategoryToJson(RemoteCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'logo': instance.logo,
    };
