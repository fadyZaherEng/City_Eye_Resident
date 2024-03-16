part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  ProfileEvent();

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class StepPressedEvent extends ProfileEvent {
  final int index;

  StepPressedEvent({
    required this.index,
  });
}

class GetUserProfileEvent extends ProfileEvent {
  GetUserProfileEvent();
}

class UpdateFamilyMembersEvent extends ProfileEvent {
  final List<FamilyMember> familyMembers;

  UpdateFamilyMembersEvent({
    required this.familyMembers,
  });
}

class UploadProfileImagePressedEvent extends ProfileEvent {}

class AskForCameraPermissionEvent extends ProfileEvent {
  final Function() onTab;
  final Permission permission;

  AskForCameraPermissionEvent({
    required this.onTab,
    required this.permission,
  });
}

class AskForStoragePermissionEvent extends ProfileEvent {
  final ProfileFile file;

  AskForStoragePermissionEvent({
    required this.file,
  });
}

class CameraPressedEvent extends ProfileEvent {
  final ProfileFile? file;
  final List<PageField>? questions;
  final PageField? question;
  final int index;

  CameraPressedEvent({
    this.file,
    this.questions,
    this.question,
    this.index = -1,
  });
}

class GalleryPressedEvent extends ProfileEvent {
  final ProfileFile? file;
  final List<PageField>? questions;
  final PageField? question;
  final int index;
  final bool isMultiImage;

  GalleryPressedEvent({
    this.file,
    this.questions,
    this.question,
    this.index = -1,
    this.isMultiImage = false,
  });
}

class SelectImageEvent extends ProfileEvent {
  final String imagePath;

  SelectImageEvent({
    required this.imagePath,
  });
}

class AddPressedEvent extends ProfileEvent {
  final bool isUpdate;
  final int page;
  final FamilyMember? familyMember;
  final Car? car;

  AddPressedEvent({
    required this.page,
    this.isUpdate = false,
    this.familyMember,
    this.car,
  });
}

class DeleteFamilyMemberEvent extends ProfileEvent {
  final FamilyMember familyMember;

  DeleteFamilyMemberEvent({
    required this.familyMember,
  });
}

class DeleteCarEvent extends ProfileEvent {
  final List<Car> cars;
  final Car car;

  DeleteCarEvent({
    required this.cars,
    required this.car,
  });
}

class UploadFileImageEvent extends ProfileEvent {
  final ProfileFile file;
  final int index;
  final bool isMultiImage;

  UploadFileImageEvent({
    required this.file,
    this.index = -1,
    this.isMultiImage = false,
  });
}

class UploadProfileInfoImage extends ProfileEvent {
  final List<PageField> questions;
  final PageField question;

  UploadProfileInfoImage({
    required this.questions,
    required this.question,
  });
}

class UploadFileDocumentEvent extends ProfileEvent {
  final ProfileFile file;

  UploadFileDocumentEvent({
    required this.file,
  });
}

class SelectFileExpireDateEvent extends ProfileEvent {
  final List<ProfileFile> files;
  final ProfileFile file;
  final DateTime date;

  SelectFileExpireDateEvent({
    required this.files,
    required this.file,
    required this.date,
  });
}

class SelectFileImageEvent extends ProfileEvent {
  final List<ProfileFile> files;
  final ProfileFile file;
  final int index;

  SelectFileImageEvent({
    required this.files,
    required this.file,
    required this.index,
  });
}

class DeleteFileImageEvent extends ProfileEvent {
  final List<ProfileFile> files;
  final ProfileFile file;
  final int index;
  final bool isMultiImage;

  DeleteFileImageEvent({
    required this.files,
    required this.file,
    this.index = -1,
    this.isMultiImage = false,
  });
}

class DeleteFileDocumentEvent extends ProfileEvent {
  final List<ProfileFile> files;
  final ProfileFile file;

  DeleteFileDocumentEvent({
    required this.files,
    required this.file,
  });
}

class SelectFileDocumentEvent extends ProfileEvent {
  final List<ProfileFile> files;
  final ProfileFile file;

  SelectFileDocumentEvent({
    required this.files,
    required this.file,
  });
}

class SaveFilesPressedEvent extends ProfileEvent {
  final List<ProfileFile> files;

  SaveFilesPressedEvent({
    required this.files,
  });
}

class ValidateGasNumberEvent extends ProfileEvent {
  final String value;

  ValidateGasNumberEvent({
    required this.value,
  });
}

