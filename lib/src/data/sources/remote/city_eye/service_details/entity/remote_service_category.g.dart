// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_service_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteServiceCategory _$RemoteServiceCategoryFromJson(
        Map<String, dynamic> json) =>
    RemoteServiceCategory(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
      logo: json['logo'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteServiceCategoryToJson(
        RemoteServiceCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'logo': instance.logo,
    };
