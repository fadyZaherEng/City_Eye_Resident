// ignore_for_file: must_be_immutable

part of 'delegated_steps_bloc.dart';

@immutable
abstract class DelegatedStepsState {}

class DelegatedStepsInitial extends DelegatedStepsState {}

class ShowStepsLoadingState extends DelegatedStepsState {}

class ShowStepsSkeletonState extends DelegatedStepsState {}

class HideStepsLoadingState extends DelegatedStepsState {}

class GetQuestionsSuccessState extends DelegatedStepsState {
  final List<PageField> ownerQuestions;
  final List<PageField> authQuestions;

  GetQuestionsSuccessState({
    required this.ownerQuestions,
    required this.authQuestions,
  });
}

class GetQuestionsErrorState extends DelegatedStepsState {
  final String errorMessage;

  GetQuestionsErrorState({
    required this.errorMessage,
  });
}

class OwnerGetUserInformationState extends DelegatedStepsState {
  User userInfo;
  String unitNumber;

  OwnerGetUserInformationState(this.userInfo, this.unitNumber);
}

class DelegatedImagePermissionDeniedState extends DelegatedStepsState {}

class DelegatedPickImageState extends DelegatedStepsState {
  File imageFile;

  DelegatedPickImageState(this.imageFile);
}

class DelegatedDeleteImageState extends DelegatedStepsState {}

class DelegatedShowMassageDialogState extends DelegatedStepsState {
  String message;
  String icon;

  DelegatedShowMassageDialogState(this.message, this.icon);
}

class DelegatedCaptureSignatureState extends DelegatedStepsState {}

class OnTapStepState extends DelegatedStepsState {
  final int id;

  OnTapStepState({
    required this.id,
  });
}

class OnOwnerSaveState extends DelegatedStepsState {
  final String message;
  final String id;
  final String dateFrom;
  final String dateTo;

  OnOwnerSaveState({
    required this.message,
    required this.id,
    required this.dateFrom,
    required this.dateTo,
  });
}

class DelegatedSelectedDateState extends DelegatedStepsState {
  String date;
  bool isFrom;

  DelegatedSelectedDateState(this.date, this.isFrom);
}

class DelegatedOnTapDeleteImageState extends DelegatedStepsState {}

class ValidateMessageValidFormatState extends DelegatedStepsState {}

class ValidateMessageEmptyFormatState extends DelegatedStepsState {
  final String messageValidatorMessage;

  ValidateMessageEmptyFormatState({
    required this.messageValidatorMessage,
  });
}

class ValidateIdValidFormatState extends DelegatedStepsState {}

class ValidateIdEmptyFormatState extends DelegatedStepsState {
  final String idValidatorMessage;

  ValidateIdEmptyFormatState({
    required this.idValidatorMessage,
  });
}

class ValidateDateFromValidFormatState extends DelegatedStepsState {}

class ValidateDateFromEmptyFormatState extends DelegatedStepsState {
  final String dateFromValidatorMessage;

  ValidateDateFromEmptyFormatState({
    required this.dateFromValidatorMessage,
  });
}

class ValidateDateToValidFormatState extends DelegatedStepsState {}

class ValidateDateToEmptyFormatState extends DelegatedStepsState {
  final String dateToValidatorMessage;

  ValidateDateToEmptyFormatState({
    required this.dateToValidatorMessage,
  });
}

class ValidateSelectImageValidState extends DelegatedStepsState {}

class ValidateSelectImageEmptyState extends DelegatedStepsState {
  String imageValidatorMessage;

  ValidateSelectImageEmptyState({required this.imageValidatorMessage});
}

class SetEditDateState extends DelegatedStepsState {}

class ValidateSignatureValidState extends DelegatedStepsState {
  Uint8List? bytes;

  ValidateSignatureValidState(this.bytes);
}

class ValidateSignatureEmptyState extends DelegatedStepsState {
  String signatureErrorMessage;

  ValidateSignatureEmptyState({required this.signatureErrorMessage});
}

class ClearSignatureState extends DelegatedStepsState {}

class ShowQrSearchableBottomSheetState extends DelegatedStepsState {
  final PageField question;
  final bool isMultiChoice;

  ShowQrSearchableBottomSheetState({
    required this.question,
    required this.isMultiChoice,
  });
}

//************** Authorized States *************

class AuthIsValidateState extends DelegatedStepsState {}

class OnAuthorizedSaveSuccessState extends DelegatedStepsState {
  final SubmitDelegation submitDelegation;

  OnAuthorizedSaveSuccessState({required this.submitDelegation});
}

class OnAuthorizedSaveErrorState extends DelegatedStepsState {
  final String errorMessage;

  OnAuthorizedSaveErrorState({required this.errorMessage});
}

class ValidateAuthNameValidFormatState extends DelegatedStepsState {}

class ValidateAuthNameEmptyFormatState extends DelegatedStepsState {
  final String nameValidatorMessage;

  ValidateAuthNameEmptyFormatState({
    required this.nameValidatorMessage,
  });
}

class ValidateAuthMobileNumberValidFormatState extends DelegatedStepsState {}

class ValidateAuthMobileNumberEmptyFormatState extends DelegatedStepsState {
  final String mobileValidatorMessage;

  ValidateAuthMobileNumberEmptyFormatState({
    required this.mobileValidatorMessage,
  });
}

class AuthSaveSignatureState extends DelegatedStepsState {
  Uint8List? bytes;

  AuthSaveSignatureState(this.bytes);
}

class PreviewOnTapDoneState extends DelegatedStepsState {}

//*******************  Dynamic Widgets State ***********************
class MapQuestionToWidgetState extends DelegatedStepsState {
  final List<PageField> questions;

  MapQuestionToWidgetState({required this.questions});
}

class AuthMapQuestionToWidgetState extends DelegatedStepsState {
  final List<PageField> questions;

  AuthMapQuestionToWidgetState({required this.questions});
}

class UpdateMapQuestionToWidgetState extends DelegatedStepsState {
  final List<PageField> questions;

  UpdateMapQuestionToWidgetState({required this.questions});
}

class UpdateAuthMapQuestionToWidgetState extends DelegatedStepsState {
  final List<PageField> questions;

  UpdateAuthMapQuestionToWidgetState({required this.questions});
}

class ShowMediaBottomSheetState extends DelegatedStepsState {
  final PageField question;

  ShowMediaBottomSheetState({required this.question});
}

class ShowDialogToDeleteQuestionAnswerState extends DelegatedStepsState {
  final PageField question;

  ShowDialogToDeleteQuestionAnswerState({required this.question});
}

class ScrollToUnAnsweredMandatoryQuestionState extends DelegatedStepsState {
  final GlobalKey key;

  ScrollToUnAnsweredMandatoryQuestionState({required this.key});
}
