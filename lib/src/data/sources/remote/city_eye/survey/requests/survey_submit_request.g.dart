// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_submit_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveySubmitRequest _$SurveySubmitRequestFromJson(Map<String, dynamic> json) =>
    SurveySubmitRequest(
      id: json['id'] as int,
      questionTypeCode: json['questionTypeCode'] as String,
      answer: json['answer'] as String,
      answerId: json['answerId'] as String,
    );

Map<String, dynamic> _$SurveySubmitRequestToJson(
        SurveySubmitRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionTypeCode': instance.questionTypeCode,
      'answer': instance.answer,
      'answerId': instance.answerId,
    };
