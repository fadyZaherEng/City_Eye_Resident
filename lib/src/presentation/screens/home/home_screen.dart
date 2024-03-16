import 'dart:developer';
import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/open_daynamic_questions_bottom_sheet.dart';
import 'package:city_eye/src/core/utils/permission_service_handler.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/data/sources/local/singleton/services/my_service_singleton.dart';
import 'package:city_eye/src/data/sources/local/singleton/support/my_support_singleton.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/offers_request.dart';
import 'package:city_eye/src/domain/entities/event/event_data.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:city_eye/src/domain/entities/gallery/images_screen.dart';
import 'package:city_eye/src/domain/entities/home/home_compound.dart';
import 'package:city_eye/src/domain/entities/home/home_event_item.dart';
import 'package:city_eye/src/domain/entities/home/home_event_option.dart';
import 'package:city_eye/src/domain/entities/home/home_section_item.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:city_eye/src/domain/entities/home/notification_count.dart';
import 'package:city_eye/src/domain/entities/offers/offer.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/domain/entities/survey/survey_question_choice.dart';
import 'package:city_eye/src/domain/entities/survey/survey.dart';
import 'package:city_eye/src/presentation/blocs/home/home_bloc.dart';
import 'package:city_eye/src/presentation/blocs/home/home_event.dart';
import 'package:city_eye/src/presentation/blocs/home/home_state.dart';
import 'package:city_eye/src/presentation/screens/home/skeleton/skeleton_home_widget.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/event_section.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/home_header_section.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/qr_section.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/services_section.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/support_section.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/survey_section.dart';
import 'package:city_eye/src/presentation/widgets/empty_widget.dart';
import 'package:city_eye/src/presentation/widgets/slider_widget.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends BaseStatefulWidget {
  final HomeCompound homeCompound;

  const HomeScreen({
    Key? key,
    required this.homeCompound,
  }) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _HomeScreenState();
}

NotificationCount notificationCount = const NotificationCount(count: 0);

class _HomeScreenState extends BaseState<HomeScreen> {
  HomeBloc get _bloc => BlocProvider.of<HomeBloc>(context);
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();
  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _surveyController = TextEditingController();

  List<HomeCompoundItem> homeSections = [];
  List<Offer> _offers = [];

  List<HomeSupport> supports = const [];

  List<HomeService> _homeServices = [];
  List<HomeService> _filteredServices = [];
  List<HomeService> _filteredServicesForSpecificService = [];

  EventData eventData = EventData(events: const [], dynamicQuestions: const []);
  List<PageField> extraFieldEvents = [];

  List<Survey> surveyData = [];
  User user = User();
  UserUnit userUnit = UserUnit();

  var calendarId = '';

  @override
  void initState() {
    surveyData = _bloc.surveyData;
    eventData = _bloc.eventData;

    _bloc.add(GetUserInformationEvent());
    _bloc.add(
        GetOffersDataEvent(request: OffersRequest(pageCode: "compundHome")));
    _bloc.add(ShowHomeContentEvent(homeCompound: widget.homeCompound));
    super.initState();
  }

  MyServiceSingleton get _myServiceSingleton => MyServiceSingleton();

