// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delegated_extra_field_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DelegatedExtraFieldRequest _$DelegatedExtraFieldRequestFromJson(
        Map<String, dynamic> json) =>
    DelegatedExtraFieldRequest(
      id: json['id'] as int? ?? 0,
      controlTypeId: json['controlTypeId'] as int? ?? 0,
      controlTypeCode: json['controlTypeCode'] as String? ?? "",
      lable: json['lable'] as String? ?? "",
      isRequired: json['isRequired'] as bool? ?? false,
      value: json['value'] as String? ?? "",
      answerId: json['answerId'] as String? ?? "",
    );

Map<String, dynamic> _$DelegatedExtraFieldRequestToJson(
        DelegatedExtraFieldRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'controlTypeId': instance.controlTypeId,
      'controlTypeCode': instance.controlTypeCode,
      'lable': instance.lable,
      'isRequired': instance.isRequired,
      'value': instance.value,
      'answerId': instance.answerId,
    };
