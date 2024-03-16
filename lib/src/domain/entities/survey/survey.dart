import 'package:city_eye/src/domain/entities/survey/survey_question_choice.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class Survey extends Equatable {
  final bool flage;
  final int countQuestionAnswers;
  final String startDate;
  final String endDate;
  final int id;
  final int controlTypeId;
  final String controlTypeCode;
  final String lable;
  final bool isRequired;
  final String value;
  final String answerId;
  final String description;
  bool isUserCanToggle = true;
  SurveyQuestionChoice? selectAction;
  final List<SurveyQuestionChoice> surveyQuestionChoice;
  GlobalKey? key;

  Survey({
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
    this.selectAction,
    this.isUserCanToggle = true,
    this.surveyQuestionChoice = const [],
    this.key,
  });

  @override
  List<Object> get props => [
        flage,
        countQuestionAnswers,
        id,
        controlTypeId,
        controlTypeCode,
        lable,
        isRequired,
        value,
        answerId,
        description,
        surveyQuestionChoice,
      ];

  Survey copyWith({
    bool? flage,
    int? countQuestionAnswers,
    String? startDate,
    String? endDate,
    int? id,
    int? controlTypeId,
    String? controlTypeCode,
    String? lable,
    bool? isRequired,
    String? value,
    String? answerId,
    String? description,
    SurveyQuestionChoice? selectAction,
    bool? isUserCanToggle,
    List<SurveyQuestionChoice>? surveyQuestionChoice,
    GlobalKey? key,
  }) {
    return Survey(
      flage: flage ?? this.flage,
      countQuestionAnswers: countQuestionAnswers ?? this.countQuestionAnswers,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      id: id ?? this.id,
      controlTypeId: controlTypeId ?? this.controlTypeId,
      controlTypeCode: controlTypeCode ?? this.controlTypeCode,
      lable: lable ?? this.lable,
      isRequired: isRequired ?? this.isRequired,
      value: value ?? this.value,
      answerId: answerId ?? this.answerId,
      description: description ?? this.description,
      selectAction: selectAction ?? this.selectAction,
      isUserCanToggle: isUserCanToggle ?? this.isUserCanToggle,
      surveyQuestionChoice: surveyQuestionChoice ?? this.surveyQuestionChoice,
      key: key ?? this.key,
    );
  }
}
