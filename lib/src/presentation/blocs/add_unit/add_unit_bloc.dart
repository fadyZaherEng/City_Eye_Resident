import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/lookup_keys.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/core/utils/validation/register.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/register_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/lookup_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/page_fields_request.dart';
import 'package:city_eye/src/domain/entities/register/otp.dart';
import 'package:city_eye/src/domain/entities/settings/lookup.dart';
import 'package:city_eye/src/domain/entities/settings/lookup_file.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/domain/usecase/get_lookup_data_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_page_fields_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/register_use_case.dart';
import 'package:city_eye/src/domain/usecase/register_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/save_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_user_unit_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:city_eye/src/domain/entities/settings/page.dart' as pg;
import 'package:flutter_image_compress/flutter_image_compress.dart';

part 'add_unit_event.dart';

part 'add_unit_state.dart';

class AddUnitBloc extends Bloc<AddUnitEvent, AddUnitState> {
  final GetPageFieldsUseCase _getPageFieldsUseCase;
  final GetLookupDataUseCase _getLookupDataUseCase;
  final RegisterValidationUseCase _registerValidationUseCase;
  final RegisterUseCase _registerUseCase;
  final SetUserUnitUseCase _setUserUnitUseCase;
  final GetUserInformationUseCase _getUserInformationUseCase;
  final SaveUserInformationUseCase _saveUserInformationUseCase;

  List<PageField> _documents = [];
  List<LookupFile> _userTypes = [];

  AddUnitBloc(
    this._getLookupDataUseCase,
    this._getPageFieldsUseCase,
    this._registerValidationUseCase,
    this._registerUseCase,
    this._setUserUnitUseCase,
    this._getUserInformationUseCase,
    this._saveUserInformationUseCase,
  ) : super(AddUnitInitial()) {
    on<GetUserTypesEvent>(_onGetUserTypesEvent);
    on<GetDocumentsPageEvent>(_onGetDocumentsPageEvent);
    on<NavigateToSelectCompoundScreenEvent>(
        _onNavigateToSelectCompoundScreenEvent);
    on<ValidateCompoundNameEvent>(_onValidateCompoundNameEvent);
    on<SelectTypeEvent>(_onSelectTypeEvent);
    on<OnTapDocumentImageEvent>(_onTapDocumentImageEvent);
    on<OpenCameraEvent>(_onOpenCameraEvent);
    on<OpenGalleryEvent>(_onOpenGalleryEvent);
    on<SelectImageEvent>(_onSelectImageEvent);
    on<OnTapDocumentFileEvent>(_onTapDocumentFileEvent);
    on<SelectFileEvent>(_onSelectFileEvent);
    on<ValidationFileEvent>(_onValidationFileEvent);
    on<DeleteFileEvent>(_onDeleteFileEvent);
    on<DeleteImageEvent>(_onDeleteImageEvent);
    on<DeleteMultipleImageEvent>(_onDeleteMultipleImageEvent);
    on<SelectMultipleImageEvent>(_onSelectMultipleImageEvent);
    on<AddMultipleImageEvent>(_onAddMultipleImageEvent);
    on<OpenUnitNumberBottomSheetEvent>(_onOpenUnitNumberBottomSheetEvent);
    on<ValidateUnitNumberEvent>(_onValidateUnitNumberEvent);
    on<CompoundSaveAndContinueEvent>(_onCompoundSaveAndContinueEvent);
    on<OnTapStepEvent>(_onOnTapStepEvent);
    on<DocumentsSaveAndContinueEvent>(_onDocumentsSaveAndContinueEvent);
    on<CheckNewUnitEvent>(_onCheckNewUnitEvent);
  }

  FutureOr<void> _onGetUserTypesEvent(
      GetUserTypesEvent event, Emitter<AddUnitState> emit) async {
    emit(GetUserTypesSuccessState(
      userTypes: _userTypes,
    ));
    emit(ShowLoadingState());
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

    emit(HideLoadingState());
  }

  FutureOr<void> _onGetDocumentsPageEvent(
      GetDocumentsPageEvent event, Emitter<AddUnitState> emit) async {
    final DataState<List<pg.Page>> dataState =
        await _getPageFieldsUseCase(event.pageFieldsRequest);
    if (dataState is DataSuccess) {
      _documents = (dataState.data ?? []).first.fields;
      emit(GetDocumentsPageSuccessState(fields: _documents));
    } else {
      emit(GetDocumentsPageErrorState(errorMessage: dataState.message ?? ""));
    }
  }

