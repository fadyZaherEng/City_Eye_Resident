// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_survey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteSurvey _$RemoteSurveyFromJson(Map<String, dynamic> json) => RemoteSurvey(
      flage: json['flage'] as bool? ?? false,
      countQuestionAnswers: json['countQuestionAnswers'] as int? ?? 0,
      startDate: json['startDate'] as String? ?? "",
      endDate: json['endDate'] as String? ?? "",
      id: json['id'] as int? ?? 0,
      controlTypeId: json['controlTypeId'] as int? ?? 0,
      controlTypeCode: json['controlTypeCode'] as String? ?? "",
      lable: json['lable'] as String? ?? "",
      isRequired: json['isRequired'] as bool? ?? false,
      value: json['value'] as String? ?? "",
      answerId: json['answerId'] as String? ?? "",
      description: json['description'] as String? ?? "",
      surveyQuestionChoices: (json['choice'] as List<dynamic>?)
              ?.map((e) => RemoteSurveyQuestionChoice.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteSurveyToJson(RemoteSurvey instance) =>
    <String, dynamic>{
      'flage': instance.flage,
      'countQuestionAnswers': instance.countQuestionAnswers,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'id': instance.id,
      'controlTypeId': instance.controlTypeId,
      'controlTypeCode': instance.controlTypeCode,
      'lable': instance.lable,
      'isRequired': instance.isRequired,
      'value': instance.value,
      'answerId': instance.answerId,
      'description': instance.description,
      'choice': instance.surveyQuestionChoices,
    };
