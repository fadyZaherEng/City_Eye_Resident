part of 'qr_configuration_bloc.dart';

abstract class QrConfigurationState extends Equatable {
  const QrConfigurationState();

  @override
  List<Object> get props => [identityHashCode(this)];
}

class QrConfigurationInitial extends QrConfigurationState {}

class ShowLoadingState extends QrConfigurationState {}

class HideLoadingState extends QrConfigurationState {}

class NavigateBackState extends QrConfigurationState {}

class ShowActionDialogState extends QrConfigurationState {}

class SwitchQrTabsState extends QrConfigurationState {
  final int index;

  const SwitchQrTabsState({
    required this.index,
  });
}

//Create Qr Events
class ShowCreateQrSkeleton extends QrConfigurationState {}

class HideCreateQrSkeleton extends QrConfigurationState {}

class GetQrConfigurationSuccessState extends QrConfigurationState {
  final QrConfiguration qrConfiguration;

  const GetQrConfigurationSuccessState({
    required this.qrConfiguration,
  });
}

class GetQrConfigurationErrorState extends QrConfigurationState {
  final String message;

  const GetQrConfigurationErrorState({
    required this.message,
  });
}

class SelectGuestTypeState extends QrConfigurationState {
  final GuestsType guestsType;

  const SelectGuestTypeState({
    required this.guestsType,
  });
}

class SelectQrTypeState extends QrConfigurationState {
  final QrsType qrsType;

  const SelectQrTypeState({
    required this.qrsType,
  });
}

class AnswerQuestionState extends QrConfigurationState {
  final List<PageField> questions;

  const AnswerQuestionState({
    required this.questions,
  });
}

class SelectImageQuestionState extends QrConfigurationState {
  final List<PageField> questions;
  final PageField question;

  const SelectImageQuestionState({
    required this.questions,
    required this.question,
  });
}

class DeleteImageQuestionState extends QrConfigurationState {
  final List<PageField> questions;
  final PageField question;

  const DeleteImageQuestionState({
    required this.questions,
    required this.question,
  });
}

class ShowSearchableBottomSheetState extends QrConfigurationState {
  final List<PageField> questions;
  final PageField question;
  final bool isMultiChoice;

  const ShowSearchableBottomSheetState({
    required this.questions,
    required this.question,
    required this.isMultiChoice,
  });
}

class OpenRulesBottomSheetState extends QrConfigurationState {}

class CreateQrSuccessState extends QrConfigurationState {
  final CreateQrResponse createQrResponse;

  const CreateQrSuccessState({
    required this.createQrResponse,
  });
}

class CreateQrErrorState extends QrConfigurationState {
  final String message;

  const CreateQrErrorState({
    required this.message,
  });
}

class OpenDatePickerState extends QrConfigurationState {
  final Function(DateTime?) onDateSelected;

  const OpenDatePickerState({
    required this.onDateSelected,
  });
}

class SelectDateState extends QrConfigurationState {
  final DateTime? dateTime;

  const SelectDateState({
    required this.dateTime,
  });
}

class DeleteDateState extends QrConfigurationState {}

class SelectSingleQRTimeState extends QrConfigurationState {
  final List<DayTime> availableTimes;

  const SelectSingleQRTimeState({
    required this.availableTimes,
  });
}

class SelectMultipleQRTimeState extends QrConfigurationState {
  final List<Day> multipleQrOrderedDays;

  const SelectMultipleQRTimeState({
    required this.multipleQrOrderedDays,
  });
}




class SelectDayState extends QrConfigurationState {
  final List<Day> days;
  final Day selectedDay;
  final QrErrorMessages qrErrorMessages;


  const SelectDayState({
    required this.days,
    required this.selectedDay,
    required this.qrErrorMessages,
  });
}

class QrValidationErrorState extends QrConfigurationState {
  final QrErrorMessages qrErrorMessages;
  final List<PageField> questions;

  const QrValidationErrorState({
    required this.qrErrorMessages  ,
    required this.questions,
  });
}

class ValidateVisitorNameState extends QrConfigurationState {}


//History Screen States
class ShowHistorySkeletonState extends QrConfigurationState {}

class HideHistorySkeletonState extends QrConfigurationState {}

class SwitchHistoryTabsState extends QrConfigurationState {
  final int historyQrType;

  const SwitchHistoryTabsState({
    required this.historyQrType,
  });
}

class GetQrHistorySuccessState extends QrConfigurationState {
  final List<QrHistory> history;

  const GetQrHistorySuccessState({
    required this.history,
  });
}

class GetQrHistoryErrorState extends QrConfigurationState {
  final String message;

  const GetQrHistoryErrorState({
    required this.message,
  });
}

class ChangeQrActivationStatusSuccessState extends QrConfigurationState {
  final List<QrHistory> history;
  final String message;

  const ChangeQrActivationStatusSuccessState({
    required this.history,
    required this.message,
  });
}

class ChangeQrActivationStatusErrorState extends QrConfigurationState {
  final String message;

  const ChangeQrActivationStatusErrorState({
    required this.message,
  });
}

class QrHistorySearchState extends QrConfigurationState {
  final List<QrHistory> history;

  const QrHistorySearchState({
    required this.history,
  });
}

/*
//History Qr History Events
class SwitchHistoryTabsEvent extends QrConfigurationEvent {
  final int qrType;

  const SwitchHistoryTabsEvent({
    required this.qrType,
  });
}

class GetQrHistoryEvent extends QrConfigurationEvent {
  final int qrType; //Based on it's status if 0 means isStatus = true else if 1 means isStatus = false

  const GetQrHistoryEvent({
    required this.qrType,
  });
}

class ChangeQrStatusEvent extends QrConfigurationEvent {
  final int qrId;

  const ChangeQrStatusEvent({
    required this.qrId,
  });
}

class QrSearchEvent extends QrConfigurationEvent {
  final String value;

  const QrSearchEvent({
    required this.value,
  });
}

 */
