import 'dart:async';
import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/permission_service_handler.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/core/utils/open_daynamic_questions_bottom_sheet.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/domain/entities/event/event_data.dart';
import 'package:city_eye/src/domain/entities/gallery/sort.dart';
import 'package:city_eye/src/domain/entities/home/home_event_item.dart';
import 'package:city_eye/src/domain/entities/home/home_event_option.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/presentation/blocs/events/events_bloc.dart';
import 'package:city_eye/src/presentation/screens/events/skeleton/skeleton_events_widget.dart';
import 'package:city_eye/src/presentation/screens/events/utils/show_sort_bottom_sheet.dart';
import 'package:city_eye/src/presentation/screens/events/widgets/events_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:city_eye/src/presentation/widgets/search_text_field_widget.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class EventsScreen extends BaseStatefulWidget {
  final int id;

  const EventsScreen({this.id = -1, Key? key}) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _EventsScreenState();
}

class _EventsScreenState extends BaseState<EventsScreen> {
  EventsBloc get _bloc => BlocProvider.of<EventsBloc>(context);
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

  final TextEditingController _searchTextEditingController =
      TextEditingController();

  List<PageField> answeredQuestions = [];

  final List<Sort> _sorts = [
    Sort(id: 1, name: S.current.dateNewestOldest),
    Sort(id: 2, name: S.current.dateOldestNewest),
    Sort(id: 3, name: S.current.priceLowHigh),
    Sort(id: 4, name: S.current.priceHighLow),
  ];
  Sort _selectedSort = Sort(
    id: 1,
    name: S.current.dateNewestOldest,
  );

  List<HomeEventItem> filteredEvents = [];

  EventData _eventData =
      EventData(events: const [], dynamicQuestions: const []);

  String calendarId = '';

