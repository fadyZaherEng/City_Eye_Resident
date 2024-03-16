import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/offers_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/survey/requests/survey_submit_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/request/event_question_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/request/submit_event_request.dart';
import 'package:city_eye/src/di/injector.dart';
import 'package:city_eye/src/domain/entities/event/event_data.dart';
import 'package:city_eye/src/domain/entities/event/submit_event.dart';
import 'package:city_eye/src/domain/entities/home/home_compound.dart';
import 'package:city_eye/src/domain/entities/home/home_event_item.dart';
import 'package:city_eye/src/domain/entities/home/notification_count.dart';
import 'package:city_eye/src/domain/entities/survey/survey.dart';
import 'package:city_eye/src/domain/entities/offers/offer.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/domain/usecase/get_is_app_language_changed_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_offers_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/home/filter_home_services_for_specific_service_usecase.dart';
import 'package:city_eye/src/domain/usecase/home/filter_home_services_usecase.dart';
import 'package:city_eye/src/domain/usecase/home/get_home_compound_use_case.dart';
import 'package:city_eye/src/domain/usecase/home/get_notifications_count_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_is_app_language_changed_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/submit_survey_use_case.dart';
import 'package:city_eye/src/domain/usecase/submit_event_use_case.dart';
import 'package:city_eye/src/domain/usecase/switch_language_use_case.dart';
import 'package:city_eye/src/presentation/blocs/home/home_event.dart';
import 'package:city_eye/src/presentation/blocs/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserInformationUseCase _getUserInformationUseCase;
  final GetUserUnitUseCase _getUserUnitUseCase;
  final GetHomeCompoundUseCase _getHomeCompoundUseCase;
  final GetOffersUseCase _getOffersUseCase;
  final FilterHomeServicesUseCase _filterHomeServicesUseCase;
  final FilterHomeServicesForSpecificServiceUseCase
      _filterHomeServicesForSpecificServiceUseCase;
  final SubmitSurveyUseCase _submitSurveyUseCase;
  final SubmitEventUseCase _submitEventUseCase;
  final GetNotificationsCountUseCase _getNotificationsCountUseCase;
  final SetUserUnitUseCase _setUserUnitUseCase;
  final SwitchLanguageUseCase _switchLanguageUseCase;

  HomeBloc(
    this._getUserInformationUseCase,
    this._getUserUnitUseCase,
    this._getHomeCompoundUseCase,
    this._getOffersUseCase,
    this._filterHomeServicesUseCase,
    this._filterHomeServicesForSpecificServiceUseCase,
    this._submitSurveyUseCase,
    this._submitEventUseCase,
    this._getNotificationsCountUseCase,
    this._setUserUnitUseCase,
    this._switchLanguageUseCase,
  ) : super(ShowSkeletonState()) {
    on<NavigateToNotificationScreenEvent>(_onNavigateToNotificationScreenEvent);
    on<GetUserInformationEvent>(_onGetUserInformationEvent);
    on<NavigateToQrScreenEvent>(_onNavigateToQrScreenEvent);
    on<NavigateToSupportDetailScreenEvent>(
        _onNavigateToSupportDetailScreenEvent);
    on<NavigateToServiceDetailScreenEvent>(
        _onNavigateToServiceDetailScreenEvent);
    on<NavigateToEventDetailScreenEvent>(_onNavigateToEventDetailScreenEvent);
    on<SelectEventActionEvent>(_onSelectEventActionEvent);
    on<SendEventNeededInformationEvent>(_onSendEventNeededInformationEvent);
    on<EventSeeAllEvent>(_onEventSeeAllEvent);
    on<SurveySeeAllEvent>(_onSurveySeeAllEvent);
    on<SelectSurveyActionEvent>(_onSelectSurveyActionEvent);
    on<SendSurveyNeededInformationEvent>(_onSendSurveyNeededInformationEvent);
    on<ShowHomeContentEvent>(_onShowHomeContentEvent);
    on<EventCheckForDynamicQuestionEvent>(_onEventCheckForDynamicQuestionEvent);
    on<EventOnBottomSheetOkClickEvent>(_onEventOnBottomSheetOkClickEvent);
    on<AddEventToCalendarEvent>(_onAddEventToCalendarEvent);
    on<DeleteEventFromCalendarEvent>(_onDeleteEventToCalendarEvent);
    on<SendEventReferenceIdEvent>(_onSendEventReferenceIdEvent);
    on<GetOffersDataEvent>(_onGetOffersDataEvent);
    on<FilterServiceAccordingToParentIdEvent>(
        _onFilterServiceAccordingToParentIdEvent);
    on<FilterServicesAccordingBySpecificServiceEvent>(
        _onFilterServicesAccordingBySpecificServiceEvent);
    on<ShowCalendarActionDialogEvent>(_onShowCalendarActionDialogEvent);
    on<DeleteEventReferenceIdEvent>(_onDeleteEventReferenceIdEvent);
    on<OnTapOfferEvent>(_onOnTapOfferEvent);
    on<GetNotificationCountEvent>(_onGetNotificationCountEvent);
  }

  EventData eventData = EventData(
    events: const [],
    dynamicQuestions: const [],
  );

  List<Survey> surveyData = [];

  void _onNavigateToNotificationScreenEvent(
      NavigateToNotificationScreenEvent event, Emitter<HomeState> emit) {
    emit(NavigateToNotificationScreenState());
  }

  void _onNavigateToQrScreenEvent(
      NavigateToQrScreenEvent event, Emitter<HomeState> emit) {
    emit(NavigateToQrScreenState());
  }

  void _onNavigateToSupportDetailScreenEvent(
      NavigateToSupportDetailScreenEvent event, Emitter<HomeState> emit) {
    emit(NavigateToSupportDetailScreenState(support: event.support));
  }

  void _onNavigateToServiceDetailScreenEvent(
      NavigateToServiceDetailScreenEvent event, Emitter<HomeState> emit) {
    emit(NavigateToServiceDetailScreenState(service: event.service));
  }

  void _onNavigateToEventDetailScreenEvent(
      NavigateToEventDetailScreenEvent event, Emitter<HomeState> emit) {
    emit(NavigateToEventDetailScreenState(event: event.event));
  }

  void _onSelectEventActionEvent(
      SelectEventActionEvent event, Emitter<HomeState> emit) {
    for (int i = 0; i < eventData.events.length; i++) {
      if (eventData.events[i].id == event.event.id) {
        eventData.events[i] = eventData.events[i].copyWith(
          transactionId: event.event.transactionId,
          memberCount: event.event.memberCount,
        );
        eventData.events[i] = eventData.events[i].copyWith(
          showTotalMembers: true,
        );
        for (int j = 0; j < eventData.events[i].eventsOptions.length; j++) {
          if (eventData.events[i].eventsOptions[j].id == event.eventAction.id) {
            eventData.events[i].eventsOptions[j] =
                eventData.events[i].eventsOptions[j].copyWith(
              isSelectedByUser: true,
            );
          } else {
            eventData.events[i].eventsOptions[j] =
                eventData.events[i].eventsOptions[j].copyWith(
              isSelectedByUser: false,
            );
          }
        }
      } else {
        eventData.events[i] = eventData.events[i].copyWith(
          showTotalMembers: false,
        );
      }
    }

    emit(UpdateEventActionState(
      events: eventData.events,
    ));
  }

  void _onSendEventNeededInformationEvent(
      SendEventNeededInformationEvent event, Emitter<HomeState> emit) {
    emit(SendEventNeededInformationState());
  }

  void _onEventSeeAllEvent(EventSeeAllEvent event, Emitter<HomeState> emit) {
    emit(NavigateToEventsScreenState());
  }

  void _onSurveySeeAllEvent(SurveySeeAllEvent event, Emitter<HomeState> emit) {
    emit(NavigateToSurveyScreenState());
  }

  void _onSelectSurveyActionEvent(
      SelectSurveyActionEvent event, Emitter<HomeState> emit) async {
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

        for (var i = 0; i < surveyData.length; i++) {
          if (surveyData[i].id == surveyResponse.id) {
            surveyData[i] = surveyResponse;
            for (var j = 0;
                j < surveyData[i].surveyQuestionChoice.length;
                j++) {
              if (surveyData[i].surveyQuestionChoice[j].id.toString() ==
                  surveyResponse.value) {
                surveyData[i].surveyQuestionChoice[j] =
                    surveyData[i].surveyQuestionChoice[j].copyWith(
                          isSelected: true,
                        );
                surveyData[i].selectAction =
                    surveyData[i].surveyQuestionChoice[j];
                if (surveyData[i].selectAction?.isNeedMoreInformation ==
                    false) {
                  surveyData[i].selectAction =
                      surveyData[i].selectAction?.copyWith(
                            showPercentage: true,
                            isSelected: true,
                          );
                } else {
                  surveyData[i].selectAction =
                      surveyData[i].selectAction?.copyWith(
                            showPercentage: false,
                            isSelected: false,
                          );
                }
                break;
              }
            }
            if (surveyData[i].selectAction?.isNeedMoreInformation == false) {
              surveyData[i].selectAction = surveyData[i].selectAction?.copyWith(
                    showPercentage: true,
                    isSelected: true,
                  );
            } else {
              surveyData[i].selectAction = surveyData[i].selectAction?.copyWith(
                    showPercentage: false,
                    isSelected: true,
                  );
            }

            break;
          }
        }

        emit(SubmitSurveySuccessState(survey: surveyData));
      } else {
        emit(SubmitSurveyFailedState(
          errorMessage: dataState.message ?? "",
        ));
      }

      emit(UpdateSurveyActionState(
          surveys: surveyData, selectedSurveyAction: event.surveyAction));
    }

    emit(HideLoadingState());
    emit(UpdateSurveyActionState(
        surveys: surveyData, selectedSurveyAction: event.surveyAction));
  }

  void _onSendSurveyNeededInformationEvent(
      SendSurveyNeededInformationEvent event, Emitter<HomeState> emit) {
    for (var i = 0; i < surveyData.length; i++) {
      if (surveyData[i].id == event.survey.id) {
        surveyData[i].surveyQuestionChoice.forEach((element) {
          if (element.id == event.survey.selectAction?.id) {
            element.copyWith(
              isNeedMoreInformation: false,
              showPercentage: true,
            );
          }
        });
        break;
      }
    }
    emit(UpdateSurveyActionState(
        surveys: surveyData, selectedSurveyAction: event.survey.selectAction!));
  }

  HomeCompound _homeCompound = HomeCompound();

  void _onShowHomeContentEvent(
      ShowHomeContentEvent event, Emitter<HomeState> emit) async {
    // emit(ShowSkeletonState());
    // final DataState dataState = await _getHomeCompoundUseCase();

    if (true) {
      // var response = dataState.data as HomeCompound;
      _homeCompound = event.homeCompound;
      eventData.events = _homeCompound.events;
      _handleEventData(_homeCompound.events);
      surveyData = _homeCompound.surveys;
      _handleSurveyData(_homeCompound.surveys);

      emit(GetHomeContentSuccessState(homeCompound: _homeCompound));
    } else {
      // emit(GetHomeContentFailedState(
      //   errorMessage: dataState.message ?? "",
      // ));
    }
  }

  FutureOr<void> _onGetUserInformationEvent(
      GetUserInformationEvent event, Emitter<HomeState> emit) async {
    User user = _getUserInformationUseCase();
    UserUnit userUnit;

    if (GetIsAppLanguageChangedUseCase(injector())() == true) {
      DataState<UserUnit> dataState = await _switchLanguageUseCase();
      if (dataState is DataSuccess) {
        userUnit = dataState.data ?? const UserUnit();
        await _setUserUnitUseCase(userUnit);
        await SetIsAppLanguageChangedUseCase(injector())(false);
      } else {
        userUnit = _getUserUnitUseCase();
      }
    } else {
      userUnit = _getUserUnitUseCase();
    }

    emit(GetUserInformationState(
      user: user,
      userUnit: userUnit,
    ));
  }

  FutureOr<void> _onEventCheckForDynamicQuestionEvent(
      EventCheckForDynamicQuestionEvent event, Emitter<HomeState> emit) {
    List<PageField> questionsList = [];
    for (var element in eventData.dynamicQuestions) {
      if (element.eventOptionId == event.eventAction.id) {
        questionsList.add(element);
      }
    }

    for (int i = 0; i < questionsList.length; i++) {
      questionsList[i] = questionsList[i].copyWith(
        value: "",
      );
    }

    emit(EventCheckForDynamicQuestionState(
        questionsList: questionsList,
        event: event.event,
        eventAction: event.eventAction));
  }

  FutureOr<void> _onEventOnBottomSheetOkClickEvent(
      EventOnBottomSheetOkClickEvent event, Emitter<HomeState> emit) async {
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
      HomeEventItem homeEventItem = event.event.copyWith(
        transactionId: dataState.data?.transactionId,
        memberCount: dataState.data?.countCurrentJoin ?? 0,
      );
      emit(EventOnBottomSheetOkClickState(
        questions: event.questions,
        event: homeEventItem,
        eventAction: event.eventAction,
        allQuestions: dataState.data?.fields ?? [],
        message: dataState.message ?? "",
      ));
    } else {
      emit(GetHomeContentFailedState(
        errorMessage: dataState.message ?? "",
      ));
    }
    emit(HideLoadingState());
  }

  FutureOr<void> _onAddEventToCalendarEvent(
      AddEventToCalendarEvent event, Emitter<HomeState> emit) {
    emit(AddEventToCalendarState(
        event: event.event,
        eventAction: event.eventAction,
        startDate: event.startDate,
        endDate: event.endDate,
        isAllDay: event.isAllDay));
  }

  FutureOr<void> _onDeleteEventToCalendarEvent(
      DeleteEventFromCalendarEvent event, Emitter<HomeState> emit) {
    emit(DeleteEventToCalendarState(
      eventContent: event.event,
      eventAction: event.eventAction,
      eventId: event.eventId,
    ));
  }

  FutureOr<void> _onSendEventReferenceIdEvent(
      SendEventReferenceIdEvent event, Emitter<HomeState> emit) {
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

  FutureOr<void> _onGetOffersDataEvent(
      GetOffersDataEvent event, Emitter<HomeState> emit) async {
    emit(ShowSkeletonState());
    DataState dataState = await _getOffersUseCase(event.request);
    if (dataState is DataSuccess) {
      emit(GetOffersDataSuccessState(offers: dataState.data as List<Offer>));
    } else {
      emit(GetOffersDataFailedState(message: dataState.message ?? ""));
    }
  }

  FutureOr<void> _onFilterServiceAccordingToParentIdEvent(
      FilterServiceAccordingToParentIdEvent event,
      Emitter<HomeState> emit) async {
    final filteredHomeServices = _filterHomeServicesUseCase(event.homeServices);
    emit(GetServicesAfterFilterationState(
        filteredServices: filteredHomeServices));
  }

  FutureOr<void> _onFilterServicesAccordingBySpecificServiceEvent(
      FilterServicesAccordingBySpecificServiceEvent event,
      Emitter<HomeState> emit) async {
    final filteredHomeServices = _filterHomeServicesForSpecificServiceUseCase(
      event.homeServices,
      event.homeService,
    );
    emit(GetServicesAfterFilterationForSpecificServiceState(
        filteredServices: filteredHomeServices));
  }

  void _handleEventData(List<HomeEventItem> events) {
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

  void _handleSurveyData(List<Survey> surveys) {
    for (var i = 0; i < surveyData.length; i++) {
      if (surveyData[i].flage) {
        for (var j = 0; j < surveyData[i].surveyQuestionChoice.length; j++) {
          if (surveyData[i].surveyQuestionChoice[j].id.toString() ==
              surveyData[i].value) {
            surveyData[i].surveyQuestionChoice[j] =
                surveyData[i].surveyQuestionChoice[j].copyWith(
                      isSelected: true,
                    );
            surveyData[i].selectAction = surveyData[i].surveyQuestionChoice[j];
            if (surveyData[i].selectAction?.isNeedMoreInformation == false) {
              surveyData[i].selectAction = surveyData[i].selectAction?.copyWith(
                    showPercentage: true,
                    isSelected: true,
                  );
            } else {
              surveyData[i].selectAction = surveyData[i].selectAction?.copyWith(
                    showPercentage: false,
                    isSelected: false,
                  );
            }
            break;
          }
        }
      }
    }
  }

  FutureOr<void> _onShowCalendarActionDialogEvent(
      ShowCalendarActionDialogEvent event, Emitter<HomeState> emit) {
    emit(ShowCalendarActionDialogState(
      event: event.event,
      eventAction: event.eventAction,
      questions: event.questions,
    ));
  }

  FutureOr<void> _onDeleteEventReferenceIdEvent(
      DeleteEventReferenceIdEvent event, Emitter<HomeState> emit) {
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

  FutureOr<void> _onOnTapOfferEvent(
      OnTapOfferEvent event, Emitter<HomeState> emit) {
    if (event.offer.iSRedirectUrl) {
      emit(OnTapOfferNavigateToWebViewState(offer: event.offer));
    } else if (event.offer.destinationMobilePages != null) {
      if (event.offer.destinationMobilePages!.code == "Events") {
        emit(OnTapOfferNavigateToEventState(offer: event.offer));
      }
    }
  }

  FutureOr<void> _onGetNotificationCountEvent(
      GetNotificationCountEvent event, Emitter<HomeState> emit) async {
    DataState<NotificationCount> dataState =
        await _getNotificationsCountUseCase();
    if (dataState is DataSuccess) {
      NotificationCount notificationCount =
          dataState.data ?? const NotificationCount();
      emit(GetNotificationCountSuccessState(
        count: notificationCount.count,
      ));
    } else {
      emit(GetHomeContentFailedState(
        errorMessage: dataState.message ?? "",
      ));
    }
  }
}