  MySupportSingleton get _mySupportSingleton => MySupportSingleton();

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
      if (state is ShowLoadingState) {
        showLoading();
      } else if (state is HideLoadingState) {
        hideLoading();
      } else if (state is GetOffersDataSuccessState) {
        _offers = state.offers;
      } else if (state is GetOffersDataFailedState) {
        showSnackBar(
          context: context,
          message: state.message,
          color: ColorSchemes.snackBarError,
          icon: ImagePaths.error,
        );
      } else if (state is SubmitSurveySuccessState) {
        surveyData = state.survey;
      } else if (state is SubmitSurveyFailedState) {
        showSnackBar(
          context: context,
          message: state.errorMessage,
          color: ColorSchemes.snackBarError,
          icon: ImagePaths.error,
        );
      } else if (state is GetHomeContentSuccessState) {
        homeSections = state.homeCompound.homeSections;
        _homeServices = state.homeCompound.servicesCategories;
        _myServiceSingleton.homeServices = _homeServices;
        if (_homeServices.isNotEmpty) {
          _bloc.add(
            FilterServiceAccordingToParentIdEvent(
              homeServices: _homeServices,
            ),
          );
        }
        supports = state.homeCompound.supportCategories;
        _mySupportSingleton.supports = supports;
        eventData.events = state.homeCompound.events;
        eventData.dynamicQuestions = state.homeCompound.extraFieldEvents;
        surveyData = state.homeCompound.surveys;
        _getNotificationsCountEvent();
      } else if (state is GetServicesAfterFilterationState) {
        _filteredServices = state.filteredServices;
        _myServiceSingleton.filteredServices = _filteredServices;
      } else if (state is GetServicesAfterFilterationForSpecificServiceState) {
        _filteredServicesForSpecificService = state.filteredServices;
      } else if (state is GetHomeContentFailedState) {
        showSnackBar(
          context: context,
          message: state.errorMessage,
          color: ColorSchemes.snackBarError,
          icon: ImagePaths.error,
        );
      }
      if (state is NavigateToNotificationScreenState) {
        Navigator.pushNamed(context, Routes.notifications, arguments: {
          "id": -1,
        }).then(
          (value) => _getNotificationsCountEvent(),
        );
      } else if (state is NavigateToQrScreenState) {
        Navigator.pushNamed(context, Routes.qr).then(
          (value) => _getNotificationsCountEvent(),
        );
      } else if (state is NavigateToSupportDetailScreenState) {
        Navigator.pushNamed(context, Routes.supportDetails, arguments: {
          "supportServices": supports,
          "selectedSupportService": state.support,
          "isFromSupportScreen": false,
        }).then(
          (value) => _getNotificationsCountEvent(),
        );
      } else if (state is NavigateToServiceDetailScreenState) {
        Navigator.pushNamed(
          context,
          Routes.serviceDetails,
          arguments: {
            "homeServices": _filteredServicesForSpecificService,
            "homeService": state.service,
            "isFromHome": true,
          },
        ).then(
          (value) => _getNotificationsCountEvent(),
        );
      } else if (state is NavigateToEventDetailScreenState) {
        Navigator.pushNamed(
          context,
          Routes.eventDetails,
          arguments: {
            "eventId": state.event.id,
          },
        ).then((value) {
          if (value != null) {
            for (int i = 0; i < eventData.events.length; i++) {
              if (eventData.events[i].id == (value as HomeEventItem).id) {
                eventData.events[i] = value.copyWith(
                  showTotalMembers: false,
                );

                for (int j = 0;
                    j < eventData.events[i].eventsOptions.length;
                    j++) {
                  if (eventData.events[i].eventsOptions[j].isSelectedByUser) {
                    eventData.events[i] = value.copyWith(
                      showTotalMembers: true,
                    );
                  }
                }

                break;
              }
            }
            setState(() {});
          }
          _getNotificationsCountEvent();
        });
      } else if (state is GetUserInformationState) {
        user = state.user;
        userUnit = state.userUnit;
      } else if (state is UpdateEventActionState) {
        eventData.events = state.events;
      } else if (state is NavigateToEventsScreenState) {
        Navigator.pushNamed(context, Routes.events, arguments: {
          "id": -1,
        }).then((value) {
          if (value != null) {
            List<HomeEventItem> updatedEvents = value as List<HomeEventItem>;
            for (int i = 0; i < eventData.events.length; i++) {
              for (int j = 0; j < updatedEvents.length; j++) {
                if (eventData.events[i].id == updatedEvents[j].id) {
                  eventData.events[i] = updatedEvents[j].copyWith(
                    showTotalMembers: false,
                  );

                  for (int k = 0;
                      k < eventData.events[i].eventsOptions.length;
                      k++) {
                    if (eventData.events[i].eventsOptions[k].isSelectedByUser) {
                      eventData.events[i] = updatedEvents[j].copyWith(
                        showTotalMembers: true,
                      );
                    }
                  }
                }
              }
            }
            setState(() {});
          }
          _getNotificationsCountEvent();
        });
      } else if (state is NavigateToSurveyScreenState) {
        Navigator.pushNamed(context, Routes.surveys, arguments: {
          "id": -1,
        }).then((value) {
          if (value != null) {
            List<Survey> updatedSurveys = value as List<Survey>;
            for (int i = 0; i < surveyData.length; i++) {
              for (int j = 0; j < updatedSurveys.length; j++) {
                if (surveyData[i].id == updatedSurveys[j].id) {
                  surveyData[i] = updatedSurveys[j];
                }
              }
            }
            setState(() {});
          }
          _getNotificationsCountEvent();
        });
      } else if (state is UpdateSurveyActionState) {
        surveyData = state.surveys;
      } else if (state is EventCheckForDynamicQuestionState) {
        if (!state.eventAction.isSelectedByUser) {
          if (state.questionsList.isNotEmpty) {
            _openEventDynamicQuestionBottomSheet(
              questions: state.questionsList,
              event: state.event,
              eventAction: state.eventAction,
            );
          } else {
            if (state.eventAction.isCalendar && Platform.isAndroid) {
              _bloc.add(ShowCalendarActionDialogEvent(
                  event: state.event, eventAction: state.eventAction));
            } else {
              if (state.event.calenderRef != "") {
                _deleteFromCalenderEvent(
                    event: state.event,
                    eventAction: state.eventAction,
                    eventId: state.event.calenderRef);
              } else {
                _bloc.add(EventOnBottomSheetOkClickEvent(
                  questions: [],
                  event: state.event,
                  eventAction: state.eventAction,
                ));
              }
            }
          }
        }
      } else if (state is EventOnBottomSheetOkClickState) {
        _selectEventAction(
          eventAction: state.eventAction,
          event: state.event,
        );
        showSnackBar(
          context: context,
          message: state.eventAction.isJoin
              ? S.of(context).eventJoinMessage
              : S.of(context).eventNotJoinMessage,
          color: ColorSchemes.snackBarSuccess,
          icon: ImagePaths.success,
        );
      } else if (state is AddEventToCalendarState) {
        handleEventToCalendar(
            event: state.event,
            eventAction: state.eventAction,
            startDate: state.startDate,
            endDate: state.endDate,
            isAllDay: false);
      } else if (state is DeleteEventToCalendarState) {
        deleteCalendarEvent(
          event: state.eventContent,
          eventAction: state.eventAction,
          calendarId: calendarId,
        );
      } else if (state is ShowCalendarActionDialogState) {
        _showCalenderActionDialog(
            event: state.event,
            eventAction: state.eventAction,
            questions: state.questions);
      } else if (state is SendEventReferenceSuccessIdState) {
      } else if (state is DeleteEventReferenceIdState) {
        _bloc.add(EventOnBottomSheetOkClickEvent(
          questions: state.questions,
          event: state.event,
          eventAction: state.eventAction,
        ));
      } else if (state is OnTapOfferNavigateToWebViewState) {
        Navigator.pushNamed(context, Routes.webContent, arguments: {
          "screenTitle": state.offer.title,
          "content": state.offer.redirectUrl,
          "isLink": true,
        }).then(
          (value) => _getNotificationsCountEvent(),
        );
      } else if (state is OnTapOfferNavigateToEventState) {
        Navigator.pushNamed(
          context,
          Routes.eventDetails,
          arguments: {
            "eventId": state.offer.destinationSourceId,
          },
        ).then(
          (value) => _getNotificationsCountEvent(),
        );
      } else if (state is GetNotificationCountSuccessState) {
        notificationCount = NotificationCount(count: state.count);
      } else if (state is GetNotificationCountFailedState) {}
    }, builder: (context, state) {
      if (state is ShowSkeletonState) {
        return const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                SkeletonHomeWidget(),
              ],
            ),
          ),
        );
      } else {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeHeaderSection(
                          user: user,
                          userUnit: userUnit,
                          notificationCount: notificationCount,
                          onNotificationTapped: () {
                            _navigateToNotificationScreen();
                          },
                          onTapImageProfile: (image) {
                            _onTapProfileImage(image);
                          }),
                      const SizedBox(height: 28),
                      Visibility(
                        visible: _offers.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SliderWidget(
                            height: 160,
                            offers: _offers,
                            onTap: (offer) {
                              _onTapOfferEvent(offer: offer);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _offers.isNotEmpty,
                        child: const SizedBox(height: 36),
                      ),
                      QrSection(
                        userUnit: userUnit,
                        onTap: () {
                          _navigateToQrScreenEvent();
                        },
                      ),
                      const SizedBox(height: 32),
                      Visibility(
                        visible: _checkVisibility("SUPPORT"),
                        child: SupportSection(
                          items: supports,
                          onTap: (support) {
                            _navigateToSupportDetailScreenEvent(
                                support: support);
                          },
                        ),
                      ),
                      Visibility(
                        visible: _checkVisibility("SUPPORT"),
                        child: const SizedBox(height: 33),
                      ),
                      Visibility(
                        visible: _checkVisibility("SERVICES"),
                        child: ServiceSection(
                          services: _filteredServices,
                          onTap: (service) {
                            log("SERVICE => ${service.name} => ${service.id}");
                            _bloc.add(
                              FilterServicesAccordingBySpecificServiceEvent(
                                homeServices: _homeServices,
                                homeService: service,
                              ),
                            );
                            _navigateToServiceDetailScreenEvent(
                              service: service,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _checkVisibility("EVENTS"),
                    child: eventData.events.isEmpty
                        ? _buildEmptySection(
                            S.of(context).events,
                            S.of(context).noEvents,
                            ImagePaths.emptyEventsHome,
                            16.0,
                            40,
                          )
                        : Container(
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(246, 246, 248, 1),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  topLeft: Radius.circular(40)),
                            ),
                            child: EventSection(
                              events: eventData.events,
                              onCardTap: (value) {
                                _navigateToEventDetailScreenEvent(event: value);
                              },
                              onActionSelected: (event, eventAction) {
                                if (DateTime.now().isBefore(
                                    DateTime.parse(event.closedDate))) {
                                  _checkForEventDynamicQuestion(
                                      event: event, eventAction: eventAction);
                                }
                              },
                              onSendAction: () {
                                _sendEventNeededInformationEvent();
                              },
                              eventTextEditingController: _eventController,
                              onTapSeeAll: () {
                                _eventSeeAllEvent();
                              },
                            )),
                  ),
                  Visibility(
                    visible: _checkVisibility("SURVEY"),
                    child: surveyData.isEmpty
                        ? _buildEmptySection(
                            S.of(context).survey,
                            S.of(context).noSurveys,
                            ImagePaths.emptySurveysHome,
                            0.0,
                            0,
                          )
                        : Container(
                            color: const Color.fromRGBO(246, 246, 248, 1),
                            child: SurveySection(
                              surveys: surveyData,
                              onCardTap: (value) {},
                              onActionSelected: (survey, surveyAction) {
                                _selectSurveyAction(
                                    surveyAction: surveyAction, survey: survey);
                              },
                              onSendAction: (survey) {
                                _sendNeededInformationEvent(
                                    survey: survey,
                                    neededInformation:
                                        _surveyController.text.trim());
                              },
                              surveyTextEditingController: _surveyController,
                              onTapSeeAll: () {
                                _surveySeeAllEvent();
                              },
                            )),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  Widget _buildEmptySection(
    String sectionName,
    String text,
    String imagePath,
    double height,
    double radius,
  ) {
    return Container(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(radius),
            topLeft: Radius.circular(radius)),
        color: const Color.fromRGBO(246, 246, 248, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height),
          Text(sectionName,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: ColorSchemes.black, letterSpacing: -0.24)),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: ColorSchemes.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  blurStyle: BlurStyle.outer,
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, 1),
                  color: Color.fromRGBO(0, 0, 0, 0.12),
                )
              ],
            ),
            height: 150,
            width: double.infinity,
            child: EmptyWidget(
              text: text,
              imagePath: imagePath,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  bool _checkVisibility(String code) {
    bool visible = true;
    for (var element in homeSections) {
      if (element.code == code) {
        visible = element.isVisible;
      }
    }
    return visible;
  }

  void _getNotificationsCountEvent() {
    _bloc.add(GetNotificationCountEvent());
  }

  void _navigateToNotificationScreen() {
    _bloc.add(NavigateToNotificationScreenEvent());
  }

  void _navigateToQrScreenEvent() {
    _bloc.add(NavigateToQrScreenEvent());
  }

  void _navigateToSupportDetailScreenEvent({required HomeSupport support}) {
    _bloc.add(NavigateToSupportDetailScreenEvent(support: support));
  }

  void _navigateToServiceDetailScreenEvent({required HomeService service}) {
    _bloc.add(NavigateToServiceDetailScreenEvent(service: service));
  }

  void _navigateToEventDetailScreenEvent({required HomeEventItem event}) {
    _bloc.add(NavigateToEventDetailScreenEvent(event: event));
  }

  void _selectEventAction({
    required HomeEventOption eventAction,
    required HomeEventItem event,
  }) {
    _bloc.add(SelectEventActionEvent(
      eventAction: eventAction,
      event: event,
    ));
  }

  void _sendEventNeededInformationEvent() {
    _bloc.add(SendEventNeededInformationEvent(
        eventNeededInformation: _eventController.text.trim()));
  }

  void _eventSeeAllEvent() {
    _bloc.add(EventSeeAllEvent());
  }

  void _surveySeeAllEvent() {
    _bloc.add(SurveySeeAllEvent());
  }

  void _selectSurveyAction(
      {required SurveyQuestionChoice surveyAction, required Survey survey}) {
    _bloc.add(
        SelectSurveyActionEvent(surveyAction: surveyAction, survey: survey));
  }

  void _sendNeededInformationEvent(
      {required String neededInformation, required Survey survey}) {
    _bloc.add(SendSurveyNeededInformationEvent(
        surveyNeededInformation: _surveyController.text.trim(),
        survey: survey));
  }

  void _checkForEventDynamicQuestion({
    required HomeEventItem event,
    HomeEventOption? eventAction,
  }) {
    _bloc.add(EventCheckForDynamicQuestionEvent(
        event: event, eventAction: eventAction!));
  }

  void _openEventDynamicQuestionBottomSheet({
    required List<PageField> questions,
    required HomeEventItem event,
    required HomeEventOption eventAction,
  }) {
    openDynamicQuestionsBottomSheet(
      context: context,
      height: 600,
      questions: questions,
      onOkPresses: (questions) {
        if (eventAction.isCalendar && Platform.isAndroid) {
          _bloc.add(ShowCalendarActionDialogEvent(
              questions: questions, event: event, eventAction: eventAction));
        } else {
          if (event.calenderRef != "") {
            _deleteFromCalenderEvent(
              event: event,
              eventAction: eventAction,
              eventId: event.calenderRef,
            );
          } else {
            _bloc.add(EventOnBottomSheetOkClickEvent(
              questions: questions,
              event: event,
              eventAction: eventAction,
            ));
          }
        }
        _popBackEvent();
      },
    );
  }

  void _popBackEvent() {
    Navigator.pop(context);
  }

  final cairoTimeZone = getLocation('Africa/Cairo');

  void _showCalenderActionDialog({
    required HomeEventItem event,
    required HomeEventOption eventAction,
    List<PageField> questions = const [],
  }) {
    _showActionDialog(
      icon: ImagePaths.warning,
      text: S.of(context).doYouWantToAddThisEventToYourDevice,
      primaryText: S.of(context).yes,
      secondaryText: S.of(context).no,
      onPrimaryAction: () async {
        Navigator.pop(context);
        if (await PermissionServiceHandler().handleServicePermission(
            setting: PermissionServiceHandler.getCalendarPermission())) {
          _addToCalendarEvent(event: event, eventAction: eventAction);
        } else {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              Navigator.pop(context);
              openAppSettings().then((value) async {
                if (await PermissionServiceHandler.getCalendarPermission()
                    .isGranted) {
                  _addToCalendarEvent(event: event, eventAction: eventAction);
                }
              });
            },
            onSecondaryAction: () {
              Navigator.pop(context);
            },
            primaryText: S.of(context).ok,
            secondaryText: S.of(context).cancel,
            text: S.of(context).youShouldHaveCalendarPermission,
          );
        }
      },
      onSecondaryAction: () {
        _bloc.add(DeleteEventReferenceIdEvent(
          questions: questions,
          event: event,
          eventAction: eventAction,
        ));
        // _bloc.add(EventOnBottomSheetOkClickEvent(
        //   questions: questions,
        //   event: event,
        //   eventAction: eventAction,
        // ));
        Navigator.pop(context);
      },
    );
  }

  void _showActionDialog({
    required Function() onPrimaryAction,
    required Function() onSecondaryAction,
    required String primaryText,
    required String secondaryText,
    required String text,
    required String icon,
  }) {
    showActionDialogWidget(
      context: context,
      text: text,
      primaryText: primaryText,
      primaryAction: () {
        onPrimaryAction();
      },
      secondaryText: secondaryText,
      secondaryAction: () {
        onSecondaryAction();
      },
      icon: icon,
    );
  }

  void _addToCalendarEvent(
      {required HomeEventItem event, required HomeEventOption eventAction}) {
    _bloc.add(AddEventToCalendarEvent(
      event: event,
      eventAction: eventAction,
      startDate: TZDateTime(
          cairoTimeZone,
          DateTime.parse(event.endDate).year,
          DateTime.parse(event.endDate).month,
          DateTime.parse(event.endDate).day,
          DateTime.parse(event.endDate).hour,
          0),
      endDate: TZDateTime(
          cairoTimeZone,
          DateTime.parse(event.endDate).year,
          DateTime.parse(event.endDate).month,
          DateTime.parse(event.endDate).day,
          DateTime.parse(event.endDate).hour,
          0),
      isAllDay: false,
    ));
    showLoading();
  }

  void _deleteFromCalenderEvent({
    required HomeEventItem event,
    required HomeEventOption eventAction,
    required String eventId,
  }) {
    _bloc.add(DeleteEventFromCalendarEvent(
      event: event,
      eventAction: eventAction,
      eventId: eventId,
    ));
    showLoading();
  }

  Future<void> handleEventToCalendar({
    required HomeEventItem event,
    required HomeEventOption eventAction,
    TZDateTime? startDate,
    TZDateTime? endDate,
    bool? isAllDay,
  }) async {
    final DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
    final calendarsResult = await deviceCalendarPlugin.retrieveCalendars();

    if (calendarsResult.isSuccess && calendarsResult.data!.isNotEmpty) {
      // ignore: prefer_typing_uninitialized_variables
      var foundCalendar;
      foundCalendar = calendarsResult.data!.first;

      if (foundCalendar != null) {
        calendarId = foundCalendar.id;
        createEvent(
            event: event,
            eventAction: eventAction,
            calendarId: calendarId,
            isAllDay: isAllDay ?? false,
            startDate: startDate,
            endDate: endDate);
      } else {
        _showMassageDialogWidget(S.current.failedToAddEvent, ImagePaths.error);
        hideLoading();
      }
    } else {
      hideLoading();
    }
  }

  Future<String> createEvent({
    required String? calendarId,
    required HomeEventItem event,
    required HomeEventOption eventAction,
    TZDateTime? startDate,
    TZDateTime? endDate,
    bool? isAllDay,
  }) async {
    try {
      var result = await _deviceCalendarPlugin.createOrUpdateEvent(Event(
        calendarId,
        title: event.title,
        location: event.locationAddress,
        description: event.description,
        allDay: isAllDay ?? false,
        start: startDate,
        end: endDate,
      ));

      if (result!.isSuccess) {
        _sendEventReferenceId(
            event: event, eventAction: eventAction, data: result.data!);
        hideLoading();

        _bloc.add(EventOnBottomSheetOkClickEvent(
          questions: [],
          event: event,
          eventAction: eventAction,
        ));

        return result.data!;
      } else {
        _showMassageDialogWidget(S.current.failedToAddEvent, ImagePaths.error);
        hideLoading();
        return "error";
      }
    } catch (e) {
      _showMassageDialogWidget(S.current.failedToAddEvent, ImagePaths.error);
      hideLoading();
      return "Exception";
    }
  }

  Future<bool> deleteCalendarEvent({
    required HomeEventItem event,
    required HomeEventOption eventAction,
    required String? calendarId,
  }) async {
    try {
      var result = await _deviceCalendarPlugin.deleteEvent(
          calendarId, event.calenderRef);
      if (result.isSuccess) {
        hideLoading();
        _bloc.add(DeleteEventReferenceIdEvent(
          questions: [],
          event: event,
          eventAction: eventAction,
        ));
        // _bloc.add(EventOnBottomSheetOkClickEvent(
        //   questions: [],
        //   event: event,
        //   eventAction: eventAction,
        // ));
        return true;
      } else {
        hideLoading();
        return false;
      }
    } catch (e) {
      hideLoading();
      return false;
    }
  }

  void _showMassageDialogWidget(String text, String icon) {
    showMassageDialogWidget(
      context: context,
      text: text,
      icon: icon,
      buttonText: S.of(context).ok,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  void _sendEventReferenceId(
      {required HomeEventItem event,
      required HomeEventOption eventAction,
      required String data}) {
    _bloc.add(SendEventReferenceIdEvent(
        event: event, eventAction: eventAction, eventReferenceId: data));
  }

  void _onTapOfferEvent({required Offer offer}) {
    _bloc.add(OnTapOfferEvent(offer: offer));
  }

  void _onTapProfileImage(String image) {
    Navigator.pushNamed(context, Routes.galleryImages,
        arguments: GalleryImages(initialIndex: 0, images: [
          GalleryAttachment(attachment: image),
        ]));
  }
}
