// ignore_for_file: must_be_immutable

part of 'delegated_steps_bloc.dart';

@immutable
abstract class DelegatedStepsEvent {}

class GetQuestionsEvent extends DelegatedStepsEvent {}

///************** Owner Events *************
class OwnerGetUserInformationEvent extends DelegatedStepsEvent {}

class DelegatedImagePermissionDeniedEvent extends DelegatedStepsEvent {}

class DelegatedPickImageEvent extends DelegatedStepsEvent {
  File imageFile;

  DelegatedPickImageEvent(this.imageFile);
}

class DelegatedDeleteImageEvent extends DelegatedStepsEvent {}

class DelegatedShowMassageDialogEvent extends DelegatedStepsEvent {
  String message;
  String icon;

  DelegatedShowMassageDialogEvent(
    this.message,
    this.icon,
  );
}

class DelegatedCaptureSignatureEvent extends DelegatedStepsEvent {}

class DelegatedOnTapStepEvent extends DelegatedStepsEvent {
  final int id;

  DelegatedOnTapStepEvent({
    required this.id,
  });
}

class OnOwnerSaveEvent extends DelegatedStepsEvent {
  final String message;
  final String id;
  final String dateFrom;
  final String dateTo;
  final String imagePath;
  final String signature;
  final List<PageField> questions;

  OnOwnerSaveEvent({
    required this.message,
    required this.id,
    required this.dateFrom,
    required this.dateTo,
    required this.imagePath,
    required this.signature,
    required this.questions,
  });
}

class DelegatedSelectedDateEvent extends DelegatedStepsEvent {
  String date;
  bool isFrom;

  DelegatedSelectedDateEvent(this.date, this.isFrom);
}

class DelegatedValidateMessageEvent extends DelegatedStepsEvent {
  String message;

  DelegatedValidateMessageEvent(this.message);
}

class DelegatedValidateIdEvent extends DelegatedStepsEvent {
  String id;

  DelegatedValidateIdEvent(this.id);
}

class DelegatedValidateDateFromEvent extends DelegatedStepsEvent {
  String dateFrom;

  DelegatedValidateDateFromEvent(this.dateFrom);
}

class DelegatedValidateDateToEvent extends DelegatedStepsEvent {
  String dateTo;

  DelegatedValidateDateToEvent(this.dateTo);
}

class DelegatedValidateSelectImageEvent extends DelegatedStepsEvent {
  String imagePath;

  DelegatedValidateSelectImageEvent(this.imagePath);
}

class SetEditDateEvent extends DelegatedStepsEvent {}

class ValidateSignatureEvent extends DelegatedStepsEvent {
  Uint8List? bytes;

  ValidateSignatureEvent(this.bytes);
}

class ClearSignatureEvent extends DelegatedStepsEvent {}

///************** Authorized Events *************

class OnAuthorizedSaveEvent extends DelegatedStepsEvent {
  String name;
  String id;
  String mobileNo;
  String imagePath;
  List<PageField> questions;
  String countryCode;

  OnAuthorizedSaveEvent({
    required this.name,
    required this.id,
    required this.mobileNo,
    required this.imagePath,
    required this.questions,
    required this.countryCode,
  });
}

class SubmitDelegationEvent extends DelegatedStepsEvent {
  final String ownerIdPath;
  final String authIdPath;
  final Uint8List? ownerSignaturePath;
  final Uint8List authSignaturePath;
  final SubmitDelegatedRequest submitDelegatedRequest;

  SubmitDelegationEvent({
    required this.ownerIdPath,
    required this.authIdPath,
    required this.ownerSignaturePath,
    required this.authSignaturePath,
    required this.submitDelegatedRequest,
  });
}

class ValidateAuthNameFormatEvent extends DelegatedStepsEvent {
  String name;

  ValidateAuthNameFormatEvent(this.name);
}

class ValidateAuthMobileNumberFormatEvent extends DelegatedStepsEvent {
  String mobileNo;
  String code;

  ValidateAuthMobileNumberFormatEvent(this.mobileNo, this.code);
}

class AuthSaveSignatureEvent extends DelegatedStepsEvent {
  Uint8List? bytes;

  AuthSaveSignatureEvent(this.bytes);
}

/// ****************** Preview Events ******************
class PreviewOnTapDoneEvent extends DelegatedStepsEvent {}

/// ****************** Dynamic Widgets Events **********************
class MapQuestionToWidgetEvent extends DelegatedStepsEvent {}

class AuthMapQuestionToWidgetEvent extends DelegatedStepsEvent {}

