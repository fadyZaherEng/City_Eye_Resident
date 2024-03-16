part of 'register_bloc.dart';

@immutable
abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class RegisterInitialState extends RegisterState {}

class ShowSkeletonState extends RegisterState {}

class ShowLoadingState extends RegisterState {}

class HideLoadingState extends RegisterState {}

class GetDocumentsPageSuccessState extends RegisterState {
  final List<PageField> fields;

  GetDocumentsPageSuccessState({
    required this.fields,
  });
}

class GetDocumentsPageErrorState extends RegisterState {
  final String errorMessage;

  GetDocumentsPageErrorState({
    required this.errorMessage,
  });
}

class NavigateToSelectCompoundScreenState extends RegisterState {}

class OpenUnitNumberBottomSheetState extends RegisterState {}

class CompoundNameEmptyFormatState extends RegisterState {
  final String compoundNameValidatorMessage;

  CompoundNameEmptyFormatState({
    required this.compoundNameValidatorMessage,
  });
}

class UnitNumberEmptyFormatState extends RegisterState {
  final String unitNumberValidatorMessage;

  UnitNumberEmptyFormatState({
    required this.unitNumberValidatorMessage,
  });
}

class TypeEmptyFormatState extends RegisterState {
  final String typeValidatorMessage;

  TypeEmptyFormatState({
    required this.typeValidatorMessage,
  });
}

class FullNameEmptyFormatState extends RegisterState {
  final String fullNameValidatorMessage;

  FullNameEmptyFormatState({
    required this.fullNameValidatorMessage,
  });
}

class EmailAddressEmptyFormatState extends RegisterState {
  final String emailAddressValidatorMessage;

  EmailAddressEmptyFormatState({
    required this.emailAddressValidatorMessage,
  });
}

class EmailNotValidState extends RegisterState {
  final String emailValidatorMessage;

  EmailNotValidState({
    required this.emailValidatorMessage,
  });
}

class MobileNumberEmptyFormatState extends RegisterState {
  final String mobileNumberValidatorMessage;

  MobileNumberEmptyFormatState({
    required this.mobileNumberValidatorMessage,
  });
}

class EmailAddressFormatValidState extends RegisterState {}

class FullNameFormatValidState extends RegisterState {}

class UnitNumberFormatValidState extends RegisterState {}

class CompoundNameFormatValidState extends RegisterState {}

class MobileNumberFormatValidState extends RegisterState {}

class TypeFormatValidState extends RegisterState {}

class NavigateToLoginScreenState extends RegisterState {
  final List<PageField> documents;

  NavigateToLoginScreenState({
    required this.documents,
  });
}

class NavigationPopState extends RegisterState {}

class CompoundSaveAndContinueValidState extends RegisterState {
  final int nextPageId;

  CompoundSaveAndContinueValidState({
    required this.nextPageId,
  });
}

class ProfileSaveAndContinueValidState extends RegisterState {
  final int nextPageId;

  ProfileSaveAndContinueValidState({
    required this.nextPageId,
  });
}

class ValidateMobileNumberWithApiErrorState extends RegisterState {
  final String errorMessage;

  ValidateMobileNumberWithApiErrorState({
    required this.errorMessage,
  });
}

class GetUserTypesSuccessState extends RegisterState {
  final List<LookupFile> userTypes;

  GetUserTypesSuccessState({
    required this.userTypes,
  });
}

class GetUserTypesErrorState extends RegisterState {
  final String message;

  GetUserTypesErrorState({
    required this.message,
  });
}

class OnSelectTypeState extends RegisterState {
  final int id;
  final List<LookupFile> userType;

  OnSelectTypeState({
    required this.id,
    required this.userType,
  });
}

class OnTapDocumentImageState extends RegisterState {
  final PageField document;

  OnTapDocumentImageState({
    required this.document,
  });
}

class OnTapDocumentFileState extends RegisterState {
  final PageField document;

  OnTapDocumentFileState({
    required this.document,
  });
}

class OpenCameraState extends RegisterState {
  final PageField document;

  OpenCameraState({
    required this.document,
  });
}

class OpenGalleryState extends RegisterState {
  final PageField document;

  OpenGalleryState({
    required this.document,
  });
}

class OnTapStepState extends RegisterState {
  final int id;

  OnTapStepState({
    required this.id,
  });
}

class SelectImageState extends RegisterState {
  final List<PageField> documents;

  SelectImageState({
    required this.documents,
  });
}

class SelectFileState extends RegisterState {
  final PageField document;

  SelectFileState({
    required this.document,
  });
}

class DocumentsSaveAndContinueState extends RegisterState {
  final int userId;
  final String message;
  final String otp;

  DocumentsSaveAndContinueState({
    required this.userId,
    required this.message,
    required this.otp,
  });
}

class RegisterErrorState extends RegisterState {
  final String message;

  RegisterErrorState({
    required this.message,
  });
}

class DeleteFileState extends RegisterState {
  final List<PageField> documents;

  DeleteFileState({
    required this.documents,
  });
}

class FileValidState extends RegisterState {
  final List<PageField> documents;

  FileValidState({
    required this.documents,
  });
}

class FileNotValidState extends RegisterState {
  final List<PageField> documents;

  FileNotValidState({
    required this.documents,
  });
}

class FieldValidationFileState extends RegisterState {}

class DeleteImageState extends RegisterState {
  final List<PageField> documents;

  DeleteImageState({
    required this.documents,
  });
}

class GetDocumentsSuccessState extends RegisterState {
  final List<PageField> documents;

  GetDocumentsSuccessState({
    required this.documents,
  });
}

class DocumentsNotValidState extends RegisterState {
  final List<PageField> documents;

  DocumentsNotValidState({
    required this.documents,
  });
}

class AddMultipleImageState extends RegisterState {
  final List<PageField> documents;

  AddMultipleImageState({
    required this.documents,
  });
}

class DeleteMultipleImageState extends RegisterState {
  final List<PageField> documents;
  final bool isMultiImage;
  final int index;

  DeleteMultipleImageState({
    required this.documents,
    this.isMultiImage = false,
    this.index = -1,
  });
}

class PasswordFormatValidState extends RegisterState {}

class PasswordEmptyState extends RegisterState {
  final String passwordValidatorMessage;

  PasswordEmptyState({
    required this.passwordValidatorMessage,
  });
}

class PasswordNotValidState extends RegisterState {
  final String passwordValidatorMessage;

  PasswordNotValidState({
    required this.passwordValidatorMessage,
  });
}


class NavigateToOTPScreenState extends RegisterState {
  final int userId;
  final String phoneNumber;
  final String otp;

  NavigateToOTPScreenState({
    required this.userId,
    required this.phoneNumber,
    required this.otp,
  });
}

class SelectMultipleImageState extends RegisterState {
  final List<PageField> documents;

  SelectMultipleImageState({
    required this.documents,
  });
}
