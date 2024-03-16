// ignore_for_file: must_be_immutable

import 'package:city_eye/src/domain/entities/survey/survey.dart';
import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/entities/survey/survey_question_choice.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SurveyState extends Equatable {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class ShowSurveySkeletonState extends SurveyState {}

class SurveyPopBackState extends SurveyState {}

class GetSurveyDataSuccessState extends SurveyState {
  final List<Survey> surveys;

  GetSurveyDataSuccessState({
    required this.surveys,
  });
}

class GetSurveyDataFailedState extends SurveyState {
  final String errorMessage;

  GetSurveyDataFailedState({
    required this.errorMessage,
  });
}

class SubmitSurveySuccessState extends SurveyState {
  final List<Survey> survey;

  SubmitSurveySuccessState({
    required this.survey,
  });
}

class SubmitSurveyFailedState extends SurveyState {
  final String errorMessage;

  SubmitSurveyFailedState({
    required this.errorMessage,
  });
}

class UpdateSurveyActionState extends SurveyState {
  final List<Survey> surveys;
  final SurveyQuestionChoice selectedSurveyAction;

  UpdateSurveyActionState(
      {required this.surveys, required this.selectedSurveyAction});
}

class SendSurveyNeededInformationState extends SurveyState {}

class ShowLoadingState extends SurveyState {}

class HideLoadingState extends SurveyState {}

class ScrollToItemState extends SurveyState {
  final GlobalKey key;

  ScrollToItemState({required this.key});
}
