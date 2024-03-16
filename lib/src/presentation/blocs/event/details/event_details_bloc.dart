import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/request/event_details_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/request/event_question_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/request/submit_event_request.dart';
import 'package:city_eye/src/domain/entities/event/submit_event.dart';
import 'package:city_eye/src/domain/entities/home/home_event_item.dart';
import 'package:city_eye/src/domain/entities/home/home_event_option.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/usecase/get_event_details_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_local_compound_configuration_use_case.dart';
import 'package:city_eye/src/domain/usecase/submit_event_use_case.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event_details_event.dart';

part 'event_details_state.dart';

class EventDetailsBloc extends Bloc<EventDetailsEvent, EventDetailsState> {
  final GetEventDetailsUseCase _getEventDetailsUseCase;
  final SubmitEventUseCase _submitEventUseCase;
  final GetLocalCompoundConfigurationUseCase
      _getLocalCompoundConfigurationUseCase;

  EventDetailsBloc(
    this._getEventDetailsUseCase,
    this._submitEventUseCase,
    this._getLocalCompoundConfigurationUseCase,
  ) : super(EventDetailsInitial()) {
    on<SelectEventActionEvent>(_onSelectEventActionEvent);
    on<NavigateBackEvent>(_onNavigateBackEvent);
    on<CheckForEventDetailsDynamicQuestionEvent>(
        _onCheckForEventDetailsDynamicQuestionEvent);
    on<OnEventDetailsBottomSheetOkClickEvent>(
        _onOnEventDetailsBottomSheetOkClickEvent);
    on<AddEventToCalendarEvent>(_onAddEventToCalendarEvent);
    on<DeleteEventFromCalendarEvent>(_onDeleteEventToCalendarEvent);
    on<SendEventReferenceIdEvent>(_onSendEventReferenceIdEvent);
    on<GetCompoundConfigurationEvent>(_onGetCompoundConfigurationEvent);
    on<ShowCalendarActionDialogEvent>(_onShowCalendarActionDialogEvent);
    on<DeleteEventReferenceIdEvent>(_onDeleteEventReferenceIdEvent);
    on<GetEventDetailsEvent>(_onGetEventDetailsEvent);
  }

  List<PageField> dynamicQuestions = [];
  HomeEventItem eventContent = const HomeEventItem();

  FutureOr<void> _onSelectEventActionEvent(
      SelectEventActionEvent event, Emitter<EventDetailsState> emit) {
    for (int j = 0; j < eventContent.eventsOptions.length; j++) {
      if (eventContent.eventsOptions[j].id == event.eventAction.id) {
        eventContent.eventsOptions[j] = eventContent.eventsOptions[j].copyWith(
          isSelectedByUser: true,
        );
      } else {
        eventContent.eventsOptions[j] = eventContent.eventsOptions[j].copyWith(
          isSelectedByUser: false,
        );
      }
    }

    emit(SelectEventActionState(
      eventContent: eventContent,
      eventAction: event.eventAction,
    ));
  }

  FutureOr<void> _onNavigateBackEvent(
      NavigateBackEvent event, Emitter<EventDetailsState> emit) {
    emit(NavigateBackState(event: event.event));
  }

  FutureOr<void> _onCheckForEventDetailsDynamicQuestionEvent(
      CheckForEventDetailsDynamicQuestionEvent event,
      Emitter<EventDetailsState> emit) {
    List<PageField> questionsList = [];
    dynamicQuestions.forEach((element) {
      if (element.eventOptionId == event.eventAction.id) {
        questionsList.add(element);
      }
    });

    for (int i = 0; i < questionsList.length; i++) {
      questionsList[i] = questionsList[i].copyWith(
        value: "",
      );
    }

    emit(CheckForEventDetailsDynamicQuestionState(
        questionsList: questionsList, eventAction: event.eventAction));
  }

