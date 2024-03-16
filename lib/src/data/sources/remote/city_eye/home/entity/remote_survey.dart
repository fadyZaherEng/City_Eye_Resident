import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_choice.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/survey/entity/remote_survey_question_choice.dart';
import 'package:city_eye/src/domain/entities/survey/survey.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_survey.g.dart';

@JsonSerializable()
final class RemoteSurvey {
  @JsonKey(name: 'flage')
  final bool? flage;
  @JsonKey(name: 'countQuestionAnswers')
  final int? countQuestionAnswers;
  @JsonKey(name: 'startDate')
  final String? startDate;
  @JsonKey(name: 'endDate')
  final String? endDate;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'controlTypeId')
  final int? controlTypeId;
  @JsonKey(name: 'controlTypeCode')
  final String? controlTypeCode;
  @JsonKey(name: 'lable')
  final String? lable;
  @JsonKey(name: 'isRequired')
  final bool? isRequired;
  @JsonKey(name: 'value')
  final String? value;
  @JsonKey(name: 'answerId')
  final String? answerId;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'choice')
  final List<RemoteSurveyQuestionChoice>? surveyQuestionChoices;

  const RemoteSurvey({
    this.flage = false,
    this.countQuestionAnswers = 0,
    this.startDate = "",
    this.endDate = "",
    this.id = 0,
    this.controlTypeId = 0,
    this.controlTypeCode = "",
    this.lable = "",
    this.isRequired = false,
    this.value = "",
    this.answerId = "",
    this.description = "",
    this.surveyQuestionChoices = const [],
  });

  factory RemoteSurvey.fromJson(Map<String, dynamic> json) =>
      _$RemoteSurveyFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteSurveyToJson(this);
}

extension RemoteSurveyExtension on RemoteSurvey {
  Survey get mapToDomain => Survey(
        flage: flage ?? false,
        countQuestionAnswers: countQuestionAnswers ?? 0,
        id: id ?? 0,
        startDate: startDate ?? "",
        endDate: endDate ?? "",
        controlTypeId: controlTypeId ?? 0,
        controlTypeCode: controlTypeCode ?? "",
        lable: lable ?? "",
        isRequired: isRequired ?? false,
        value: value ?? "",
        answerId: answerId ?? "",
        description: description ?? "",
        surveyQuestionChoice: (surveyQuestionChoices ?? []).mapToDomain(),
        key: GlobalKey(),
      );
}

extension RemoteSurveyListExtension on List<RemoteSurvey>? {
  List<Survey> get mapToDomain =>
      this!.map((survey) => survey.mapToDomain).toList();
}