  FutureOr<void> _onNavigateToSelectCompoundScreenEvent(
      NavigateToSelectCompoundScreenEvent event, Emitter<AddUnitState> emit) {
    emit(NavigateToSelectCompoundScreenState());
  }

  FutureOr<void> _onValidateCompoundNameEvent(
      ValidateCompoundNameEvent event, Emitter<AddUnitState> emit) {
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

  FutureOr<void> _onSelectTypeEvent(
      SelectTypeEvent event, Emitter<AddUnitState> emit) {
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
      OnTapDocumentImageEvent event, Emitter<AddUnitState> emit) {
    emit(OnTapDocumentImageState(document: event.document));
  }

  FutureOr<void> _onOpenCameraEvent(
      OpenCameraEvent event, Emitter<AddUnitState> emit) {
    emit(OpenCameraState(document: event.document));
  }

  FutureOr<void> _onOpenGalleryEvent(
      OpenGalleryEvent event, Emitter<AddUnitState> emit) {
    emit(OpenGalleryState(document: event.document));
  }

  FutureOr<void> _onSelectImageEvent(
      SelectImageEvent event, Emitter<AddUnitState> emit) {
    for (int i = 0; i < _documents.length; i++) {
      if (event.document.id == _documents[i].id) {
        _documents[i] = _documents[i].copyWith(value: event.xFile.path);
        break;
      }
    }

    emit(SelectImageState(documents: _documents));
  }

  FutureOr<void> _onTapDocumentFileEvent(
      OnTapDocumentFileEvent event, Emitter<AddUnitState> emit) {
    emit(OnTapDocumentFileState(document: event.document));
  }

  FutureOr<void> _onSelectFileEvent(
      SelectFileEvent event, Emitter<AddUnitState> emit) {
    PageField? document;
    for (int i = 0; i < _documents.length; i++) {
      if (event.document.id == _documents[i].id) {
        _documents[i] = _documents[i].copyWith(value: event.file);
        document = _documents[i];
        break;
      }
    }

    emit(SelectFileState(document: document!));
  }

  FutureOr<void> _onValidationFileEvent(
      ValidationFileEvent event, Emitter<AddUnitState> emit) async {
    File file = File(event.document.value);
    if (await file.exists()) {
      int fileSizeInBytes = await file.length();
      double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
      if (fileSizeInMB <= 20.0) {
        for (int i = 0; i < _documents.length; i++) {
          if (event.document.id == _documents[i].id) {
            _documents[i] = _documents[i].copyWith(
              value: event.document.value,
              fileValid: true,
            );
          }
        }
        emit(FileValidState(documents: _documents));
      } else {
        for (int i = 0; i < _documents.length; i++) {
          if (event.document.id == _documents[i].id) {
            _documents[i] = _documents[i].copyWith(
              value: "",
              fileValid: false,
            );
          }
        }
        emit(FileNotValidState(documents: _documents));
      }
    } else {
      emit(FieldValidationFileState());
    }
  }

  FutureOr<void> _onDeleteFileEvent(
      DeleteFileEvent event, Emitter<AddUnitState> emit) {
    for (int i = 0; i < _documents.length; i++) {
      if (event.document.id == _documents[i].id) {
        _documents[i] = _documents[i].copyWith(value: "");
        break;
      }
    }
    emit(DeleteFileState(documents: _documents));
  }

  FutureOr<void> _onDeleteImageEvent(
      DeleteImageEvent event, Emitter<AddUnitState> emit) {
    for (int i = 0; i < _documents.length; i++) {
      if (event.document.id == _documents[i].id) {
        _documents[i] = _documents[i].copyWith(value: "");
        break;
      }
    }
    emit(DeleteImageState(documents: _documents));
  }

  FutureOr<void> _onDeleteMultipleImageEvent(
      DeleteMultipleImageEvent event, Emitter<AddUnitState> emit) {
    for (int i = 0; i < _documents.length; i++) {
      if (event.document.id == _documents[i].id) {
        _documents[i].imagesList.removeAt(event.index);
      }
    }
    emit(DeleteMultipleImageState(
        documents: _documents, isMultiImage: true, index: event.index));
  }

  FutureOr<void> _onSelectMultipleImageEvent(
      SelectMultipleImageEvent event, Emitter<AddUnitState> emit) {
    for (int i = 0; i < _documents.length; i++) {
      if (event.document.id == _documents[i].id) {
        _documents[i] = _documents[i].copyWith(
          imagesList: [],
        );

        for (int j = 0; j < event.images.length; j++) {
          _documents[i].imagesList.add(File(event.images[j].path));
          _documents[i] = _documents[i].copyWith(
            errorMessage: "",
          );
        }
      }
    }
    emit(SelectMultipleImageState(
      documents: _documents,
    ));
  }

  FutureOr<void> _onAddMultipleImageEvent(
      AddMultipleImageEvent event, Emitter<AddUnitState> emit) {
    for (int i = 0; i < _documents.length; i++) {
      if (event.document.id == _documents[i].id) {
        _documents[i].imagesList.add(File(event.image.path));
        _documents[i] = _documents[i].copyWith(
          errorMessage: "",
        );
      }
    }
    emit(AddMultipleImageState(documents: _documents));
  }

  FutureOr<void> _onOpenUnitNumberBottomSheetEvent(
      OpenUnitNumberBottomSheetEvent event, Emitter<AddUnitState> emit) {
    if (event.compoundId == -1 || event.compoundId == 0) {
      emit(UnitNumberEmptyFormatState(
        unitNumberValidatorMessage:
            S.current.pleaseSelectCompoundBeforeChoosingTheUnit,
      ));
    } else {
      emit(OpenUnitNumberBottomSheetState());
    }
  }

  FutureOr<void> _onValidateUnitNumberEvent(
      ValidateUnitNumberEvent event, Emitter<AddUnitState> emit) {
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

  FutureOr<void> _onCompoundSaveAndContinueEvent(
      CompoundSaveAndContinueEvent event, Emitter<AddUnitState> emit) {
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

  FutureOr<void> _onOnTapStepEvent(
      OnTapStepEvent event, Emitter<AddUnitState> emit) {
    emit(OnTapStepState(id: event.id));
  }

  FutureOr<void> _onDocumentsSaveAndContinueEvent(
      DocumentsSaveAndContinueEvent event, Emitter<AddUnitState> emit) async {
    bool hasErrorMessage = false;
    for (int i = 0; i < _documents.length; i++) {
      if (_documents[i].isRequired && _documents[i].value.isEmpty) {
        if (_documents[i].code == QuestionsCode.image) {
          _documents[i] = _documents[i]
              .copyWith(errorMessage: S.current.theImageIsRequired);
          emit(DocumentsNotValidState(
            documents: event.documents,
          ));
          hasErrorMessage = true;
        } else if (_documents[i].code == QuestionsCode.file) {
          _documents[i] =
              _documents[i].copyWith(errorMessage: S.current.theFilIsRequired);
          emit(DocumentsNotValidState(
            documents: event.documents,
          ));
          hasErrorMessage = true;
        } else if (_documents[i].code == QuestionsCode.multiImage) {
          if (_documents[i].isRequired && _documents[i].imagesList.isEmpty) {
            _documents[i] = _documents[i]
                .copyWith(errorMessage: S.current.theFilIsRequired);
            emit(DocumentsNotValidState(
              documents: event.documents,
            ));
            hasErrorMessage = true;
          }
        }
      } else {
        _documents[i] = _documents[i].copyWith(errorMessage: "");
      }
    }

    if (!hasErrorMessage) {
      emit(ShowLoadingState());
      final DataState<OTP> dataState = await _registerUseCase(
        event.request,
        event.userId,
      );
      if (dataState is DataSuccess) {
        emit(AddUnitSuccessState(
          message: dataState.message ?? "",
          userUnit: dataState.data?.userUnit ?? UserUnit(),
        ));
      } else {
        emit(RegisterErrorState(
          message: dataState.message ?? "",
        ));
      }

      emit(HideLoadingState());
    }
  }

  FutureOr<void> _onCheckNewUnitEvent(
      CheckNewUnitEvent event, Emitter<AddUnitState> emit) async {
    if (event.userUnit.isCompoundVerified == false ||
        event.userUnit.isActive == false) {
      emit(NewUnitNotActiveState(message: event.userUnit.message));
    } else {
      User user = _getUserInformationUseCase();
      if (user.userInformation.id == -1) {
        emit(NavigateToLoginState(message: event.message));
      } else {
        await _setUserUnitUseCase(event.userUnit);
        for (int i = 0; i < user.userUnits.length; i++) {
          if (user.userUnits[i].unitId == event.userUnit.unitId) {
            user.userUnits[i] = user.userUnits[i].copyWith(isSelected: true);
          } else {
            user.userUnits[i] = user.userUnits[i].copyWith(isSelected: false);
          }
        }
        await _saveUserInformationUseCase(user);
        emit(NewUnitIsActiveState(message: event.message));
      }
    }
  }
}