  FutureOr<void> _onOnEventDetailsBottomSheetOkClickEvent(
      OnEventDetailsBottomSheetOkClickEvent event,
      Emitter<EventDetailsState> emit) async {
    emit(ShowLoadingState());
    List<EventQuestionRequest> questions = [];
    for (int i = 0; i < event.questions.length; i++) {
      questions.add(EventQuestionRequest(
        id: event.questions[i].id,
        value: event.questions[i].value,
        answerId: event.questions[i].answerId,
        controlTypeCode: event.questions[i].code,
        controlTypeId: event.questions[i].typeId,
        lable: event.questions[i].label,
        isRequired: event.questions[i].isRequired,
      ));
    }
    SubmitEventRequest request = SubmitEventRequest(
      eventid: eventContent.id,
      eventOptionId: event.eventAction.id,
      transactionId: eventContent.transactionId,
      calendarRef: eventContent.calenderRef,
      questionAnswer: questions,
    );
    DataState<SubmitEvent> dataState = await _submitEventUseCase(request);
    if (dataState is DataSuccess) {
      eventContent = eventContent.copyWith(
        transactionId: dataState.data?.transactionId ?? 0,
        memberCount: dataState.data?.countCurrentJoin ?? 0,
      );
      emit(OnEventDetailsBottomSheetOkClickState(
        questions: dataState.data?.fields ?? [],
        eventAction: event.eventAction,
        transactionId: dataState.data?.transactionId ?? 0,
        message: dataState.message ?? "",
      ));
    } else {
      emit(OnEventDetailsBottomSheetOkClickErrorState(
        message: dataState.message ?? "",
      ));
    }
    emit(HideLoadingState());
  }

  FutureOr<void> _onAddEventToCalendarEvent(
      AddEventToCalendarEvent event, Emitter<EventDetailsState> emit) {
    emit(AddEventToCalendarState(
        event: event.event,
        eventAction: event.eventAction,
        eventId: event.eventId,
        title: event.event.title,
        location: event.location,
        description: event.description,
        startDate: event.startDate,
        endDate: event.endDate,
        isAllDay: event.isAllDay));
  }

  FutureOr<void> _onDeleteEventToCalendarEvent(
      DeleteEventFromCalendarEvent event, Emitter<EventDetailsState> emit) {
    emit(DeleteEventToCalendarState(
      eventContent: event.event,
      eventAction: event.eventAction,
      eventId: event.eventId,
    ));
  }

  FutureOr<void> _onSendEventReferenceIdEvent(
      SendEventReferenceIdEvent event, Emitter<EventDetailsState> emit) {
    eventContent = eventContent.copyWith(
      calenderRef: event.eventReferenceId,
    );

    emit(SelectEventActionState(
      eventContent: eventContent,
      eventAction: event.eventAction,
    ));
    emit(SendEventReferenceSuccessIdState());
  }

  FutureOr<void> _onShowCalendarActionDialogEvent(
      ShowCalendarActionDialogEvent event, Emitter<EventDetailsState> emit) {
    emit(ShowCalendarActionDialogState(
      eventAction: event.eventAction,
      questions: event.questions,
    ));
  }

  FutureOr<void> _onGetCompoundConfigurationEvent(
      GetCompoundConfigurationEvent event, Emitter<EventDetailsState> emit) {
    emit(GetCompoundConfigurationState(
        compoundConfiguration: _getLocalCompoundConfigurationUseCase()));
  }

  FutureOr<void> _onDeleteEventReferenceIdEvent(
      DeleteEventReferenceIdEvent event, Emitter<EventDetailsState> emit) {
    eventContent = eventContent.copyWith(
      calenderRef: '',
    );

    emit(SelectEventActionState(
      eventContent: eventContent,
      eventAction: event.eventAction,
    ));

    emit(DeleteEventReferenceIdState(
      questions: event.questions,
      eventAction: event.eventAction,
    ));
  }

  FutureOr<void> _onGetEventDetailsEvent(
      GetEventDetailsEvent event, Emitter<EventDetailsState> emit) async {
    emit(ShowSkeletonState());
    final dataState = await _getEventDetailsUseCase(EventDetailsRequest(
      eventId: event.eventId,
    ));

    if (dataState is DataSuccess) {
      dynamicQuestions = dataState.data?.dynamicQuestions ?? [];
      eventContent = dataState.data?.event ?? const HomeEventItem();
      emit(GetEventDetailsSuccessState(
        eventContent: dataState.data?.event ?? const HomeEventItem(),
        pageFields: dataState.data?.dynamicQuestions ?? [],
        link: dataState.data?.link ?? "",
      ));
    } else {
      emit(EventsDetailsErrorState(
        message: dataState.message ?? "",
      ));
    }
    // emit(HideLoadingState());
  }
}
