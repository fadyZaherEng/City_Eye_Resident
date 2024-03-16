import 'dart:async';
import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/get_mobile_validation_error_message.dart';
import 'package:city_eye/src/core/utils/lookup_keys.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/core/utils/validation/register.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/register_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/validate_mobile_number_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/lookup_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/page_fields_request.dart';
import 'package:city_eye/src/domain/entities/register/otp.dart';
import 'package:city_eye/src/domain/entities/settings/lookup.dart';
import 'package:city_eye/src/domain/entities/settings/lookup_file.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/usecase/get_lookup_data_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_page_fields_use_case.dart';
import 'package:city_eye/src/domain/usecase/register_use_case.dart';
import 'package:city_eye/src/domain/usecase/register_validate_mobile_use_case.dart';
import 'package:city_eye/src/domain/usecase/register_validation_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:city_eye/src/domain/entities/settings/page.dart' as pg;
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final GetLookupDataUseCase _getLookupDataUseCase;
  final RegisterValidationUseCase _registerValidationUseCase;
  final GetPageFieldsUseCase _getPageFieldsUseCase;
  final RegisterUseCase _registerUseCase;
  final RegisterValidateMobileUseCase _registerValidateMobileUseCase;

  List<PageField> documents = [];
  List<LookupFile> _userTypes = [];

  RegisterBloc(
    this._getLookupDataUseCase,
    this._registerValidationUseCase,
    this._getPageFieldsUseCase,
    this._registerUseCase,
    this._registerValidateMobileUseCase,
  ) : super(RegisterInitialState()) {
    on<NavigateToLoginScreenEvent>(_onNavigateToLoginScreenEvent);
    on<NavigateToSelectCompoundScreenEvent>(_onOpenCompoundBottomSheetEvent);
    on<OpenUnitNumberBottomSheetEvent>(_onOpenUnitNumberBottomSheetEvent);
    on<NavigationPopEvent>(_onNavigationPopEvent);
    on<ValidateCompoundNameEvent>(_onValidateCompoundNameEvent);
    on<ValidateUnitNumberEvent>(_onValidateUnitNoEvent);
    on<ValidateTypeEvent>(_onValidateTypeEvent);
    on<ValidateFullNameEvent>(_onValidateFullNameEvent);
    on<ValidateEmailAddressEvent>(_onValidateEmailAddressEvent);
    on<ValidateMobileNumberEvent>(_onValidateMobileNumberEvent);
    on<ProfileSaveAndContinueEvent>(_onProfileSaveAndContinueEvent);
    on<CompoundSaveAndContinueEvent>(_onCompoundSaveAndContinueEvent);
    on<GetUserTypesEvent>(_onGetUserTypesEvent);
    on<SelectTypeEvent>(_onSelectTypeEvent);
    on<OnTapDocumentImageEvent>(_onTapDocumentImageEvent);
    on<OnTapDocumentFileEvent>(_onTapDocumentFileEvent);
    on<OpenCameraEvent>(_onOpenCameraEvent);
    on<OpenGalleryEvent>(_onOpenGalleryEvent);
    on<OnTapStepEvent>(_onTapStepEvent);
    on<SelectImageEvent>(_onSelectImageEvent);
    on<SelectFileEvent>(_onSelectFileEvent);
    on<DocumentsSaveAndContinueEvent>(_onDocumentsSaveAndContinueEvent);
    on<DeleteFileEvent>(_onDeleteFileEvent);
    on<ValidationFileEvent>(_onValidationFileEvent);
    on<DeleteImageEvent>(_onDeleteImageEvent);
    on<GetDocumentsEvent>(_onGetDocumentsEvent);
    on<AddMultipleImageEvent>(_onAddMultipleImageEvent);
    on<DeleteMultipleImageEvent>(_onDeleteMultipleImageEvent);
    on<ValidatePasswordEvent>(_onValidatePasswordEvent);
    on<GetDocumentsPageEvent>(_onGetDocumentsPageEvent);
    on<NavigateToOTPScreenEvent>(_onNavigateToOTPScreenEvent);
    on<SelectMultipleImageEvent>(_onSelectMultipleImageEvent);
    on<ValidateMobileNumberWithApiEvent>(_onValidateMobileNumberWithApiEvent);
  }

  FutureOr<void> _onNavigateToLoginScreenEvent(
      NavigateToLoginScreenEvent event, Emitter<RegisterState> emit) {
    emit(NavigateToLoginScreenState(documents: documents));
  }

  FutureOr<void> _onOpenCompoundBottomSheetEvent(
      NavigateToSelectCompoundScreenEvent event, Emitter<RegisterState> emit) {
    emit(NavigateToSelectCompoundScreenState());
  }

  FutureOr<void> _onOpenUnitNumberBottomSheetEvent(
      OpenUnitNumberBottomSheetEvent event, Emitter<RegisterState> emit) {
    if (event.compoundId == -1 || event.compoundId == 0) {
      emit(UnitNumberEmptyFormatState(
        unitNumberValidatorMessage:
            S.current.pleaseSelectCompoundBeforeChoosingTheUnit,
      ));
    } else {
      emit(OpenUnitNumberBottomSheetState());
    }
  }

  FutureOr<void> _onNavigationPopEvent(
      NavigationPopEvent event, Emitter<RegisterState> emit) {
    emit(NavigationPopState());
  }

  FutureOr<void> _onValidateCompoundNameEvent(
      ValidateCompoundNameEvent event, Emitter<RegisterState> emit) {
    RegisterValidationState validationState =
        _registerValidationUseCase.validateCompoundName(
      event.compoundName,
    );
    if (validationState == RegisterValidationState.valid) {
      emit(CompoundNameFormatValidState());
    } else {
      emit(CompoundNameEmptyFormatState(
        compoundNameValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onValidateUnitNoEvent(
      ValidateUnitNumberEvent event, Emitter<RegisterState> emit) {
    RegisterValidationState validationState =
        _registerValidationUseCase.validateUnitNumber(
      event.unitNumber,
    );
    if (validationState == RegisterValidationState.valid) {
      emit(UnitNumberFormatValidState());
    } else {
      emit(UnitNumberEmptyFormatState(
        unitNumberValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onValidateTypeEvent(
      ValidateTypeEvent event, Emitter<RegisterState> emit) {}

  FutureOr<void> _onValidateFullNameEvent(
      ValidateFullNameEvent event, Emitter<RegisterState> emit) {
    RegisterValidationState validationState =
        _registerValidationUseCase.validateFullName(
      event.fullName,
    );
    if (validationState == RegisterValidationState.valid) {
      emit(FullNameFormatValidState());
    } else if (validationState == RegisterValidationState.invalidFullName) {
      emit(FullNameEmptyFormatState(
        fullNameValidatorMessage:
            S.current.enterTwoWordsEachWordContains2Characters,
      ));
    } else if (validationState == RegisterValidationState.isNotEnglishName) {
      emit(FullNameEmptyFormatState(
        fullNameValidatorMessage:
            S.current.pleaseEnterOnlyEnglishCharactersInThisField,
      ));
    } else {
      emit(FullNameEmptyFormatState(
        fullNameValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onValidateEmailAddressEvent(
      ValidateEmailAddressEvent event, Emitter<RegisterState> emit) {
    RegisterValidationState validationState =
        _registerValidationUseCase.validateEmailAddress(
      event.emailAddress,
    );
    if (validationState == RegisterValidationState.valid) {
      emit(EmailAddressFormatValidState());
    } else if (validationState == RegisterValidationState.format) {
      emit(EmailNotValidState(
        emailValidatorMessage:
            S.current.pleaseEnterAValidEmailAddressForExample,
      ));
    } else {
      emit(EmailAddressEmptyFormatState(
        emailAddressValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onValidateMobileNumberEvent(
      ValidateMobileNumberEvent event, Emitter<RegisterState> emit) async {
    try {
      if (await PhoneNumberUtil.getNumberType(
              event.mobileNumber, event.regionCode) ==
          PhoneNumberType.MOBILE) {
        emit(MobileNumberFormatValidState());
      } else {
        emit(MobileNumberEmptyFormatState(
          mobileNumberValidatorMessage: getMobileValidationErrorMessage(
            mobileNumber: event.mobileNumber,
            regionCode: event.regionCode,
          ),
        ));
      }
    } catch (e) {
      emit(MobileNumberEmptyFormatState(
        mobileNumberValidatorMessage: getMobileValidationErrorMessage(
          mobileNumber: event.mobileNumber,
          regionCode: event.regionCode,
        ),
      ));
    }
  }

  FutureOr<void> _onProfileSaveAndContinueEvent(
      ProfileSaveAndContinueEvent event, Emitter<RegisterState> emit) async {
    final validationsState =
        _registerValidationUseCase.validateProfileFormUseCase(
      fullName: event.fullName,
      mobileNumber: event.mobileNumber,
      emailAddress: event.emailAddress,
      password: event.password,
    );
    bool isValid = true;
    if (validationsState.isNotEmpty) {
      for (var element in validationsState) {
        if (element == RegisterValidationState.fullNameEmpty) {
          emit(FullNameEmptyFormatState(
            fullNameValidatorMessage: S.current.thisFieldIsRequired,
          ));
          isValid = false;
        } else if (element == RegisterValidationState.invalidFullName) {
          emit(FullNameEmptyFormatState(
            fullNameValidatorMessage: S.current.invalidName,
          ));
          isValid = false;
        } else if (element == RegisterValidationState.isNotEnglishName) {
          emit(FullNameEmptyFormatState(
            fullNameValidatorMessage:
                S.current.pleaseEnterOnlyEnglishCharactersInThisField,
          ));
          isValid = false;
        } else if (element == RegisterValidationState.mobileNumberEmpty) {
          emit(MobileNumberEmptyFormatState(
            mobileNumberValidatorMessage: S.current.thisFieldIsRequired,
          ));
          isValid = false;
        } else if (element == RegisterValidationState.emailAddressEmpty) {
          emit(EmailAddressEmptyFormatState(
            emailAddressValidatorMessage: S.current.thisFieldIsRequired,
          ));
          isValid = false;
        } else if (element == RegisterValidationState.format) {
          emit(EmailNotValidState(
            emailValidatorMessage:
                S.current.pleaseEnterAValidEmailAddressForExample,
          ));
          isValid = false;
        } else if (element == RegisterValidationState.passwordEmpty) {
          emit(PasswordEmptyState(
            passwordValidatorMessage: S.current.thisFieldIsRequired,
          ));
          isValid = false;
        } else if (element == RegisterValidationState.format) {
          emit(PasswordNotValidState(
            passwordValidatorMessage:
                S.current.passwordMustBeAtLeast6CharactersLong,
          ));
          isValid = false;
        }
      }
    }

    try {
      if (await PhoneNumberUtil.getNumberType(
          event.mobileNumber, event.countryCode) !=
          PhoneNumberType.MOBILE) {
        emit(MobileNumberEmptyFormatState(
          mobileNumberValidatorMessage: getMobileValidationErrorMessage(
            mobileNumber: event.mobileNumber,
            regionCode: event.countryCode,
          ),
        ));
        isValid = false;
      }
    } catch (e) {
      emit(MobileNumberEmptyFormatState(
        mobileNumberValidatorMessage: getMobileValidationErrorMessage(
          mobileNumber: event.mobileNumber,
          regionCode: event.countryCode,
        ),
      ));
      isValid = false;
    }

    if (isValid) {
      if (event.documents.isNotEmpty) {
        add(ValidateMobileNumberWithApiEvent(
            mobileNumber: event.mobileNumber,
            emailAddress: event.emailAddress,
            nextPageId: event.nextPageId));
      } else {
        emit(ProfileSaveAndContinueValidState(
          nextPageId: event.nextPageId,
        ));
      }
    }
  }

  FutureOr<void> _onCompoundSaveAndContinueEvent(
      CompoundSaveAndContinueEvent event, Emitter<RegisterState> emit) {
    final validationsState =
        _registerValidationUseCase.validateCompoundFormUseCase(
      compoundName: event.compoundName,
      unitNumber: event.unitNumber,
    );
    if (validationsState.isNotEmpty) {
      for (var element in validationsState) {
        if (element == RegisterValidationState.compoundNameEmpty) {
          emit(CompoundNameEmptyFormatState(
            compoundNameValidatorMessage: S.current.thisFieldIsRequired,
          ));
        } else if (element == RegisterValidationState.unitNoEmpty) {
          emit(UnitNumberEmptyFormatState(
            unitNumberValidatorMessage: S.current.thisFieldIsRequired,
          ));
        }
      }
    } else {
      emit(CompoundSaveAndContinueValidState(nextPageId: event.nextPageId));
    }
  }

  FutureOr<void> _onGetUserTypesEvent(
      GetUserTypesEvent event, Emitter<RegisterState> emit) async {
    // emit(GetUserTypesSuccessState(
    //   userTypes: _userTypes,
    // ));
    emit(ShowSkeletonState());
    final DataState<List<Lookup>> dataState = await _getLookupDataUseCase([
      const LookupRequest(lookupCode: LookupKeys.userType),
    ]);
    if (dataState is DataSuccess) {
      _userTypes = dataState.data?.first.files ?? [];
      _userTypes.first = _userTypes.first.copyWith(isSelected: true);
      emit(GetUserTypesSuccessState(
        userTypes: _userTypes,
      ));
    } else if (dataState is DataFailed) {
      emit(GetUserTypesErrorState(message: dataState.message ?? ""));
    }

    // emit(HideLoadingState());
  }

  FutureOr<void> _onSelectTypeEvent(
      SelectTypeEvent event, Emitter<RegisterState> emit) {
    for (int i = 0; i < _userTypes.length; i++) {
      if (_userTypes[i].id == event.id) {
        _userTypes[i] = _userTypes[i].copyWith(isSelected: true);
      } else {
        _userTypes[i] = _userTypes[i].copyWith(isSelected: false);
      }
    }
    emit(OnSelectTypeState(id: event.id, userType: _userTypes));
  }

  FutureOr<void> _onTapDocumentImageEvent(
      OnTapDocumentImageEvent event, Emitter<RegisterState> emit) {
    emit(OnTapDocumentImageState(document: event.document));
  }

  FutureOr<void> _onTapDocumentFileEvent(
      OnTapDocumentFileEvent event, Emitter<RegisterState> emit) {
    emit(OnTapDocumentFileState(document: event.document));
  }

  FutureOr<void> _onOpenCameraEvent(
      OpenCameraEvent event, Emitter<RegisterState> emit) {
    emit(OpenCameraState(document: event.document));
  }

  FutureOr<void> _onOpenGalleryEvent(
      OpenGalleryEvent event, Emitter<RegisterState> emit) {
    emit(OpenGalleryState(document: event.document));
  }

  FutureOr<void> _onTapStepEvent(
      OnTapStepEvent event, Emitter<RegisterState> emit) {
    emit(OnTapStepState(id: event.id));
  }

  FutureOr<void> _onSelectImageEvent(
      SelectImageEvent event, Emitter<RegisterState> emit) {
    for (int i = 0; i < documents.length; i++) {
      if (event.document.id == documents[i].id) {
        documents[i] = documents[i].copyWith(value: event.xFile.path);
        break;
      }
    }

    emit(SelectImageState(documents: documents));
  }

  FutureOr<void> _onSelectFileEvent(
      SelectFileEvent event, Emitter<RegisterState> emit) {
    PageField? document;
    for (int i = 0; i < documents.length; i++) {
      if (event.document.id == documents[i].id) {
        documents[i] = documents[i].copyWith(value: event.file);
        document = documents[i];
        break;
      }
    }

    emit(SelectFileState(document: document!));
  }

  FutureOr<void> _onDocumentsSaveAndContinueEvent(
      DocumentsSaveAndContinueEvent event, Emitter<RegisterState> emit) async {
    bool hasErrorMessage = false;
    for (int i = 0; i < documents.length; i++) {
      if (documents[i].isRequired && documents[i].value.isEmpty) {
        if (documents[i].code == QuestionsCode.image) {
          documents[i] =
              documents[i].copyWith(errorMessage: S.current.theImageIsRequired);
          emit(DocumentsNotValidState(
            documents: event.documents,
          ));
          hasErrorMessage = true;
        } else if (documents[i].code == QuestionsCode.file) {
          documents[i] =
              documents[i].copyWith(errorMessage: S.current.theFilIsRequired);
          emit(DocumentsNotValidState(
            documents: event.documents,
          ));
          hasErrorMessage = true;
        } else if (documents[i].code == QuestionsCode.multiImage) {
          if (documents[i].isRequired && documents[i].imagesList.isEmpty) {
            documents[i] =
                documents[i].copyWith(errorMessage: S.current.theFilIsRequired);
            emit(DocumentsNotValidState(
              documents: event.documents,
            ));
            hasErrorMessage = true;
          }
        }
      } else {
        documents[i] = documents[i].copyWith(errorMessage: "");
      }
    }

    if (!hasErrorMessage) {
      emit(ShowLoadingState());
      final DataState<OTP> dataState = await _registerUseCase(
        event.request,
        -1,
      );
      if (dataState is DataSuccess) {
        emit(DocumentsSaveAndContinueState(
          userId: dataState.data?.userId ?? 0,
          message: dataState.message ?? "",
          otp: dataState.data?.number ?? "",
        ));
      } else {
        emit(RegisterErrorState(
          message: dataState.message ?? "",
        ));
      }

      emit(HideLoadingState());
    }
  }

  FutureOr<void> _onDeleteFileEvent(
      DeleteFileEvent event, Emitter<RegisterState> emit) {
    for (int i = 0; i < documents.length; i++) {
      if (event.document.id == documents[i].id) {
        documents[i] = documents[i].copyWith(value: "");
        break;
      }
    }
    emit(DeleteFileState(documents: documents));
  }

  FutureOr<void> _onValidationFileEvent(
      ValidationFileEvent event, Emitter<RegisterState> emit) async {
    File file = File(event.document.value);
    if (await file.exists()) {
      int fileSizeInBytes = await file.length();
      double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
      if (fileSizeInMB <= 20.0) {
        for (int i = 0; i < documents.length; i++) {
          if (event.document.id == documents[i].id) {
            documents[i] = documents[i].copyWith(
              value: event.document.value,
              fileValid: true,
            );
          }
        }
        emit(FileValidState(documents: documents));
      } else {
        for (int i = 0; i < documents.length; i++) {
          if (event.document.id == documents[i].id) {
            documents[i] = documents[i].copyWith(
              value: "",
              fileValid: false,
            );
          }
        }
        emit(FileNotValidState(documents: documents));
      }
    } else {
      emit(FieldValidationFileState());
    }
  }

  FutureOr<void> _onDeleteImageEvent(
      DeleteImageEvent event, Emitter<RegisterState> emit) {
    for (int i = 0; i < documents.length; i++) {
      if (event.document.id == documents[i].id) {
        documents[i] = documents[i].copyWith(value: "");
        break;
      }
    }
    emit(DeleteImageState(documents: documents));
  }

  FutureOr<void> _onGetDocumentsEvent(
      GetDocumentsEvent event, Emitter<RegisterState> emit) {
    emit(GetDocumentsSuccessState(documents: documents));
  }

  FutureOr<void> _onAddMultipleImageEvent(
      AddMultipleImageEvent event, Emitter<RegisterState> emit) {
    for (int i = 0; i < documents.length; i++) {
      if (event.document.id == documents[i].id) {
        documents[i].imagesList.add(File(event.image.path));
        documents[i] = documents[i].copyWith(
          errorMessage: "",
        );
      }
    }
    emit(AddMultipleImageState(documents: documents));
  }

  FutureOr<void> _onDeleteMultipleImageEvent(
      DeleteMultipleImageEvent event, Emitter<RegisterState> emit) {
    for (int i = 0; i < documents.length; i++) {
      if (event.document.id == documents[i].id) {
        documents[i].imagesList.removeAt(event.index);
      }
    }
    emit(DeleteMultipleImageState(
        documents: documents, isMultiImage: true, index: event.index));
  }

  FutureOr<void> _onValidatePasswordEvent(
      ValidatePasswordEvent event, Emitter<RegisterState> emit) {
    RegisterValidationState validationState =
        _registerValidationUseCase.validatePassword(
      event.password,
    );
    if (validationState == RegisterValidationState.valid) {
      emit(PasswordFormatValidState());
    } else if (validationState == RegisterValidationState.format) {
      emit(PasswordNotValidState(
        passwordValidatorMessage:
            S.current.passwordMustBeAtLeast6CharactersLong,
      ));
    } else {
      emit(PasswordEmptyState(
        passwordValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onGetDocumentsPageEvent(
      GetDocumentsPageEvent event, Emitter<RegisterState> emit) async {
    final DataState<List<pg.Page>> dataState =
        await _getPageFieldsUseCase(event.pageFieldsRequest);
    if (dataState is DataSuccess) {
      documents = (dataState.data ?? []).first.fields;
      emit(GetDocumentsPageSuccessState(fields: documents));
    } else {
      emit(GetDocumentsPageErrorState(errorMessage: dataState.message ?? ""));
    }
  }

  FutureOr<void> _onNavigateToOTPScreenEvent(
      NavigateToOTPScreenEvent event, Emitter<RegisterState> emit) {
    emit(NavigateToOTPScreenState(
      userId: event.userId,
      phoneNumber: event.phoneNumber,
      otp: event.otp,
    ));
  }

  FutureOr<void> _onSelectMultipleImageEvent(
      SelectMultipleImageEvent event, Emitter<RegisterState> emit) {
    for (int i = 0; i < documents.length; i++) {
      if (event.document.id == documents[i].id) {
        documents[i] = event.document;
        documents[i] = documents[i].copyWith(
          errorMessage: "",
        );
      }
    }

    emit(SelectMultipleImageState(
      documents: documents,
    ));
  }

  FutureOr<void> _onValidateMobileNumberWithApiEvent(
      ValidateMobileNumberWithApiEvent event,
      Emitter<RegisterState> emit) async {
    emit(ShowLoadingState());
    final DataState dataState = await _registerValidateMobileUseCase(
        ValidateMobileNumberRequest(
            mobileNumber: event.mobileNumber, email: event.emailAddress));
    if (dataState is DataSuccess) {
      emit(ProfileSaveAndContinueValidState(
        nextPageId: event.nextPageId,
      ));
    } else {
      emit(ValidateMobileNumberWithApiErrorState(
          errorMessage: dataState.message ?? ""));
    }

    emit(HideLoadingState());
  }
}
