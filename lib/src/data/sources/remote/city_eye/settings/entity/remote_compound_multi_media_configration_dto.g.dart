// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_compound_multi_media_configration_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCompoundMultiMediaConfigrationDtos
    _$RemoteCompoundMultiMediaConfigrationDtosFromJson(
            Map<String, dynamic> json) =>
        RemoteCompoundMultiMediaConfigrationDtos(
          id: json['id'] as int? ?? 0,
          isVisible: json['isVisible'] as bool? ?? false,
          minCount: json['minCount'] as int? ?? 0,
          maxCount: json['maxCount'] as int? ?? 0,
          maxTime: json['maxTime'] as int? ?? 0,
          maxSize: json['maxSize'] as int? ?? 0,
          isMulti: json['isMulti'] as bool? ?? false,
          multiMediaType: json['multiMediaType'] == null
              ? const RemoteCompoundMultiMediaConfigrationDtoMultiMediaType()
              : RemoteCompoundMultiMediaConfigrationDtoMultiMediaType.fromJson(
                  json['multiMediaType'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RemoteCompoundMultiMediaConfigrationDtosToJson(
        RemoteCompoundMultiMediaConfigrationDtos instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isVisible': instance.isVisible,
      'minCount': instance.minCount,
      'maxCount': instance.maxCount,
      'maxTime': instance.maxTime,
      'maxSize': instance.maxSize,
      'isMulti': instance.isMulti,
      'multiMediaType': instance.multiMediaType?.toJson(),
    };
