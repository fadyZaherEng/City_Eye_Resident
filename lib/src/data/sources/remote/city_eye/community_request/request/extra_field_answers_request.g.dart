// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_field_answers_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraFieldAnswersRequest _$ExtraFieldAnswersRequestFromJson(
        Map<String, dynamic> json) =>
    ExtraFieldAnswersRequest(
      id: json['id'] as int,
      controlTypeId: json['controlTypeId'] as int,
      controlTypeCode: json['controlTypeCode'] as String,
      lable: json['lable'] as String,
      isRequired: json['isRequired'] as bool,
      value: json['value'] as String,
      answerId: json['answerId'] as String,
    );

Map<String, dynamic> _$ExtraFieldAnswersRequestToJson(
        ExtraFieldAnswersRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'controlTypeId': instance.controlTypeId,
      'controlTypeCode': instance.controlTypeCode,
      'lable': instance.lable,
      'isRequired': instance.isRequired,
      'value': instance.value,
      'answerId': instance.answerId,
    };
