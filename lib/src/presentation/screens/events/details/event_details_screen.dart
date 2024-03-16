import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/open_map.dart';
import 'package:city_eye/src/core/utils/permission_service_handler.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/core/utils/open_daynamic_questions_bottom_sheet.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:city_eye/src/domain/entities/gallery/images_screen.dart';
import 'package:city_eye/src/domain/entities/home/home_event_item.dart';
import 'package:city_eye/src/domain/entities/home/home_event_option.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/presentation/blocs/event/details/event_details_bloc.dart';
import 'package:city_eye/src/presentation/screens/events/details/skeleton/event_details_skeleton.dart';
import 'package:city_eye/src/presentation/screens/events/details/widgets/event_details_header_widget.dart';
import 'package:city_eye/src/presentation/screens/events/details/widgets/event_details_information_widget.dart';
import 'package:city_eye/src/presentation/screens/events/details/widgets/event_detials_question_widget.dart';
import 'package:city_eye/src/presentation/screens/events/details/widgets/rules_widget.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class EventDetailsScreen extends BaseStatefulWidget {
  final int eventId;

  const EventDetailsScreen({
    Key? key,
    required this.eventId,
  }) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends BaseState<EventDetailsScreen> {
  EventDetailsBloc get _bloc => BlocProvider.of<EventDetailsBloc>(context);
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

  final TextEditingController _questionTextEditingController =
      TextEditingController();

  List<PageField> answeredQuestions = [];

  HomeEventItem myEvent = HomeEventItem();
  CompoundConfiguration _compoundConfiguration = CompoundConfiguration();

  String calendarId = '';
  String shareLink = "";

  @override
  void initState() {
    _bloc.add(GetEventDetailsEvent(eventId: widget.eventId));
    // _bloc.dynamicQuestions = widget.dynamicQuestion;
    // _bloc.eventContent = widget.event;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: ColorSchemes.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<EventDetailsBloc, EventDetailsState>(
      listener: (context, state) {
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is GetEventDetailsSuccessState) {
          _bloc.add(GetCompoundConfigurationEvent());
          shareLink = state.link;
          myEvent = state.eventContent;
        } else if (state is EventsDetailsErrorState) {
          _showMassageDialogWidget(
            state.message,
            ImagePaths.error,
          );
        } else if (state is SelectEventActionState) {
          myEvent = myEvent.copyWith(selectAction: state.eventAction);
          myEvent = state.eventContent;
        } else if (state is NavigateBackState) {
          Navigator.pop(context, state.event);
        } else if (state is CheckForEventDetailsDynamicQuestionState) {
          if (!state.eventAction.isSelectedByUser) {
            if (state.questionsList.isNotEmpty) {
              _openEventDetailsDynamicQuestionBottomSheet(
                questions: state.questionsList,
                eventAction: state.eventAction,
              );
            } else {
              if (state.eventAction.isCalendar && Platform.isAndroid) {
                _bloc.add(ShowCalendarActionDialogEvent(
                    eventAction: state.eventAction));
              } else {
                if (myEvent.calenderRef != "") {
                  _deleteFromCalenderEvent(
                      event: myEvent,
                      eventAction: state.eventAction,
                      eventId: myEvent.calenderRef);
                } else {
                  _bloc.add(OnEventDetailsBottomSheetOkClickEvent(
                    questions: [],
                    eventAction: state.eventAction,
                  ));
                }
              }
            }
          }
        } else if (state is OnEventDetailsBottomSheetOkClickState) {
          answeredQuestions = state.questions;
          _bloc.add(SelectEventActionEvent(eventAction: state.eventAction));
          showSnackBar(
            context: context,
            message: state.eventAction.isJoin
                ? S.of(context).eventJoinMessage
                : S.of(context).eventNotJoinMessage,
            color: ColorSchemes.snackBarSuccess,
            icon: ImagePaths.success,
          );
        } else if (state is OnEventDetailsBottomSheetOkClickErrorState) {
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.snackBarError,
            icon: ImagePaths.error,
          );
        } else if (state is AddEventToCalendarState) {
          handleEventToCalendar(
              eventAction: state.eventAction,
              title: state.title,
              description: state.description,
              location: state.location,
              startDate: state.startDate,
              endDate: state.endDate,
              isAllDay: false);
        } else if (state is DeleteEventToCalendarState) {
          myEvent = state.eventContent;
          deleteCalendarEvent(
            event: state.eventContent,
            eventAction: state.eventAction,
            calendarId: calendarId,
          );
        } else if (state is ShowCalendarActionDialogState) {
          _showCalenderActionDialog(
              event: myEvent,
              eventAction: state.eventAction,
              questions: state.questions);
        } else if (state is SendEventReferenceSuccessIdState) {
        } else if (state is DeleteEventReferenceIdState) {
          _bloc.add(OnEventDetailsBottomSheetOkClickEvent(
            questions: state.questions,
            eventAction: state.eventAction,
          ));
        } else if (state is GetCompoundConfigurationState) {
          _compoundConfiguration = state.compoundConfiguration;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorSchemes.white,
          body: WillPopScope(
            onWillPop: () {
              Navigator.pop(context, myEvent);
              return Future.value(true);
            },
            child: state is ShowSkeletonState
                ? const EventDetailsSkeleton()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        EventDetailsHeaderWidget(
                          title: S.of(context).details,
                          imageUrl: myEvent.eventsAttachments.isNotEmpty
                              ? myEvent.eventsAttachments.first.attachment
                              : "",
                          link: shareLink,
                          onBackButtonPressed: () {
                            _bloc.add(NavigateBackEvent(event: myEvent));
                          },
                          onShareButtonPressed: (value) async {
                            await Share.share(
                              value,
                              subject: '',
                            );
                          },
                          onTapPreviewImage: (image) {
                            _onTapPreviewImage(image);
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        EventDetailsInformationWidget(
                          myEvent: myEvent,
                          currency:
                              _compoundConfiguration.compoundSetting.currency,
                          onLocationAddressTap: () {
                            _onLocationAddressTap();
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: ColorSchemes.border,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        RulesWidget(
                          rules: myEvent.eventsRules,
                          isVisible: myEvent.eventsRules.isNotEmpty,
                        ),
                        EventDetailsQuestionWidget(
                          questionTextEditingController:
                              _questionTextEditingController,
                          onChange: (value) {},
                          onButtonTab: () {},
                          eventActions: myEvent.eventsOptions,
                          onEventActionSelected: (eventAction) {
                            if (DateTime.now()
                                .isBefore(DateTime.parse(myEvent.closedDate))) {
                              _checkForDynamicQuestion(
                                  event: myEvent, eventAction: eventAction);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  void _checkForDynamicQuestion({
    required HomeEventItem event,
    HomeEventOption? eventAction,
  }) {
    _bloc.add(CheckForEventDetailsDynamicQuestionEvent(
        event: event, eventAction: eventAction!));
  }

  void _openEventDetailsDynamicQuestionBottomSheet(
      {required List<PageField> questions,
      required HomeEventOption eventAction}) {
    openDynamicQuestionsBottomSheet(
      context: context,
      height: 600,
      questions: questions,
      onOkPresses: (questions) {
        if (eventAction.isCalendar && Platform.isAndroid) {
          _bloc.add(ShowCalendarActionDialogEvent(
              questions: questions, eventAction: eventAction));
        } else {
          if (myEvent.calenderRef != "") {
            _deleteFromCalenderEvent(
              event: myEvent,
              eventAction: eventAction,
              eventId: myEvent.calenderRef,
            );
          } else {
            _bloc.add(OnEventDetailsBottomSheetOkClickEvent(
              questions: questions,
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
      icon: ImagePaths.info,
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
                if ((await PermissionServiceHandler.getCalendarPermission()
                    .isGranted)) {
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
          eventAction: eventAction,
        ));
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
    required HomeEventOption eventAction,
    String? eventId,
    String? title,
    String? location,
    String? description,
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
            eventAction: eventAction,
            calendarId: calendarId,
            isAllDay: isAllDay ?? false,
            startDate: startDate,
            endDate: endDate);
      } else {
        _showMassageDialogWidget(
          S.current.failedToAddEvent,
          ImagePaths.error,
        );
        hideLoading();
      }
    } else {
      hideLoading();
    }
  }

  Future<String> createEvent({
    required String? calendarId,
    required HomeEventOption eventAction,
    TZDateTime? startDate,
    TZDateTime? endDate,
    bool? isAllDay,
  }) async {
    try {
      var result = await _deviceCalendarPlugin.createOrUpdateEvent(Event(
        calendarId,
        title: myEvent.title,
        location: myEvent.locationAddress,
        description: myEvent.description,
        allDay: isAllDay ?? false,
        start: startDate,
        end: endDate,
      ));

      if (result!.isSuccess) {
        _sendEventReferenceId(eventAction: eventAction, data: result.data!);
        hideLoading();

        _bloc.add(OnEventDetailsBottomSheetOkClickEvent(
          questions: [],
          eventAction: eventAction,
        ));

        return result.data!;
      } else {
        _showMassageDialogWidget(
          S.current.failedToAddEvent,
          ImagePaths.error,
        );
        hideLoading();
        return "error";
      }
    } catch (e) {
      _showMassageDialogWidget(
        S.current.failedToAddEvent,
        ImagePaths.error,
      );
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
          eventAction: eventAction,
        ));

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
      {required HomeEventOption eventAction, required String data}) {
    _bloc.add(SendEventReferenceIdEvent(
        eventAction: eventAction, eventReferenceId: data));
  }

  void _onLocationAddressTap() {
    if (myEvent.locationLatitude.isNotEmpty &&
        myEvent.locationLongitude.isNotEmpty) {
      {
        openMap(
          double.parse(myEvent.locationLatitude),
          double.parse(myEvent.locationLongitude),
        );
      }
    }
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: null,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    super.dispose();
  }

  void _onTapPreviewImage(String image) {
    Navigator.pushNamed(context, Routes.galleryImages,
        arguments: GalleryImages(initialIndex: 0, images: [
          GalleryAttachment(attachment: image),
        ]));
  }
}
