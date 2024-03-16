part of 'event_details_bloc.dart';

abstract class EventDetailsEvent extends Equatable {
  const EventDetailsEvent();

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SelectEventActionEvent extends EventDetailsEvent {
  final HomeEventOption eventAction;

  const SelectEventActionEvent({
    required this.eventAction,
  });
}

class NavigateBackEvent extends EventDetailsEvent {
  final HomeEventItem event;

  NavigateBackEvent({
    this.event = const HomeEventItem(),
  });
}

class CheckForEventDetailsDynamicQuestionEvent extends EventDetailsEvent {
  final HomeEventItem event;
  final HomeEventOption eventAction;

  CheckForEventDetailsDynamicQuestionEvent(
      {required this.eventAction, required this.event});
}

class OnEventDetailsBottomSheetOkClickEvent extends EventDetailsEvent {
  final List<PageField> questions;
  final HomeEventOption eventAction;

  OnEventDetailsBottomSheetOkClickEvent(
      {required this.questions, required this.eventAction});
}

class DeleteEventReferenceIdEvent extends EventDetailsEvent {
  final List<PageField> questions;
  final HomeEventOption eventAction;

  DeleteEventReferenceIdEvent(
      {required this.questions, required this.eventAction});
}

class AddEventToCalendarEvent extends EventDetailsEvent {
  HomeEventItem event;
  HomeEventOption eventAction;
  String? eventId;
  String? title;
  String? location;
  String? description;
  TZDateTime? startDate;
  TZDateTime? endDate;
  bool? isAllDay;

  AddEventToCalendarEvent({
    required this.event,
    required this.eventAction,
    this.eventId,
    this.title,
    this.location,
    this.description,
    this.startDate,
    this.endDate,
    this.isAllDay,
  });
}

class DeleteEventFromCalendarEvent extends EventDetailsEvent {
  final HomeEventItem event;
  final HomeEventOption eventAction;
  final String eventId;

  DeleteEventFromCalendarEvent({
    required this.event,
    required this.eventAction,
    required this.eventId,
  });
}

class ShowCalendarActionDialogEvent extends EventDetailsEvent {
  HomeEventOption eventAction;
  List<PageField> questions;

  ShowCalendarActionDialogEvent({
    required this.eventAction,
    this.questions = const [],
  });
}

class SendEventReferenceIdEvent extends EventDetailsEvent{
  HomeEventOption eventAction;
  String eventReferenceId;

  SendEventReferenceIdEvent(
      {required this.eventAction,
        required this.eventReferenceId});
}

class GetCompoundConfigurationEvent extends EventDetailsEvent {}

class GetEventDetailsEvent extends EventDetailsEvent {
  final int eventId;

  const GetEventDetailsEvent({
    required this.eventId,
  });
}