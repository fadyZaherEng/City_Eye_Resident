import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/survey/requests/survey_submit_request.dart';
import 'package:city_eye/src/domain/entities/survey/survey.dart';
import 'package:city_eye/src/domain/usecase/submit_survey_use_case.dart';
import 'package:city_eye/src/domain/usecase/wall/get_surveys_use_case.dart';
import 'package:city_eye/src/presentation/blocs/survey/survey_event.dart';
import 'package:city_eye/src/presentation/blocs/survey/survey_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  final GetSurveysUseCase _getSurveysUseCase;
  final SubmitSurveyUseCase _submitSurveyUseCase;

  SurveyBloc(
    this._getSurveysUseCase,
    this._submitSurveyUseCase,
  ) : super(ShowSurveySkeletonState()) {
    on<GetSurveysDataEvent>(_onGetSurveysDataEvent);
    on<SurveyPopBackEvent>(_onSurveyPopBackEvent);
    on<SelectSurveyActionEvent>(_onSelectSurveyActionEvent);
    on<SendSurveyNeededInformationEvent>(_onSendSurveyNeededInformationEvent);
    on<ScrollToItemEvent>(_onScrollToItemEvent);
  }

  List<Survey> _surveys = [];

  void _onSurveyPopBackEvent(SurveyPopBackEvent event, Emitter emit) {
    emit(SurveyPopBackState());
  }

  void _onSelectSurveyActionEvent(
      SelectSurveyActionEvent event, Emitter<SurveyState> emit) async {
    if (!event.survey.flage) {
      emit(ShowLoadingState());
      SurveySubmitRequest surveySubmitRequest = SurveySubmitRequest(
        id: event.survey.id,
        answer: event.surveyAction.id.toString(),
        answerId: '',
        questionTypeCode: event.survey.controlTypeCode,
      );

      DataState dataState = await _submitSurveyUseCase(surveySubmitRequest);
      if (dataState is DataSuccess) {
        var surveyResponse = dataState.data as Survey;

        for (var i = 0; i < _surveys.length; i++) {
          if (_surveys[i].id == surveyResponse.id) {
            _surveys[i] = surveyResponse;
            for (var j = 0; j < _surveys[i].surveyQuestionChoice.length; j++) {
              if (_surveys[i].surveyQuestionChoice[j].id.toString() ==
                  surveyResponse.value) {
                _surveys[i].surveyQuestionChoice[j] =
                    _surveys[i].surveyQuestionChoice[j].copyWith(
                          isSelected: true,
                        );
                _surveys[i].selectAction = _surveys[i].surveyQuestionChoice[j];
                if (_surveys[i].selectAction?.isNeedMoreInformation == false) {
                  _surveys[i].selectAction = _surveys[i].selectAction?.copyWith(
                        showPercentage: true,
                        isSelected: true,
                      );
                } else {
                  _surveys[i].selectAction = _surveys[i].selectAction?.copyWith(
                        showPercentage: false,
                        isSelected: false,
                      );
                }
                break;
              }
            }
            if (_surveys[i].selectAction?.isNeedMoreInformation == false) {
              _surveys[i].selectAction = _surveys[i].selectAction?.copyWith(
                    showPercentage: true,
                    isSelected: true,
                  );
            } else {
              _surveys[i].selectAction = _surveys[i].selectAction?.copyWith(
                    showPercentage: false,
                    isSelected: true,
                  );
            }

            break;
          }
        }

        emit(SubmitSurveySuccessState(survey: _surveys));
      } else {
        emit(SubmitSurveyFailedState(
          errorMessage: dataState.message ?? "",
        ));
      }

      emit(UpdateSurveyActionState(
          surveys: _surveys, selectedSurveyAction: event.surveyAction));
    }

    emit(HideLoadingState());
  }

  void _onSendSurveyNeededInformationEvent(
      SendSurveyNeededInformationEvent event, Emitter<SurveyState> emit) {
    for (var i = 0; i < _surveys.length; i++) {
      if (_surveys[i].id == event.survey.id) {
        _surveys[i].surveyQuestionChoice.forEach((element) {
          if (element.id == event.survey.selectAction?.id) {
            element = element.copyWith(
              isNeedMoreInformation: false,
            );
            _surveys[i].selectAction = _surveys[i].selectAction?.copyWith(
                  showPercentage: true,
                );
          }
        });
        break;
      }
    }
    emit(UpdateSurveyActionState(
        surveys: _surveys, selectedSurveyAction: event.survey.selectAction!));
  }

  FutureOr<void> _onGetSurveysDataEvent(
      GetSurveysDataEvent event, Emitter<SurveyState> emit) async {
    emit(ShowSurveySkeletonState());
    DataState dataState = await _getSurveysUseCase();
    if (dataState is DataSuccess) {
      _surveys = dataState.data as List<Survey>;
      for (var i = 0; i < _surveys.length; i++) {
        if (_surveys[i].flage) {
          for (var j = 0; j < _surveys[i].surveyQuestionChoice.length; j++) {
            if (_surveys[i].surveyQuestionChoice[j].id.toString() ==
                _surveys[i].value) {
              _surveys[i].surveyQuestionChoice[j] =
                  _surveys[i].surveyQuestionChoice[j].copyWith(
                        isSelected: true,
                      );
              _surveys[i].selectAction = _surveys[i].surveyQuestionChoice[j];
              if (_surveys[i].selectAction?.isNeedMoreInformation == false) {
                _surveys[i].selectAction = _surveys[i].selectAction?.copyWith(
                      showPercentage: true,
                      isSelected: true,
                    );
              } else {
                _surveys[i].selectAction = _surveys[i].selectAction?.copyWith(
                      showPercentage: false,
                      isSelected: false,
                    );
              }
              break;
            }
          }
        }
      }
      for (var i = 0; i < _surveys.length; i++) {
        GlobalKey key = GlobalKey();
        _surveys[i] = _surveys[i].copyWith(key: key);
      }
      emit(GetSurveyDataSuccessState(surveys: _surveys));
    } else {
      emit(GetSurveyDataFailedState(errorMessage: dataState.message ?? ""));
    }
    emit(HideLoadingState());
  }

  FutureOr<void> _onScrollToItemEvent(
      ScrollToItemEvent event, Emitter<SurveyState> emit) {
    emit(ScrollToItemState(key: event.key));
  }
}