  Color borderColor = ColorSchemes.primary;
  var itemCount = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _bloc.add(GetEventsEvent());
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<EventsBloc, EventsState>(
      listener: (context, state) {
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is OpenSortBottomSheetState) {
          showSortsBottomSheet(
            context: context,
            height: 320,
            sorts: _sorts,
            selectedSort: _selectedSort,
            onSortSelected: (sort) {
              _bloc.add(NavigateBackEvent());
              _bloc.add(SelectSortEvent(sort: sort));
            },
          );
        } else if (state is SelectSortState) {
          _selectedSort = state.sort;
          _bloc.add(
              SortEventsEvent(events: _eventData.events, sort: _selectedSort));
        } else if (state is SortEventsState) {
          _eventData.events = state.events;
          filteredEvents = state.events;
          _bloc.add(SearchEventsEvent(
              value: _searchTextEditingController.text.trim()));
        } else if (state is SearchEventsState) {
          // _eventData.events = state.events;
          if (state.value.isNotEmpty) {
            filteredEvents = state.events;
          } else {
            filteredEvents = state.events;
          }
        } else if (state is GetEventsSuccessState) {
          _eventData = state.events;
          filteredEvents = state.events.events;
          _bloc.add(SearchEventsEvent(
              value: _searchTextEditingController.text.trim()));
        } else if (state is GetEventsErrorState) {
          showSnackBar(
            context: context,
            message: state.errorMessage,
            color: ColorSchemes.snackBarError,
            icon: ImagePaths.error,
          );
        } else if (state is UpdateEventActionState) {
          _eventData.events = state.events;
          filteredEvents = state.events;
        } else if (state is SelectEventState) {
        } else if (state is SendEventSuccessState) {
        } else if (state is SendEventErrorState) {
        } else if (state is NavigateToEventDetailsScreenState) {
          Navigator.pushNamed(
            context,
            Routes.eventDetails,
            arguments: {
              "eventId": state.event.id,
            },
          ).then((value) {
            SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
            ));
            if (value != null) {
              for (int i = 0; i < _eventData.events.length; i++) {
                if (_eventData.events[i].id == (value as HomeEventItem).id) {
                  _eventData.events[i] = value;
                  break;
                }
              }
              setState(() {});
            }
          });
        } else if (state is NavigateBackState) {
          Navigator.pop(context, state.events);
        } else if (state is CheckForDynamicQuestionState) {
          if (!state.eventAction.isSelectedByUser) {
            if (state.questionsList.isNotEmpty) {
              _openDynamicQuestionBottomSheet(
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
                  _bloc.add(OnBottomSheetOkClickEvent(
                    questions: [],
                    event: state.event,
                    eventAction: state.eventAction,
                  ));
                }
              }
            }
          }
        } else if (state is OnBottomSheetOkClickState) {
          _eventData.dynamicQuestions = state.questions;
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
          _searchTextEditingController.clear();
        } else if (state is AddEventToCalendarState) {
          handleEventToCalendar(
              event: state.event,
              eventAction: state.eventAction,
              title: state.title,
              description: state.description,
              location: state.location,
              startDate: state.startDate,
              endDate: state.endDate,
              isAllDay: false);
        } else if (state is DeleteEventToCalendarState) {
          // selectedEventContent = state.eventContent;
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
          _bloc.add(OnBottomSheetOkClickEvent(
            questions: state.questions,
            event: state.event,
            eventAction: state.eventAction,
          ));
        } else if (state is ScrollToItemState) {
          _scrollToIndex(state.key);
          getColor();
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: buildAppBarWidget(
              context,
              title: S.of(context).events,
              isHaveBackButton: true,
              onBackButtonPressed: () {
                _bloc.add(NavigateBackEvent(events: _eventData.events));
              },
              actionWidget: InkWell(
                onTap: () {
                  _bloc.add(OpenSortBottomSheetEvent());
                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: 16,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        width: 24,
                        height: 24,
                        ImagePaths.sort,
                        fit: BoxFit.scaleDown,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        S.of(context).sort,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              letterSpacing: -0.13,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: WillPopScope(
              onWillPop: () {
                _bloc.add(NavigateBackEvent(events: _eventData.events));
                return Future.value(true);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    SearchTextFieldWidget(
                      onChange: (value) {
                        _bloc.add(SearchEventsEvent(value: value));
                      },
                      controller: _searchTextEditingController,
                      searchText: S.of(context).search,
                      onClear: () {
                        _searchTextEditingController.clear();
                        _bloc.add(const SearchEventsEvent(value: ""));
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _buildEvents(state),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleRefresh() async {
    _bloc.add(GetEventsEvent());
  }

  Widget _buildEvents(EventsState state) {
    return state is ShowSkeletonState
        ? const SkeletonEventsWidget()
        : filteredEvents.isEmpty
            ? Expanded(
                child: CustomEmptyListWidget(
                  text: S.of(context).noEventsYet,
                  imagePath: ImagePaths.emptyEvents,
                  onRefresh: () {
                    _handleRefresh();
                  },
                ),
              )
            : EventsWidget(
                id: widget.id,
                borderColor: borderColor,
                textEditingController: TextEditingController(),
                onActionSelected: (event, eventAction) {
                  if (DateTime.now()
                      .isBefore(DateTime.parse(event.closedDate))) {
                    _checkForDynamicQuestion(
                        event: event, eventAction: eventAction);
                  }
                },
                onChange: (value) {},
                onSendAction: (eventAction) {},
                events: filteredEvents,
                onCardTap: (event) {
                  _bloc.add(NavigateToEventDetailsScreen(event: event));
                },
                onPullToRefresh: () {
                  _handleRefresh();
                },
                onScrollToItem: (key) {
                  _bloc.add(ScrollToItemEvent(key: key));
                },
              );
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

  void _checkForDynamicQuestion({
    required HomeEventItem event,
    HomeEventOption? eventAction,
  }) {
    _bloc.add(
        CheckForDynamicQuestionEvent(event: event, eventAction: eventAction!));
  }

  void _openDynamicQuestionBottomSheet({
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
            _bloc.add(OnBottomSheetOkClickEvent(
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
          event: event,
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
    required HomeEventItem event,
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
            event: event,
            eventAction: eventAction,
            calendarId: calendarId,
            isAllDay: isAllDay ?? false,
            startDate: startDate,
            endDate: endDate);
      } else {
        _showMassageDialogWidget(
            S.current.failedToAddEvent, ImagePaths.warning);
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

        _bloc.add(OnBottomSheetOkClickEvent(
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

  Future<void> _scrollToIndex(GlobalKey key) async {
    Future.delayed(const Duration(milliseconds: 500));
    Scrollable.ensureVisible(
      key.currentContext ?? context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  getColor() {
    _timer = Timer(const Duration(seconds: 2), () {
      borderColor = ColorSchemes.white;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
