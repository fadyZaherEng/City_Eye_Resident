// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_profile_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteProfileFile _$RemoteProfileFileFromJson(Map<String, dynamic> json) =>
    RemoteProfileFile(
      id: json['id'] as int? ?? 0,
      controlTypeId: json['controlTypeId'] as int? ?? 0,
      controlTypeCode: json['controlTypeCode'] as String? ?? "",
      lable: json['lable'] as String? ?? "",
      isRequired: json['isRequired'] as bool? ?? false,
      value: json['value'] as String? ?? "",
      expireDate: json['expireDate'] as String? ?? "",
      isEditable: json['isEditable'] as bool? ?? false,
      isDeletable: json['isDeletable'] as bool? ?? false,
      canNotDeleteReason: json['canNotDeleteReason'] as String? ?? "",
      canNotEditReason: json['canNotEditReason'] as String? ?? "",
      description: json['description'] as String? ?? "",
      maxCount: json['maxCount'] as int? ?? 0,
      minCount: json['minCount'] as int? ?? 0,
    );

Map<String, dynamic> _$RemoteProfileFileToJson(RemoteProfileFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'controlTypeId': instance.controlTypeId,
      'controlTypeCode': instance.controlTypeCode,
      'lable': instance.lable,
      'isRequired': instance.isRequired,
      'value': instance.value,
      'expireDate': instance.expireDate,
      'isEditable': instance.isEditable,
      'isDeletable': instance.isDeletable,
      'canNotDeleteReason': instance.canNotDeleteReason,
      'canNotEditReason': instance.canNotEditReason,
      'description': instance.description,
      'maxCount': instance.maxCount,
      'minCount': instance.minCount,
    };
