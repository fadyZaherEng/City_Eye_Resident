// ignore_for_file: must_be_immutable

import 'package:city_eye/src/domain/entities/home/home_compound.dart';
import 'package:city_eye/src/domain/entities/home/home_event_item.dart';
import 'package:city_eye/src/domain/entities/home/home_event_option.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:city_eye/src/domain/entities/survey/survey.dart';
import 'package:city_eye/src/domain/entities/offers/offer.dart';
import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/domain/entities/survey/survey_question_choice.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class ShowSkeletonState extends HomeState {}

class GetUserInformationState extends HomeState {
  final User user;
  final UserUnit userUnit;

  GetUserInformationState({
    required this.user,
    required this.userUnit,
  });
}

class NavigateToNotificationScreenState extends HomeState {}

class NavigateToQrScreenState extends HomeState {}

class NavigateToSupportDetailScreenState extends HomeState {
  final HomeSupport support;

  NavigateToSupportDetailScreenState({required this.support});
}

class NavigateToServiceDetailScreenState extends HomeState {
  final HomeService service;

  NavigateToServiceDetailScreenState({required this.service});
}

class NavigateToEventDetailScreenState extends HomeState {
  final HomeEventItem event;

  NavigateToEventDetailScreenState({required this.event});
}

class SelectEventActionState extends HomeState {
  final HomeEventOption eventAction;

  SelectEventActionState({required this.eventAction});
}

class UpdateEventActionState extends HomeState {
  final List<HomeEventItem> events;

  UpdateEventActionState({
    required this.events,
  });
}

class SendEventNeededInformationState extends HomeState {}

class NavigateToEventsScreenState extends HomeState {}

class NavigateToSurveyScreenState extends HomeState {}

class UpdateSurveyActionState extends HomeState {
  final List<Survey> surveys;

  final SurveyQuestionChoice selectedSurveyAction;

  UpdateSurveyActionState(
      {required this.surveys, required this.selectedSurveyAction});
}

class SendSurveyNeededInformationState extends HomeState {}

class GetHomeContentSuccessState extends HomeState {
  HomeCompound homeCompound;

  GetHomeContentSuccessState({required this.homeCompound});
}

class GetHomeContentFailedState extends HomeState {
  String errorMessage;

  GetHomeContentFailedState({required this.errorMessage});
}

class EventCheckForDynamicQuestionState extends HomeState {
  final List<PageField> questionsList;
  final HomeEventItem event;
  final HomeEventOption eventAction;

  EventCheckForDynamicQuestionState(
      {required this.questionsList,
      required this.event,
      required this.eventAction});
}

class EventOnBottomSheetOkClickState extends HomeState {
  final List<PageField> questions;
  final HomeEventItem event;
  final HomeEventOption eventAction;
  final List<PageField> allQuestions;
  final String message;

  EventOnBottomSheetOkClickState({
    required this.questions,
    required this.event,
    required this.eventAction,
    required this.allQuestions,
    required this.message,
  });
}

class AddEventToCalendarState extends HomeState {
  final HomeEventItem event;
  final HomeEventOption eventAction;
  TZDateTime? startDate;
  TZDateTime? endDate;
  bool? isAllDay;

  AddEventToCalendarState(
      {required this.event,
      required this.eventAction,
      this.startDate,
      this.endDate,
      this.isAllDay});
}

class DeleteEventToCalendarState extends HomeState {
  final HomeEventItem eventContent;
  final HomeEventOption eventAction;
  final String eventId;

  DeleteEventToCalendarState({
    required this.eventContent,
    required this.eventAction,
    required this.eventId,
  });
}

class SendEventReferenceSuccessIdState extends HomeState {}

class GetOffersDataSuccessState extends HomeState {
  List<Offer> offers;

  GetOffersDataSuccessState({required this.offers});
}

class GetOffersDataFailedState extends HomeState {
  final String message;

  GetOffersDataFailedState({required this.message});
}

class GetServicesAfterFilterationState extends HomeState {
  final List<HomeService> filteredServices;

  GetServicesAfterFilterationState({
    required this.filteredServices,
  });
}

class GetServicesAfterFilterationForSpecificServiceState extends HomeState {
  final List<HomeService> filteredServices;

  GetServicesAfterFilterationForSpecificServiceState({
    required this.filteredServices,
  });
}

class SubmitSurveySuccessState extends HomeState {
  final List<Survey> survey;

  SubmitSurveySuccessState({
    required this.survey,
  });
}

class SubmitSurveyFailedState extends HomeState {
  final String errorMessage;

  SubmitSurveyFailedState({
    required this.errorMessage,
  });
}

class ShowCalendarActionDialogState extends HomeState {
  final HomeEventItem event;
  final HomeEventOption eventAction;
  List<PageField> questions;

  ShowCalendarActionDialogState({
    required this.event,
    required this.eventAction,
    this.questions = const [],
  });
}

class DeleteEventReferenceIdState extends HomeState {
  final List<PageField> questions;
  final HomeEventItem event;
  final HomeEventOption eventAction;

  DeleteEventReferenceIdState(
      {required this.questions,
      required this.event,
      required this.eventAction});
}

class ShowLoadingState extends HomeState {}

class HideLoadingState extends HomeState {}

class OnTapOfferNavigateToWebViewState extends HomeState {
  final Offer offer;

  OnTapOfferNavigateToWebViewState({required this.offer});
}

class OnTapOfferNavigateToEventState extends HomeState {
  final Offer offer;

  OnTapOfferNavigateToEventState({required this.offer});
}

class GetNotificationCountSuccessState extends HomeState {
  final int count;

  GetNotificationCountSuccessState({required this.count});
}

class GetNotificationCountFailedState extends HomeState {
  final String errorMessage;

  GetNotificationCountFailedState({required this.errorMessage});
}
