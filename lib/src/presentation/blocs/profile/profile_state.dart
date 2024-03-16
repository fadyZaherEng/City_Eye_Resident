// ignore_for_file: must_be_immutable

part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  ProfileState();

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ProfileInitial extends ProfileState {}

class ShowLoadingState extends ProfileState {}

class HideLoadingState extends ProfileState {}

class ShowSkeletonState extends ProfileState {}

class GetUserProfileSuccessState extends ProfileState {
  final Profile profile;

  GetUserProfileSuccessState({
    required this.profile,
  });
}

class UpdateFamilyMembersState extends ProfileState {
  final List<FamilyMember> familyMembers;

  UpdateFamilyMembersState({
    required this.familyMembers,
  });
}

class GetUserProfileErrorState extends ProfileState {
  final String message;

  GetUserProfileErrorState({
    required this.message,
  });
}

class ChangeCurrentStepState extends ProfileState {
  final int index;

  ChangeCurrentStepState({
    required this.index,
  });
}

class OpenMediaBottomSheetState extends ProfileState {
  final ProfileFile? file;
  final List<PageField>? questions;
  final PageField? question;
  final int? index;
  final bool isMultiImage;

  OpenMediaBottomSheetState({
    this.file,
    this.questions,
    this.question,
    this.index,
    this.isMultiImage = false,
  });
}

class AskForCameraPermissionState extends ProfileState {
  final Function() onTab;
  final Permission permission;

  AskForCameraPermissionState({
    required this.onTab,
    required this.permission,
  });
}

class AskForStoragePermissionState extends ProfileState {
  final ProfileFile file;

  AskForStoragePermissionState({
    required this.file,
  });
}

class UploadFileDocumentState extends ProfileState {
  final ProfileFile file;

  UploadFileDocumentState({
    required this.file,
  });
}

class OpenCameraState extends ProfileState {
  final ProfileFile? file;
  final List<PageField>? questions;
  final PageField? question;
  final int index;

  OpenCameraState({
    this.file,
    this.questions,
    this.question,
    this.index = -1,
  });
}

class OpenGalleryState extends ProfileState {
  final ProfileFile? file;
  final List<PageField>? questions;
  final PageField? question;
  final int index;
  final bool isMultiImage;

  OpenGalleryState({
    this.file,
    this.questions,
    this.question,
    this.index = -1,
    this.isMultiImage = false,
  });
}

class DisplayProfileImageState extends ProfileState {
  final String imagePath;
  final String message;

  DisplayProfileImageState({
    required this.imagePath,
    required this.message,
  });
}

class NavigateToAddFamilyMemberScreenState extends ProfileState {
  bool isUpdate;
  FamilyMember? familyMember;

  NavigateToAddFamilyMemberScreenState({
    this.isUpdate = false,
    this.familyMember,
  });
}

class OpenAddCarBottomSheetState extends ProfileState {
  Car? car;

  OpenAddCarBottomSheetState({
    this.car,
  });
}

class DeleteFamilyMemberSuccessState extends ProfileState {
  final FamilyMember familyMember;
  final String message;

  DeleteFamilyMemberSuccessState({
    required this.familyMember,
    required this.message,
  });
}

class DeleteFamilyMemberErrorState extends ProfileState {
  final String errorMessage;

  DeleteFamilyMemberErrorState({
    required this.errorMessage,
  });
}

class DeleteCarSuccessState extends ProfileState {
  final List<Car> cars;
  final String message;

  DeleteCarSuccessState({
    required this.cars,
    required this.message,
  });
}

class DeleteCarErrorState extends ProfileState {
  final String errorMessage;

  DeleteCarErrorState({
    required this.errorMessage,
  });
}

class SelectFileImageState extends ProfileState {
  final List<ProfileFile> files;

  SelectFileImageState({
    required this.files,
  });
}

class SelectMultiImagesState extends ProfileState {
  final List<ProfileFile> files;

  SelectMultiImagesState({
    required this.files,
  });
}

class DeleteFileImageState extends ProfileState {
  final List<ProfileFile> files;
  final bool isMultiImage;
  final int index;

  DeleteFileImageState({
    required this.files,
    this.isMultiImage = false,
    this.index = -1,
  });
}

class DeleteFileDocumentState extends ProfileState {
  final List<ProfileFile> files;

  DeleteFileDocumentState({
    required this.files,
  });
}

class SelectFileDocumentState extends ProfileState {
  final List<ProfileFile> files;