class SelectSingleSelectionAnswerEvent extends DelegatedStepsEvent {
  final PageField question;
  final int answerId;

  SelectSingleSelectionAnswerEvent(
      {required this.question, required this.answerId});
}

class AuthSelectSingleSelectionAnswerEvent extends DelegatedStepsEvent {
  final PageField question;
  final int answerId;

  AuthSelectSingleSelectionAnswerEvent(
      {required this.question, required this.answerId});
}

class SelectMultiSelectionAnswerEvent extends DelegatedStepsEvent {
  final PageField question;
  final int answerId;

  SelectMultiSelectionAnswerEvent(
      {required this.question, required this.answerId});
}

class AuthSelectMultiSelectionAnswerEvent extends DelegatedStepsEvent {
  final PageField question;
  final int answerId;

  AuthSelectMultiSelectionAnswerEvent(
      {required this.question, required this.answerId});
}

class AddAnswerToQuestionEvent extends DelegatedStepsEvent {
  final PageField question;
  final dynamic answer;

  AddAnswerToQuestionEvent({required this.question, required this.answer});
}

class AuthAddAnswerToQuestionEvent extends DelegatedStepsEvent {
  final PageField question;
  final dynamic answer;

  AuthAddAnswerToQuestionEvent({required this.question, required this.answer});
}

class ShowMediaBottomSheetEvent extends DelegatedStepsEvent {
  final PageField question;

  ShowMediaBottomSheetEvent({required this.question});
}

class AuthShowMediaBottomSheetEvent extends DelegatedStepsEvent {
  final PageField question;

  AuthShowMediaBottomSheetEvent({required this.question});
}

class DeleteQuestionAnswerEvent extends DelegatedStepsEvent {
  final PageField question;

  DeleteQuestionAnswerEvent({required this.question});
}

class AuthDeleteQuestionAnswerEvent extends DelegatedStepsEvent {
  final PageField question;

  AuthDeleteQuestionAnswerEvent({required this.question});
}

class ShowDialogToDeleteQuestionAnswerEvent extends DelegatedStepsEvent {
  final PageField question;

  ShowDialogToDeleteQuestionAnswerEvent({required this.question});
}

class AuthShowDialogToDeleteQuestionAnswerEvent extends DelegatedStepsEvent {
  final PageField question;

  AuthShowDialogToDeleteQuestionAnswerEvent({required this.question});
}

class SelectDynamicImageEvent extends DelegatedStepsEvent {
  final XFile xFile;
  final PageField question;

  SelectDynamicImageEvent({required this.xFile, required this.question});
}

class AuthSelectDynamicImageEvent extends DelegatedStepsEvent {
  final XFile xFile;
  final PageField question;

  AuthSelectDynamicImageEvent({required this.xFile, required this.question});
}

class CheckValidationForAllQuestionEvent extends DelegatedStepsEvent {
  final String message;
  final String id;
  final String dateFrom;
  final String dateTo;

  CheckValidationForAllQuestionEvent({
    required this.message,
    required this.id,
    required this.dateFrom,
    required this.dateTo,
  });
}

class ScrollToUnAnsweredMandatoryQuestionEvent extends DelegatedStepsEvent {}

class AuthScrollToUnAnsweredMandatoryQuestionEvent
    extends DelegatedStepsEvent {}

class ShowQrSearchableBottomSheetEvent extends DelegatedStepsEvent {
  final PageField question;
  final bool isMultiChoice;

  ShowQrSearchableBottomSheetEvent({
    required this.question,
    required this.isMultiChoice,
  });
}

class OwnerUpdateSearchableSingleQuestionEvent extends DelegatedStepsEvent {
  final PageField question;
  final Choice answer;

  OwnerUpdateSearchableSingleQuestionEvent(
      {required this.question, required this.answer});
}

class OwnerUpdateSearchableMultiQuestionEvent extends DelegatedStepsEvent {
  final PageField question;
  final List<Choice> answer;

  OwnerUpdateSearchableMultiQuestionEvent(
      {required this.question, required this.answer});
}

class AuthUpdateSearchableSingleQuestionEvent extends DelegatedStepsEvent {
  final PageField question;
  final Choice answer;

  AuthUpdateSearchableSingleQuestionEvent(
      {required this.question, required this.answer});
}

class AuthUpdateSearchableMultiQuestionEvent extends DelegatedStepsEvent {
  final PageField question;
  final List<Choice> answer;

  AuthUpdateSearchableMultiQuestionEvent(
      {required this.question, required this.answer});
}