class ValidateTelephoneEvent extends ProfileEvent {
  final String value;

  ValidateTelephoneEvent({
    required this.value,
  });
}

class UnitSaveButtonPressedEvent extends ProfileEvent {
  final ProfileUnit unit;

  UnitSaveButtonPressedEvent({
    required this.unit,
  });
}

class UpdateProfileUnitEvent extends ProfileEvent {
  UpdateUserUnitRequest request;

  UpdateProfileUnitEvent({
    required this.request,
  });
}

class SelectProfileUnitUserTypeEvent extends ProfileEvent {
  final int userType;

  SelectProfileUnitUserTypeEvent({
    required this.userType,
  });
}

class ValidateInfoNameEvent extends ProfileEvent {
  final String value;

  ValidateInfoNameEvent({
    required this.value,
  });
}

class ValidateInfoEmailEvent extends ProfileEvent {
  final String value;

  ValidateInfoEmailEvent({
    required this.value,
  });
}

class InfoSaveButtonPressedEvent extends ProfileEvent {
  final Info info;

  InfoSaveButtonPressedEvent({
    required this.info,
  });
}

class SelectSingleSelectionAnswerEvent extends ProfileEvent {
  final List<PageField> questions;
  final PageField question;
  final int answerId;

  SelectSingleSelectionAnswerEvent({
    required this.questions,
    required this.question,
    required this.answerId,
  });
}

class SelectMultiSelectionAnswerEvent extends ProfileEvent {
  final List<PageField> questions;
  final PageField question;
  final int answerId;

  SelectMultiSelectionAnswerEvent({
    required this.questions,
    required this.question,
    required this.answerId,
  });
}

class DeleteQuestionAnswerEvent extends ProfileEvent {
  final List<PageField> questions;
  final PageField question;

  DeleteQuestionAnswerEvent({
    required this.questions,
    required this.question,
  });
}

class AddAnswerToQuestionEvent extends ProfileEvent {
  final List<PageField> questions;
  final PageField question;
  final dynamic answer;

  AddAnswerToQuestionEvent({
    required this.questions,
    required this.question,
    required this.answer,
  });
}

class SelectQuestionImageEvent extends ProfileEvent {
  final List<PageField> questions;
  final PageField question;
  final String imagePath;

  SelectQuestionImageEvent({
    required this.questions,
    required this.question,
    required this.imagePath,
  });
}

class DeleteQuestionImageEvent extends ProfileEvent {
  final List<PageField> questions;
  final PageField question;

  DeleteQuestionImageEvent({
    required this.questions,
    required this.question,
  });
}

class UpdateProfileInfoEvent extends ProfileEvent {
  final Info info;

  UpdateProfileInfoEvent({
    required this.info,
  });
}

class NavigateBackEvent extends ProfileEvent {}

class UpdateFamilyMemberListEvent extends ProfileEvent {
  final List<FamilyMember> familyMembers;

  UpdateFamilyMemberListEvent({
    required this.familyMembers,
  });
}

class AddUserUnitCarEvent extends ProfileEvent {
  final List<Car> cars;

  AddUserUnitCarEvent(this.cars);
}

class UpdateUserUnitCarEvent extends ProfileEvent {
  final List<Car> cars;

  UpdateUserUnitCarEvent(this.cars);
}

class SelectMultiImageEvent extends ProfileEvent {
  final List<ProfileFile> files;
  final ProfileFile file;
  final int index;

  SelectMultiImageEvent({
    required this.files,
    required this.file,
    required this.index,
  });
}

class ShowQrSearchableBottomSheetEvent extends ProfileEvent {
  final List<PageField> questions;
  final PageField question;
  final bool isMultiChoice;

  ShowQrSearchableBottomSheetEvent({
    required this.questions,
    required this.question,
    required this.isMultiChoice,
  });
}

class UpdateSearchableSingleQuestionEvent extends ProfileEvent {
  final List<PageField> questions;
  final PageField question;
  final Choice answer;

  UpdateSearchableSingleQuestionEvent(
      {required this.questions, required this.question, required this.answer});
}

class UpdateSearchableMultiQuestionEvent extends ProfileEvent {
  final List<PageField> questions;
  final PageField question;
  final List<Choice> answer;

  UpdateSearchableMultiQuestionEvent(
      {required this.questions, required this.question, required this.answer});
}

class ScrollToFamilyMemberItemEvent extends ProfileEvent {
  final GlobalKey key;

  ScrollToFamilyMemberItemEvent({required this.key});
}