  SelectFileDocumentState({
    required this.files,
  });
}

class SaveFilesSuccessState extends ProfileState {
  final String messge;

  SaveFilesSuccessState({
    required this.messge,
  });
}

class SaveFilesErrorState extends ProfileState {
  final String errorMessage;

  SaveFilesErrorState({
    required this.errorMessage,
  });
}

class InvalidFilesFormState extends ProfileState {
  final List<ProfileFile> files;

  InvalidFilesFormState({
    required this.files,
  });
}

class ValidGasNumberState extends ProfileState {}

class InvalidGasNumberState extends ProfileState {
  final String errorMessage;

  InvalidGasNumberState({
    required this.errorMessage,
  });
}

class ValidTelephoneState extends ProfileState {}

class InvalidTelephoneState extends ProfileState {
  final String errorMessage;

  InvalidTelephoneState({
    required this.errorMessage,
  });
}

class ValidProfileUnitFormState extends ProfileState {
  final ProfileUnit unit;

  ValidProfileUnitFormState({
    required this.unit,
  });
}

class UpdateProfileUnitSuccessState extends ProfileState {
  final String message;

  UpdateProfileUnitSuccessState({
    required this.message,
  });
}

class UpdateProfileUnitErrorState extends ProfileState {
  final String errorMessage;

  UpdateProfileUnitErrorState({
    required this.errorMessage,
  });
}

class SelectProfileUnitUserTypeState extends ProfileState {
  final int userType;

  SelectProfileUnitUserTypeState({
    required this.userType,
  });
}

class ValidInfoNameState extends ProfileState {}

class InvalidInfoNameState extends ProfileState {
  final String errorMessage;

  InvalidInfoNameState({
    required this.errorMessage,
  });
}

class ValidInfoEmailState extends ProfileState {}

class InvalidInfoEmailState extends ProfileState {
  final String errorMessage;

  InvalidInfoEmailState({
    required this.errorMessage,
  });
}

class UpdateProfileInfoQuestionsState extends ProfileState {
  final List<PageField> questions;

  UpdateProfileInfoQuestionsState({
    required this.questions,
  });
}

class ValidProfileInfoFormState extends ProfileState {
  final Info info;

  ValidProfileInfoFormState({
    required this.info,
  });
}

class InvalidProfileInfoFormState extends ProfileState {
  final String? nameErrorMessage;
  final String? emailErrorMessage;
  final List<PageField> questions;

  InvalidProfileInfoFormState({
    required this.nameErrorMessage,
    required this.emailErrorMessage,
    required this.questions,
  });
}

class UpdateProfileInfoSuccessState extends ProfileState {
  final String message;

  UpdateProfileInfoSuccessState({
    required this.message,
  });
}

class UpdateProfileInfoErrorState extends ProfileState {
  final String errorMessage;

  UpdateProfileInfoErrorState({
    required this.errorMessage,
  });
}

class SelectFileDateState extends ProfileState {
  final List<ProfileFile> files;

  SelectFileDateState({
    required this.files,
  });
}

class NavigateBackState extends ProfileState {}

class UpdateFamilyMemberListState extends ProfileState {
  final List<FamilyMember> familyMembers;

  UpdateFamilyMemberListState({
    required this.familyMembers,
  });
}

class SuccessAddUserUnitCarState extends ProfileState {
  final List<Car> cars;

  SuccessAddUserUnitCarState(this.cars);
}

class SuccessUpdateUserUnitCarState extends ProfileState {
  final List<Car> cars;

  SuccessUpdateUserUnitCarState(this.cars);
}

class ShowQrSearchableBottomSheetState extends ProfileState {
  final List<PageField> questions;
  final PageField question;
  final bool isMultiChoice;

  ShowQrSearchableBottomSheetState({
    required this.questions,
    required this.question,
    required this.isMultiChoice,
  });
}

class UpdateSearchableSingleQuestionState extends ProfileState {
  final PageField question;
  final Choice answer;

  UpdateSearchableSingleQuestionState(
      {required this.question, required this.answer});
}

class UpdateSearchableMultiQuestionState extends ProfileState {
  final PageField question;
  final List<Choice> answer;

  UpdateSearchableMultiQuestionState(
      {required this.question, required this.answer});
}

class ScrollToFamilyMemberItemState extends ProfileState {
  final GlobalKey key;

  ScrollToFamilyMemberItemState({required this.key});
}