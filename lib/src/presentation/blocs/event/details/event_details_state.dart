part of 'event_details_bloc.dart';

abstract class EventDetailsState extends Equatable {
  const EventDetailsState();

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class EventDetailsInitial extends EventDetailsState {}

class ShowLoadingState extends EventDetailsState {}

class ShowSkeletonState extends EventDetailsState {}

class HideLoadingState extends EventDetailsState {}

class GetEventDetailsSuccessState extends EventDetailsState {
  final HomeEventItem eventContent;
  final List<PageField> pageFields;
  final String link;

  const GetEventDetailsSuccessState({
    required this.eventContent,
    required this.pageFields,
    required this.link,
  });
}

class EventsDetailsErrorState extends EventDetailsState {
  final String message;

  EventsDetailsErrorState({
    required this.message,
  });
}

class SelectEventActionState extends EventDetailsState {
  final HomeEventItem eventContent;
  final HomeEventOption eventAction;

  const SelectEventActionState({
    required this.eventAction,
    required this.eventContent,
  });
}

class NavigateBackState extends EventDetailsState {
  final HomeEventItem event;

  NavigateBackState({
    this.event = const HomeEventItem(),
  });
}

class CheckForEventDetailsDynamicQuestionState extends EventDetailsState {
  final List<PageField> questionsList;
  final HomeEventOption eventAction;

  CheckForEventDetailsDynamicQuestionState(
      {required this.questionsList, required this.eventAction});
}

class OnEventDetailsBottomSheetOkClickState extends EventDetailsState {
  final List<PageField> questions;
  final HomeEventOption eventAction;
  final int transactionId;
  final String message;

  OnEventDetailsBottomSheetOkClickState({
    required this.questions,
    required this.eventAction,
    required this.transactionId,
    required this.message,
  });
}
class OnEventDetailsBottomSheetOkClickErrorState extends EventDetailsState {
  final String message;

  OnEventDetailsBottomSheetOkClickErrorState({
    required this.message,
  });
}

class AddEventToCalendarState extends EventDetailsState {
  final HomeEventItem event;
  final HomeEventOption eventAction;
  String? eventId;
  String? title;
  String? location;
  String? description;
  TZDateTime? startDate;
  TZDateTime? endDate;
  bool? isAllDay;

  AddEventToCalendarState(
      {required this.event,
      required this.eventAction,
      this.eventId,
      this.title,
      this.location,
      this.description,
      this.startDate,
      this.endDate,
      this.isAllDay});
}

class DeleteEventToCalendarState extends EventDetailsState {
  final HomeEventItem eventContent;
  final HomeEventOption eventAction;
  final String eventId;

  DeleteEventToCalendarState({
    required this.eventContent,
    required this.eventAction,
    required this.eventId,
  });
}

class ShowCalendarActionDialogState extends EventDetailsState {
  final HomeEventOption eventAction;
  List<PageField> questions;

  ShowCalendarActionDialogState({
    required this.eventAction,
    this.questions = const [],
  });
}

class DeleteEventReferenceIdState extends EventDetailsState {
  final List<PageField> questions;
  final HomeEventOption eventAction;

  DeleteEventReferenceIdState(
      {required this.questions, required this.eventAction});
}

class SendEventReferenceSuccessIdState extends EventDetailsState {}

class GetCompoundConfigurationState extends EventDetailsState {
  final CompoundConfiguration compoundConfiguration;

  GetCompoundConfigurationState({
    required this.compoundConfiguration,
  });
}
