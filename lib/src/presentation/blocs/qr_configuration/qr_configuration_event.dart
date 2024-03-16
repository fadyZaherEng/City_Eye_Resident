part of 'qr_configuration_bloc.dart';

abstract class QrConfigurationEvent extends Equatable {
  const QrConfigurationEvent();

  @override
  List<Object> get props => [identityHashCode(this)];
}

class SwitchQrTabsEvent extends QrConfigurationEvent {
  final int index;

  const SwitchQrTabsEvent({
    required this.index,
  });
}

class NavigateBackEvent extends QrConfigurationEvent {}

//Create Qr Events
class GetQrConfigurationEvent extends QrConfigurationEvent {}

class SelectGuestTypeEvent extends QrConfigurationEvent {
  final GuestsType guestsType;

  const SelectGuestTypeEvent({
    required this.guestsType,
  });
}

class SelectQrTypeEvent extends QrConfigurationEvent {
  final QrsType qrsType;

  const SelectQrTypeEvent({
    required this.qrsType,
  });
}

class SelectSingleSelectionAnswerEvent extends QrConfigurationEvent {
  final List<PageField> questions;
  final PageField question;
  final int answerId;

  const SelectSingleSelectionAnswerEvent({
    required this.questions,
    required this.question,
    required this.answerId,
  });
}

class SelectMultiSelectionAnswerEvent extends QrConfigurationEvent {
  final List<PageField> questions;
  final PageField question;
  final int answerId;

  const SelectMultiSelectionAnswerEvent({
    required this.questions,
    required this.question,
    required this.answerId,
  });
}

class AddAnswerToQuestionEvent extends QrConfigurationEvent {
  final List<PageField> questions;
  final PageField question;
  final dynamic answer;

  const AddAnswerToQuestionEvent({
    required this.questions,
    required this.question,
    required this.answer,
  });
}

class DeleteAnswerQuestionEvent extends QrConfigurationEvent {
  final List<PageField> questions;
  final PageField question;

  const DeleteAnswerQuestionEvent({
    required this.questions,
    required this.question,
  });
}

class SelectImageQuestionEvent extends QrConfigurationEvent {
  final List<PageField> questions;
  final PageField question;

  const SelectImageQuestionEvent({
    required this.questions,
    required this.question,
  });
}

class DeleteImageQuestionEvent extends QrConfigurationEvent {
  final List<PageField> questions;
  final PageField question;

  const DeleteImageQuestionEvent({
    required this.questions,
    required this.question,
  });
}

class ShowSearchableBottomSheetEvent extends QrConfigurationEvent {
  final List<PageField> questions;
  final PageField question;
  final bool isMultiChoice;

  const ShowSearchableBottomSheetEvent({
    required this.questions,
    required this.question,
    required this.isMultiChoice,
  });
}

class UpdateSearchableSingleQuestionEvent extends QrConfigurationEvent {
  final List<PageField> questions;
  final PageField question;
  final Choice answer;

  const UpdateSearchableSingleQuestionEvent({
    required this.questions,
    required this.question,
    required this.answer,
  });
}

class UpdateSearchableMultiQuestionEvent extends QrConfigurationEvent {
  final List<PageField> questions;
  final PageField question;
  final List<Choice> answer;

  const UpdateSearchableMultiQuestionEvent({
    required this.questions,
    required this.question,
    required this.answer,
  });
}

class OpenRulesBottomSheetEvent extends QrConfigurationEvent {}

class CreateQrEvent extends QrConfigurationEvent {
  final QrErrorMessages qrErrorMessages;
  final GuestsType guestsType;
  final QrsType qrsType;
  final List<PageField> questions;
  final DateTime? selectedDate;
  final DateTime? firstDate;
  final String visitorName;
  final List<DayTime> availableTimes;
  final List<Day> days;

  const CreateQrEvent({
    required this.qrErrorMessages,
    required this.guestsType,
    required this.qrsType,
    required this.questions,
    required this.selectedDate,
    required this.firstDate,
    required this.visitorName,
    required this.days,
    required this.availableTimes,
  });
}

class OpenDatePickerEvent extends QrConfigurationEvent {
  final Function(DateTime?) onDateSelected;

  const OpenDatePickerEvent({
    required this.onDateSelected,
  });
}

class SelectDateEvent extends QrConfigurationEvent {
  final DateTime? selectedDate;

  const SelectDateEvent({
    required this.selectedDate,
  });
}

class DeleteDateEvent extends QrConfigurationEvent {}

class SelectSingleQRTimeEvent extends QrConfigurationEvent {
  final List<DayTime> dayTimes;
  final DayTime selectedTime;

  const SelectSingleQRTimeEvent({
    required this.dayTimes,
    required this.selectedTime,
  });
}

class SelectMultipleQRTimeEvent extends QrConfigurationEvent {
  final List<Day> days;
  final Day selectedDay;
  final DayTime selectedTime;

  const SelectMultipleQRTimeEvent({
    required this.days,
    required this.selectedDay,
    required this.selectedTime,
  });
}

class SelectDayEvent extends QrConfigurationEvent {
  final List<Day> days;
  final Day selectedDay;
  final QrErrorMessages qrErrorMessages;

  const SelectDayEvent({
    required this.days,
    required this.selectedDay,
    required this.qrErrorMessages,
  });
}

class ValidateVisitorNameEvent extends QrConfigurationEvent {}

//History Qr History Events
class SwitchHistoryTabsEvent extends QrConfigurationEvent {
  final int historyQrType;

  const SwitchHistoryTabsEvent({
    required this.historyQrType,
  });
}

class GetQrHistoryEvent extends QrConfigurationEvent {
  final int qrType;

  const GetQrHistoryEvent({
    required this.qrType,
  });
}

class ChangeQrActivationStatusEvent extends QrConfigurationEvent {
  final List<QrHistory> qrHistories;
  final QrHistory qrHistory;

  const ChangeQrActivationStatusEvent({
    required this.qrHistories,
    required this.qrHistory,
  });
}

class QrHistorySearchEvent extends QrConfigurationEvent {
  final List<QrHistory> qrHistories;
  final String value;

  const QrHistorySearchEvent({
    required this.qrHistories,
    required this.value,
  });
}
