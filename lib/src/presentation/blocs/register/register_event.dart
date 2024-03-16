part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class GetDocumentsPageEvent extends RegisterEvent {
  final PageFieldsRequest pageFieldsRequest;

  GetDocumentsPageEvent({
    required this.pageFieldsRequest,
  });
}

class NavigateToSelectCompoundScreenEvent extends RegisterEvent {}

class OpenUnitNumberBottomSheetEvent extends RegisterEvent {
  final int compoundId;

  OpenUnitNumberBottomSheetEvent({
    required this.compoundId,
  });
}

class ValidateCompoundNameEvent extends RegisterEvent {
  final String compoundName;

  ValidateCompoundNameEvent({
    required this.compoundName,
  });
}

class ValidateUnitNumberEvent extends RegisterEvent {
  final String unitNumber;

  ValidateUnitNumberEvent({
    required this.unitNumber,
  });
}

class ValidateTypeEvent extends RegisterEvent {
  final int type;

  ValidateTypeEvent({
    required this.type,
  });
}

class ValidateFullNameEvent extends RegisterEvent {
  final String fullName;

  ValidateFullNameEvent({
    required this.fullName,
  });
}

class ValidateEmailAddressEvent extends RegisterEvent {
  final String emailAddress;

  ValidateEmailAddressEvent({
    required this.emailAddress,
  });
}

class ValidateMobileNumberEvent extends RegisterEvent {
  final String mobileNumber;
  final String regionCode;

  ValidateMobileNumberEvent({
    required this.mobileNumber,
    required this.regionCode,
  });
}

class NavigateToLoginScreenEvent extends RegisterEvent {}

class NavigationPopEvent extends RegisterEvent {}

class CompoundSaveAndContinueEvent extends RegisterEvent {
  final String compoundName;
  final String unitNumber;
  final int nextPageId;

  CompoundSaveAndContinueEvent({
    required this.compoundName,
    required this.unitNumber,
    required this.nextPageId,
  });
}

class ProfileSaveAndContinueEvent extends RegisterEvent {
  final String fullName;
  final String mobileNumber;
  final String countryCode;
  final String emailAddress;
  final String password;
  final int nextPageId;
  final List<PageField> documents;

  ProfileSaveAndContinueEvent({
    required this.fullName,
    required this.mobileNumber,
    required this.countryCode,
    required this.emailAddress,
    required this.nextPageId,
    required this.password,
    required this.documents,
  });
}

class GetUserTypesEvent extends RegisterEvent {}

class SelectTypeEvent extends RegisterEvent {
  final int id;

  SelectTypeEvent({
    required this.id,
  });
}

class OnTapDocumentImageEvent extends RegisterEvent {
  final PageField document;

  OnTapDocumentImageEvent({
    required this.document,
  });
}

class OnTapDocumentFileEvent extends RegisterEvent {
  final PageField document;

  OnTapDocumentFileEvent({
    required this.document,
  });
}

class OpenCameraEvent extends RegisterEvent {
  final PageField document;

  OpenCameraEvent({
    required this.document,
  });
}

class OpenGalleryEvent extends RegisterEvent {
  final PageField document;

  OpenGalleryEvent({
    required this.document,
  });
}

class OnTapStepEvent extends RegisterEvent {
  final int id;

  OnTapStepEvent({
    required this.id,
  });
}

class SelectImageEvent extends RegisterEvent {
  final XFile xFile;
  final PageField document;

  SelectImageEvent({
    required this.xFile,
    required this.document,
  });
}

class SelectFileEvent extends RegisterEvent {
  final String file;
  final PageField document;

  SelectFileEvent({
    required this.file,
    required this.document,
  });
}

class DocumentsSaveAndContinueEvent extends RegisterEvent {
  final List<PageField> documents;
  final RegisterRequest request;

  DocumentsSaveAndContinueEvent({
    required this.documents,
    required this.request,
  });
}

class DeleteFileEvent extends RegisterEvent {
  final PageField document;

  DeleteFileEvent({
    required this.document,
  });
}

class ValidationFileEvent extends RegisterEvent {
  final PageField document;

  ValidationFileEvent({
    required this.document,
  });
}

class DeleteImageEvent extends RegisterEvent {
  final PageField document;

  DeleteImageEvent({
    required this.document,
  });
}

class GetDocumentsEvent extends RegisterEvent {}

class AddMultipleImageEvent extends RegisterEvent {
  final XFile image;
  final PageField document;

  AddMultipleImageEvent({
    required this.document,
    required this.image,
  });
}

class DeleteMultipleImageEvent extends RegisterEvent {
  final int index;
  final PageField document;

  DeleteMultipleImageEvent({
    required this.document,
    required this.index,
  });
}

class ValidatePasswordEvent extends RegisterEvent {
  final String password;

  ValidatePasswordEvent({
    required this.password,
  });
}

class NavigateToOTPScreenEvent extends RegisterEvent {
  final int userId;
  final String phoneNumber;
  final String otp;

  NavigateToOTPScreenEvent({
    required this.phoneNumber,
    required this.userId,
    required this.otp,
  });
}

class SelectMultipleImageEvent extends RegisterEvent {
  final List<File> images;
  final PageField document;

  SelectMultipleImageEvent({
    required this.images,
    required this.document,
  });
}

class ValidateMobileNumberWithApiEvent extends RegisterEvent {
  final String mobileNumber;
  final String emailAddress;
  final int nextPageId;

  ValidateMobileNumberWithApiEvent({
    required this.mobileNumber,
    required this.emailAddress,
    required this.nextPageId,
  });
}
