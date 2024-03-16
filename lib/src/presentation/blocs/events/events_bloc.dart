import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/request/event_question_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/request/submit_event_request.dart';
import 'package:city_eye/src/domain/entities/event/event_data.dart';
import 'package:city_eye/src/domain/entities/event/submit_event.dart';
import 'package:city_eye/src/domain/entities/gallery/sort.dart';
import 'package:city_eye/src/domain/entities/home/home_event_item.dart';
import 'package:city_eye/src/domain/entities/home/home_event_option.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/usecase/get_events_use_case.dart';
import 'package:city_eye/src/domain/usecase/sort_events_use_case.dart';
import 'package:city_eye/src/domain/usecase/submit_event_use_case.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'events_event.dart';

part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final SortEventsUseCase _sortEventsUseCase;
  final GetEventsUseCase _getEventsUseCase;
  final SubmitEventUseCase _submitEventUseCase;
  Sort _selectedSort = const Sort(
    id: 1,
    name: "",
  );
  EventData eventData = EventData(
    events: const [],
    dynamicQuestions: const [],
  );

  EventsBloc(
    this._sortEventsUseCase,
    this._getEventsUseCase,
    this._submitEventUseCase,
  ) : super(EventsInitial()) {
    on<OpenSortBottomSheetEvent>(_onOpenSortBottomSheetEvent);
    on<SelectSortEvent>(_onSelectSortEvent);
    on<GetEventsEvent>(_onGetEventsEvent);
    on<SearchEventsEvent>(_onSearchEventsEvent);
    on<NavigateToEventDetailsScreen>(_onNavigateToEventDetailsScreen);
    on<NavigateBackEvent>(_onNavigateBackEvent);
    on<SelectEventActionEvent>(_onSelectEventActionEvent);
    on<SortEventsEvent>(_onSortEventsEvent);
    on<CheckForDynamicQuestionEvent>(_onCheckForDynamicQuestionEvent);
    on<OnBottomSheetOkClickEvent>(_onOnBottomSheetOkClickEvent);
    on<AddEventToCalendarEvent>(_onAddEventToCalendarEvent);
    on<DeleteEventFromCalendarEvent>(_onDeleteEventToCalendarEvent);
    on<SendEventReferenceIdEvent>(_onSendEventReferenceIdEvent);
    on<ShowCalendarActionDialogEvent>(_onShowCalendarActionDialogEvent);
    on<DeleteEventReferenceIdEvent>(_onDeleteEventReferenceIdEvent);
    on<ScrollToItemEvent>(_onScrollToItemEvent);
  }

  FutureOr<void> _onGetEventsEvent(
      GetEventsEvent event, Emitter<EventsState> emit) async {
    emit(ShowSkeletonState());
    DataState dataState = await _getEventsUseCase();
    if (dataState is DataSuccess) {
      eventData = dataState.data as EventData;
      // _selectedSort = const Sort(
      //   id: 1,
      //   name: "",
      // );
      eventData.events = _sortEventsUseCase(
        eventData.events,
        _selectedSort,
      );
      _handleEventData();
      for (var i = 0; i < eventData.events.length; i++) {
        GlobalKey key = GlobalKey();
        eventData.events[i] = eventData.events[i].copyWith(key: key);
      }
      for(int i = 0; i < eventData.dynamicQuestions.length; i++) {
        eventData.dynamicQuestions[i] = eventData.dynamicQuestions[i].copyWith(isRequired: true);
      }
      emit(GetEventsSuccessState(events: dataState.data as EventData));
    } else {
      emit(GetEventsErrorState(errorMessage: dataState.message ?? ""));
    }
  }

  FutureOr<void> _onSearchEventsEvent(
      SearchEventsEvent event, Emitter<EventsState> emit) {
    List<HomeEventItem> events = eventData.events
        .where((element) =>
            element.title.toLowerCase().contains(event.value.toLowerCase()))
        .toList();
    _sortEventsUseCase(
      eventData.events,
      _selectedSort,
    );
    emit(SearchEventsState(value: event.value, events: events));
  }

  FutureOr<void> _onNavigateToEventDetailsScreen(
      NavigateToEventDetailsScreen event, Emitter<EventsState> emit) {
    emit(NavigateToEventDetailsScreenState(
      event: event.event,
    ));
  }

  FutureOr<void> _onNavigateBackEvent(
      NavigateBackEvent event, Emitter<EventsState> emit) {
    emit(NavigateBackState(events: event.events));
  }

  FutureOr<void> _onOpenSortBottomSheetEvent(
      OpenSortBottomSheetEvent event, Emitter<EventsState> emit) {
    emit(OpenSortBottomSheetState());
  }

  void _onSelectEventActionEvent(
      SelectEventActionEvent event, Emitter<EventsState> emit) {
    for (int i = 0; i < eventData.events.length; i++) {
      if (eventData.events[i].id == event.event.id) {
        eventData.events[i] = eventData.events[i].copyWith(
          transactionId: event.event.transactionId,
          memberCount: event.event.memberCount,
          showTotalMembers: true,
        );
        for (int j = 0; j < eventData.events[i].eventsOptions.length; j++) {
          if (eventData.events[i].eventsOptions[j].id == event.eventAction.id) {
            eventData.events[i].eventsOptions[j] =
                eventData.events[i].eventsOptions[j].copyWith(
              isSelectedByUser: true,
            );
            eventData.events[i] = eventData.events[i]
                .copyWith(selectAction: eventData.events[i].eventsOptions[j]);
          } else {
            eventData.events[i].eventsOptions[j] =
                eventData.events[i].eventsOptions[j].copyWith(
              isSelectedByUser: false,
            );
            eventData.events[i] = eventData.events[i]
                .copyWith(selectAction: eventData.events[i].eventsOptions[j]);
          }
        }
      }
    }
    emit(UpdateEventActionState(events: eventData.events));
  }

  FutureOr<void> _onSelectSortEvent(
      SelectSortEvent event, Emitter<EventsState> emit) {
    _selectedSort = event.sort;
    emit(SelectSortState(sort: event.sort));
  }

  FutureOr<void> _onSortEventsEvent(
      SortEventsEvent event, Emitter<EventsState> emit) {
    emit(
      SortEventsState(
        events: _sortEventsUseCase(event.events, event.sort),
      ),
    );
  }

  FutureOr<void> _onCheckForDynamicQuestionEvent(
      CheckForDynamicQuestionEvent event, Emitter<EventsState> emit) {
    List<PageField> questionsList = [];
    eventData.dynamicQuestions.forEach((element) {
      if (element.eventOptionId == event.eventAction.id) {
        questionsList.add(element);
      }
    });

    for (int i = 0; i < questionsList.length; i++) {
      questionsList[i] = questionsList[i].copyWith(
        value: "",
      );
    }

    emit(CheckForDynamicQuestionState(
        questionsList: questionsList,
        event: event.event,
        eventAction: event.eventAction));
  }

  FutureOr<void> _onOnBottomSheetOkClickEvent(
      OnBottomSheetOkClickEvent event, Emitter<EventsState> emit) async {
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
      eventid: event.event.id,
      eventOptionId: event.eventAction.id,
      transactionId: event.event.transactionId,
      calendarRef: event.event.calenderRef,
      questionAnswer: questions,
    );
    DataState<SubmitEvent> dataState = await _submitEventUseCase(request);
    if (dataState is DataSuccess) {
      HomeEventItem eventItem = event.event.copyWith(
        transactionId: dataState.data?.transactionId ?? 0,
        memberCount: dataState.data?.countCurrentJoin ?? 0,
      );
      emit(OnBottomSheetOkClickState(
          questions: dataState.data?.fields ?? [],
          event: eventItem,
          eventAction: event.eventAction,
          message: dataState.message ?? ""));
    } else {
      emit(GetEventsErrorState(
        errorMessage: dataState.message ?? "",
      ));
    }
    emit(HideLoadingState());
  }

  FutureOr<void> _onAddEventToCalendarEvent(
      AddEventToCalendarEvent event, Emitter<EventsState> emit) {
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
      DeleteEventFromCalendarEvent event, Emitter<EventsState> emit) {
    emit(DeleteEventToCalendarState(
      eventContent: event.event,
      eventAction: event.eventAction,
      eventId: event.eventId,
    ));
  }

  FutureOr<void> _onSendEventReferenceIdEvent(
      SendEventReferenceIdEvent event, Emitter<EventsState> emit) {
    for (var i = 0; i < eventData.events.length; i++) {
      if (eventData.events[i].id == event.event.id) {
        eventData.events[i] = eventData.events[i].copyWith(
          calenderRef: event.eventReferenceId,
        );
        break;
      }
    }
    emit(UpdateEventActionState(
      events: eventData.events,
    ));
    emit(SendEventReferenceSuccessIdState());
  }

  FutureOr<void> _onDeleteEventReferenceIdEvent(
      DeleteEventReferenceIdEvent event, Emitter<EventsState> emit) {
    for (var i = 0; i < eventData.events.length; i++) {
      if (eventData.events[i].id == event.event.id) {
        eventData.events[i] = eventData.events[i].copyWith(
          calenderRef: '',
        );
        break;
      }
    }

    emit(UpdateEventActionState(
      events: eventData.events,
    ));

    emit(DeleteEventReferenceIdState(
      questions: event.questions,
      event: event.event,
      eventAction: event.eventAction,
    ));
  }

  FutureOr<void> _onShowCalendarActionDialogEvent(
      ShowCalendarActionDialogEvent event, Emitter<EventsState> emit) {
    emit(ShowCalendarActionDialogState(
      event: event.event,
      eventAction: event.eventAction,
      questions: event.questions,
    ));
  }

  void _handleEventData() {
    for (var i = 0; i < eventData.events.length; i++) {
      for (var j = 0; j < eventData.events[i].eventsOptions.length; j++) {
        if (eventData.events[i].eventsOptions[j].isSelectedByUser) {
          eventData.events[i] = eventData.events[i].copyWith(
            showTotalMembers: true,
          );
          break;
        } else {
          eventData.events[i] = eventData.events[i].copyWith(
            showTotalMembers: false,
          );
        }
      }
    }
  }

  FutureOr<void> _onScrollToItemEvent(
      ScrollToItemEvent event, Emitter<EventsState> emit) {
    emit(ScrollToItemState(key: event.key));
  }
}
