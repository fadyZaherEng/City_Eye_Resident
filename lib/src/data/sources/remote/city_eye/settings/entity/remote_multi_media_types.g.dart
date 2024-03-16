// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_multi_media_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteMultiMediaTypes _$RemoteMultiMediaTypesFromJson(
        Map<String, dynamic> json) =>
    RemoteMultiMediaTypes(
      id: json['id'] as int? ?? 0,
      isVisible: json['isVisible'] as bool? ?? false,
      code: json['code'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteMultiMediaTypesToJson(
        RemoteMultiMediaTypes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isVisible': instance.isVisible,
      'code': instance.code,
    };
