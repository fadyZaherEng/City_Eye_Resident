import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/offers_request.dart';
import 'package:city_eye/src/domain/entities/home/home_compound.dart';
import 'package:city_eye/src/domain/entities/home/home_event_item.dart';
import 'package:city_eye/src/domain/entities/home/home_event_option.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:city_eye/src/domain/entities/offers/offer.dart';
import 'package:city_eye/src/domain/entities/survey/survey.dart';
import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/entities/survey/survey_question_choice.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class GetUserInformationEvent extends HomeEvent {}

class NavigateToNotificationScreenEvent extends HomeEvent {}

class NavigateToQrScreenEvent extends HomeEvent {}

class NavigateToSupportDetailScreenEvent extends HomeEvent {
  final HomeSupport support;

  NavigateToSupportDetailScreenEvent({required this.support});
}

class NavigateToServiceDetailScreenEvent extends HomeEvent {
  final HomeService service;

  NavigateToServiceDetailScreenEvent({required this.service});
}

class NavigateToEventDetailScreenEvent extends HomeEvent {
  final HomeEventItem event;

  NavigateToEventDetailScreenEvent({required this.event});
}

class SelectEventActionEvent extends HomeEvent {
  final HomeEventItem event;
  final HomeEventOption eventAction;

  SelectEventActionEvent({
    required this.eventAction,
    required this.event,
  });
}

class SendEventNeededInformationEvent extends HomeEvent {
  final String eventNeededInformation;

  SendEventNeededInformationEvent({required this.eventNeededInformation});
}

class EventSeeAllEvent extends HomeEvent {}

class SurveySeeAllEvent extends HomeEvent {}

class SelectSurveyActionEvent extends HomeEvent {
  final Survey survey;
  final SurveyQuestionChoice surveyAction;

  SelectSurveyActionEvent({required this.surveyAction, required this.survey});
}

class SendSurveyNeededInformationEvent extends HomeEvent {
  final Survey survey;
  final String surveyNeededInformation;

  SendSurveyNeededInformationEvent(
      {required this.surveyNeededInformation, required this.survey});
}

class ShowHomeContentEvent extends HomeEvent {
  final HomeCompound homeCompound;

  ShowHomeContentEvent({required this.homeCompound});
}

class EventCheckForDynamicQuestionEvent extends HomeEvent {
  final HomeEventItem event;
  final HomeEventOption eventAction;

  EventCheckForDynamicQuestionEvent(
      {required this.event, required this.eventAction});
}

class EventOnBottomSheetOkClickEvent extends HomeEvent {
  final List<PageField> questions;
  final HomeEventItem event;
  final HomeEventOption eventAction;

  EventOnBottomSheetOkClickEvent(
      {required this.questions,
      required this.event,
      required this.eventAction});
}

class AddEventToCalendarEvent extends HomeEvent {
  HomeEventItem event;
  HomeEventOption eventAction;
  TZDateTime? startDate;
  TZDateTime? endDate;
  bool? isAllDay;

  AddEventToCalendarEvent({
    required this.event,
    required this.eventAction,
    this.startDate,
    this.endDate,
    this.isAllDay,
  });
}

class DeleteEventFromCalendarEvent extends HomeEvent {
  final HomeEventItem event;
  final HomeEventOption eventAction;
  final String eventId;

  DeleteEventFromCalendarEvent({
    required this.event,
    required this.eventAction,
    required this.eventId,
  });
}

class SendEventReferenceIdEvent extends HomeEvent {
  HomeEventItem event;
  HomeEventOption eventAction;
  String eventReferenceId;

  SendEventReferenceIdEvent(
      {required this.event,
      required this.eventAction,
      required this.eventReferenceId});
}

class DeleteEventReferenceIdEvent extends HomeEvent {
  final List<PageField> questions;
  final HomeEventItem event;
  final HomeEventOption eventAction;

  DeleteEventReferenceIdEvent(
      {required this.questions, required this.event, required this.eventAction});
}

class GetOffersDataEvent extends HomeEvent {
  OffersRequest request;

  GetOffersDataEvent({required this.request});
}

class FilterServiceAccordingToParentIdEvent extends HomeEvent {
  final List<HomeService> homeServices;

  FilterServiceAccordingToParentIdEvent({
    required this.homeServices,
  });
}

class FilterServicesAccordingBySpecificServiceEvent extends HomeEvent {
  final List<HomeService> homeServices;
  final HomeService homeService;

  FilterServicesAccordingBySpecificServiceEvent({
    required this.homeServices,
    required this.homeService,
  });
}

class ShowCalendarActionDialogEvent extends HomeEvent {
  HomeEventItem event;
  HomeEventOption eventAction;
  List<PageField> questions;

  ShowCalendarActionDialogEvent({
    required this.event,
    required this.eventAction,
    this.questions = const [],
  });
}

class OnTapOfferEvent extends HomeEvent {
  final Offer offer;

  OnTapOfferEvent({required this.offer});
}

class GetNotificationCountEvent extends HomeEvent {}