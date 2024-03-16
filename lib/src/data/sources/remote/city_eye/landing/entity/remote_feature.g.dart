// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_feature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteFeature _$RemoteFeatureFromJson(Map<String, dynamic> json) =>
    RemoteFeature(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      description: json['description'] as String? ?? "",
      logo: json['logo'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteFeatureToJson(RemoteFeature instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'description': instance.description,
    };
