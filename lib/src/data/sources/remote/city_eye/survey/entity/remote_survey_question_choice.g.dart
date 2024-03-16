// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_survey_question_choice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteSurveyQuestionChoice _$RemoteSurveyQuestionChoiceFromJson(
        Map<String, dynamic> json) =>
    RemoteSurveyQuestionChoice(
      id: json['id'] as int?,
      value: json['value'] as String?,
      countAnswer: json['countAnswer'] as int?,
    );

Map<String, dynamic> _$RemoteSurveyQuestionChoiceToJson(
        RemoteSurveyQuestionChoice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'countAnswer': instance.countAnswer,
    };
