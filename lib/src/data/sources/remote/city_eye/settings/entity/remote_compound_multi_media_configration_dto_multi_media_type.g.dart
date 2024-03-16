// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_compound_multi_media_configration_dto_multi_media_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCompoundMultiMediaConfigrationDtoMultiMediaType
    _$RemoteCompoundMultiMediaConfigrationDtoMultiMediaTypeFromJson(
            Map<String, dynamic> json) =>
        RemoteCompoundMultiMediaConfigrationDtoMultiMediaType(
          id: json['id'] as int? ?? 0,
          code: json['code'] as String? ?? "",
          logo: json['logo'] as String? ?? "",
        );

Map<String, dynamic>
    _$RemoteCompoundMultiMediaConfigrationDtoMultiMediaTypeToJson(
            RemoteCompoundMultiMediaConfigrationDtoMultiMediaType instance) =>
        <String, dynamic>{
          'id': instance.id,
          'code': instance.code,
          'logo': instance.logo,
        };
