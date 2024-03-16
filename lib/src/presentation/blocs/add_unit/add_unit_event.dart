part of 'add_unit_bloc.dart';

abstract class AddUnitEvent extends Equatable {
  @override
  List<Object?> get props => [
    identityHashCode(this),
  ];
}

class GetUserTypesEvent extends AddUnitEvent {}

class GetDocumentsPageEvent extends AddUnitEvent {
  final PageFieldsRequest pageFieldsRequest;

  GetDocumentsPageEvent({
    required this.pageFieldsRequest,
  });
}

class NavigateToSelectCompoundScreenEvent extends AddUnitEvent {}

class ValidateCompoundNameEvent extends AddUnitEvent {
  final String compoundName;

  ValidateCompoundNameEvent({
    required this.compoundName,
  });
}

class OpenUnitNumberBottomSheetEvent extends AddUnitEvent {
  final int compoundId;

  OpenUnitNumberBottomSheetEvent({
    required this.compoundId,
  });
}

class SelectTypeEvent extends AddUnitEvent {
  final int id;

  SelectTypeEvent({
    required this.id,
  });
}

class OnTapDocumentImageEvent extends AddUnitEvent {
  final PageField document;

  OnTapDocumentImageEvent({
    required this.document,
  });
}


class OpenCameraEvent extends AddUnitEvent {
  final PageField document;

  OpenCameraEvent({
    required this.document,
  });
}

class OpenGalleryEvent extends AddUnitEvent {
  final PageField document;

  OpenGalleryEvent({
    required this.document,
  });
}

class SelectImageEvent extends AddUnitEvent {
  final XFile xFile;
  final PageField document;

  SelectImageEvent({
    required this.xFile,
    required this.document,
  });
}

class OnTapDocumentFileEvent extends AddUnitEvent {
  final PageField document;

  OnTapDocumentFileEvent({
    required this.document,
  });
}

class SelectFileEvent extends AddUnitEvent {
  final String file;
  final PageField document;

  SelectFileEvent({
    required this.file,
    required this.document,
  });
}

class ValidationFileEvent extends AddUnitEvent {
  final PageField document;

  ValidationFileEvent({
    required this.document,
  });
}

class DeleteFileEvent extends AddUnitEvent {
  final PageField document;

  DeleteFileEvent({
    required this.document,
  });
}

class DeleteImageEvent extends AddUnitEvent {
  final PageField document;

  DeleteImageEvent({
    required this.document,
  });
}


class DeleteMultipleImageEvent extends AddUnitEvent {
  final int index;
  final PageField document;

  DeleteMultipleImageEvent({
    required this.document,
    required this.index,
  });
}

class SelectMultipleImageEvent extends AddUnitEvent {
  final List<File> images;
  final PageField document;

  SelectMultipleImageEvent({
    required this.images,
    required this.document,
  });
}

class AddMultipleImageEvent extends AddUnitEvent {
  final XFile image;
  final PageField document;

  AddMultipleImageEvent({
    required this.document,
    required this.image,
  });
}

class ValidateUnitNumberEvent extends AddUnitEvent {
  final String unitNumber;

  ValidateUnitNumberEvent({
    required this.unitNumber,
  });
}

class OnTapStepEvent extends AddUnitEvent {
  final int id;

  OnTapStepEvent({
    required this.id,
  });
}

class CompoundSaveAndContinueEvent extends AddUnitEvent {
  final String compoundName;
  final String unitNumber;
  final int nextPageId;

  CompoundSaveAndContinueEvent({
    required this.compoundName,
    required this.unitNumber,
    required this.nextPageId,
  });
}

class DocumentsSaveAndContinueEvent extends AddUnitEvent {
  final List<PageField> documents;
  final RegisterRequest request;
  final int userId;

  DocumentsSaveAndContinueEvent({
    required this.documents,
    required this.request,
    required this.userId,
  });
}

class CheckNewUnitEvent extends AddUnitEvent {
  final UserUnit userUnit;
  final String message;

  CheckNewUnitEvent({
    required this.userUnit,
    required this.message,
  });
}