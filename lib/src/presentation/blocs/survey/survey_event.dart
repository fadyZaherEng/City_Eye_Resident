import 'package:city_eye/src/domain/entities/survey/survey.dart';
import 'package:city_eye/src/domain/entities/survey/survey_question_choice.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SurveyEvent extends Equatable {
  const SurveyEvent();

  @override
  List<Object> get props => [identityHashCode(this)];
}

class SurveyPopBackEvent extends SurveyEvent {}

class GetSurveysDataEvent extends SurveyEvent {}

class SelectSurveyActionEvent extends SurveyEvent {
  final Survey survey;
  final SurveyQuestionChoice surveyAction;

  SelectSurveyActionEvent({required this.surveyAction, required this.survey});
}

class SendSurveyNeededInformationEvent extends SurveyEvent {
  final Survey survey;
  final String surveyNeededInformation;

  SendSurveyNeededInformationEvent(
      {required this.surveyNeededInformation, required this.survey});
}

class ScrollToItemEvent extends SurveyEvent {
  final GlobalKey key;

  ScrollToItemEvent({required this.key});
}
