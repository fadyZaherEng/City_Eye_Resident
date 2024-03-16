part of 'add_unit_bloc.dart';

abstract class AddUnitState extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class AddUnitInitial extends AddUnitState {}

class ShowLoadingState extends AddUnitState {}

class HideLoadingState extends AddUnitState {}

class GetUserTypesSuccessState extends AddUnitState {
  final List<LookupFile> userTypes;

  GetUserTypesSuccessState({
    required this.userTypes,
  });
}

class GetUserTypesErrorState extends AddUnitState {
  final String message;

  GetUserTypesErrorState({
    required this.message,
  });
}

class GetDocumentsPageSuccessState extends AddUnitState {
  final List<PageField> fields;

  GetDocumentsPageSuccessState({
    required this.fields,
  });
}

class GetDocumentsPageErrorState extends AddUnitState {
  final String errorMessage;

  GetDocumentsPageErrorState({
    required this.errorMessage,
  });
}

class NavigateToSelectCompoundScreenState extends AddUnitState {}

class CompoundNameFormatValidState extends AddUnitState {}

class CompoundNameEmptyFormatState extends AddUnitState {
  final String compoundNameValidatorMessage;

  CompoundNameEmptyFormatState({
    required this.compoundNameValidatorMessage,
  });
}

class OnSelectTypeState extends AddUnitState {
  final int id;
  final List<LookupFile> userType;

  OnSelectTypeState({
    required this.id,
    required this.userType,
  });
}

class OnTapDocumentImageState extends AddUnitState {
  final PageField document;

  OnTapDocumentImageState({
    required this.document,
  });
}

class OpenCameraState extends AddUnitState {
  final PageField document;

  OpenCameraState({
    required this.document,
  });
}

class OpenGalleryState extends AddUnitState {
  final PageField document;

  OpenGalleryState({
    required this.document,
  });
}

class SelectImageState extends AddUnitState {
  final List<PageField> documents;

  SelectImageState({
    required this.documents,
  });
}
class OnTapDocumentFileState extends AddUnitState {
  final PageField document;

  OnTapDocumentFileState({
    required this.document,
  });
}

class SelectFileState extends AddUnitState {
  final PageField document;

  SelectFileState({
    required this.document,
  });
}

class FileValidState extends AddUnitState {
  final List<PageField> documents;

  FileValidState({
    required this.documents,
  });
}

class FileNotValidState extends AddUnitState {
  final List<PageField> documents;

  FileNotValidState({
    required this.documents,
  });
}

class FieldValidationFileState extends AddUnitState {}

class DeleteFileState extends AddUnitState {
  final List<PageField> documents;

  DeleteFileState({
    required this.documents,
  });
}

class DeleteImageState extends AddUnitState {
  final List<PageField> documents;

  DeleteImageState({
    required this.documents,
  });
}

class DeleteMultipleImageState extends AddUnitState {
  final List<PageField> documents;
  final bool isMultiImage;
  final int index;

  DeleteMultipleImageState({
    required this.documents,
    this.isMultiImage = false,
    this.index = -1,
  });
}


class SelectMultipleImageState extends AddUnitState {
  final List<PageField> documents;

  SelectMultipleImageState({
    required this.documents,
  });
}

class AddMultipleImageState extends AddUnitState {
  final List<PageField> documents;

  AddMultipleImageState({
    required this.documents,
  });
}

class UnitNumberEmptyFormatState extends AddUnitState {
  final String unitNumberValidatorMessage;

  UnitNumberEmptyFormatState({
    required this.unitNumberValidatorMessage,
  });
}

class OpenUnitNumberBottomSheetState extends AddUnitState {}

class UnitNumberFormatValidState extends AddUnitState {}

class CompoundSaveAndContinueValidState extends AddUnitState {
  final int nextPageId;

  CompoundSaveAndContinueValidState({
    required this.nextPageId,
  });
}


class OnTapStepState extends AddUnitState {
  final int id;

  OnTapStepState({
    required this.id,
  });
}

class DocumentsNotValidState extends AddUnitState {
  final List<PageField> documents;

  DocumentsNotValidState({
    required this.documents,
  });
}

class RegisterErrorState extends AddUnitState {
  final String message;

  RegisterErrorState({
    required this.message,
  });
}

class AddUnitSuccessState extends AddUnitState {
  final String message;
  final UserUnit userUnit;

  AddUnitSuccessState({
    required this.message,
    required this.userUnit,
  });
}

class NewUnitIsActiveState extends AddUnitState {
  final String message;

  NewUnitIsActiveState({
    required this.message,
  });
}

class NewUnitNotActiveState extends AddUnitState {
  final String message;

  NewUnitNotActiveState({
    required this.message,
  });
}

class NavigateToLoginState extends AddUnitState {
  final String message;

  NavigateToLoginState({
    required this.message,
  });
}