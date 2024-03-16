// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_question_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventQuestionRequest _$EventQuestionRequestFromJson(
        Map<String, dynamic> json) =>
    EventQuestionRequest(
      id: json['id'] as int,
      controlTypeId: json['controlTypeId'] as int,
      controlTypeCode: json['controlTypeCode'] as String,
      lable: json['lable'] as String,
      isRequired: json['isRequired'] as bool,
      value: json['value'] as String,
      answerId: json['answerId'] as String,
    );

Map<String, dynamic> _$EventQuestionRequestToJson(
        EventQuestionRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'controlTypeId': instance.controlTypeId,
      'controlTypeCode': instance.controlTypeCode,
      'lable': instance.lable,
      'isRequired': instance.isRequired,
      'value': instance.value,
      'answerId': instance.answerId,
    };
