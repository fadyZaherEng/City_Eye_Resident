import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/get_mobile_validation_error_message.dart';
import 'package:city_eye/src/core/utils/is_url.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/core/utils/validation/delegated_steps_validator.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/delegated/request/submit_delegated_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/page_code_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/page_fields_request.dart';
import 'package:city_eye/src/domain/entities/delegated/submit_delegation.dart';
import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/usecase/delegated/authorized_widget/authorized_widget_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/authorized_widget/validate_authorized_name_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/owner_widget_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/validate_date_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/validate_id_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/validate_image_selection_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/validate_owner_message_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/submit_delegation_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/validate_signature_use_case.dart';
import 'package:city_eye/src/domain/usecase/dynamic_question_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_page_fields_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_unit_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:city_eye/src/domain/entities/settings/page.dart' as pg;
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart';

part 'delegated_steps_event.dart';

part 'delegated_steps_state.dart';

class DelegatedStepsBloc
    extends Bloc<DelegatedStepsEvent, DelegatedStepsState> {
  final OwnerWidgetValidationUseCase _ownerWidgetValidationUseCase;
  final ValidateOwnerMessageUseCase _validateMessageUseCase;
  final ValidateIdUseCase _validateIdUseCase;
  final ValidateDateUseCase _validateDateUseCase;
  final ValidateImageSelectionUseCase _validateImageSelectionUseCase;
  final AuthorizedWidgetValidationUseCase _authorizedWidgetValidationUseCase;
  final ValidateAuthorizedNameUseCase _authorizedNameUseCase;
  final ValidateSignatureUseCase _validateSignatureUseCase;
  final GetPageFieldsUseCase _getPageFieldsUseCase;
  final SubmitDelegationUseCase _submitDelegationUseCase;
  final GetUserUnitUseCase _getUserUnitUseCase;
  final GetUserInformationUseCase _getUserInformationUseCase;
  final DynamicQuestionValidationUseCase _dynamicQuestionValidationUseCase;

  DelegatedStepsBloc(
    this._ownerWidgetValidationUseCase,
    this._validateMessageUseCase,
    this._validateIdUseCase,
    this._validateDateUseCase,
    this._validateImageSelectionUseCase,
    this._authorizedWidgetValidationUseCase,
    this._authorizedNameUseCase,
    this._validateSignatureUseCase,
    this._getPageFieldsUseCase,
    this._submitDelegationUseCase,
    this._getUserUnitUseCase,
    this._getUserInformationUseCase,
    this._dynamicQuestionValidationUseCase,
  ) : super(DelegatedStepsInitial()) {
    on<GetQuestionsEvent>(_onGetQuestionsEvent);
    //************** Owner *******************
    on<DelegatedImagePermissionDeniedEvent>(
        _onDelegatedImagePermissionDeniedEvent);
    on<OwnerGetUserInformationEvent>(_onDelegatedGetUserInformationEvent);
    on<DelegatedPickImageEvent>(_onDelegatedPickImageEvent);
    on<DelegatedDeleteImageEvent>(_onDelegatedDeleteImageEvent);
    on<DelegatedSelectedDateEvent>(_onDelegatedSelectedDateEvent);
    on<DelegatedShowMassageDialogEvent>(_onDelegatedShowMassageDialogEvent);
    on<DelegatedCaptureSignatureEvent>(_onDelegatedCaptureSignatureEvent);
    on<DelegatedOnTapStepEvent>(_onDelegatedOnTapStepEvent);
    on<OnOwnerSaveEvent>(_onDelegatedOnOwnerSaveEvent);
    on<DelegatedValidateMessageEvent>(_onDelegatedValidateTypeNameEvent);
    on<DelegatedValidateIdEvent>(_onDelegatedValidateIdEvent);
    on<DelegatedValidateDateFromEvent>(_onDelegatedValidateDateFromEvent);
    on<DelegatedValidateDateToEvent>(_onDelegatedValidateDateToEvent);
    on<DelegatedValidateSelectImageEvent>(_onDelegatedValidateSelectImageEvent);
    on<SetEditDateEvent>(_onSetEditDateEvent);
    on<ValidateSignatureEvent>(_onValidateSignatureEvent);
    on<ClearSignatureEvent>(_onClearSignatureEvent);
    //************** Authorized *******************
    on<OnAuthorizedSaveEvent>(_onOnAuthorizedSaveEvent);
    on<ValidateAuthNameFormatEvent>(_onValidateAuthNameFormatEvent);
    on<ValidateAuthMobileNumberFormatEvent>(
        _onValidateAuthMobileNumberFormatEvent);
    on<AuthSaveSignatureEvent>(_onAuthSaveSignatureEvent);
    //********************* Preview ******************
    on<PreviewOnTapDoneEvent>(_onPreviewOnTapDoneEvent);
    //******************* Dynamic ***************
    on<MapQuestionToWidgetEvent>(_onMapQuestionToWidgetEvent);
    on<AuthMapQuestionToWidgetEvent>(_onAuthMapQuestionToWidgetEvent);
    on<SelectSingleSelectionAnswerEvent>(_onSelectSingleSelectionAnswerEvent);
    on<AuthSelectSingleSelectionAnswerEvent>(
        _onAuthSelectSingleSelectionAnswerEvent);
    on<SelectMultiSelectionAnswerEvent>(_onSelectMultiSelectionAnswerEvent);
    on<AuthSelectMultiSelectionAnswerEvent>(
        _onAuthSelectMultiSelectionAnswerEvent);
    on<AddAnswerToQuestionEvent>(_onAddAnswerToQuestionEvent);
    on<AuthAddAnswerToQuestionEvent>(_onAuthAddAnswerToQuestionEvent);
    on<DeleteQuestionAnswerEvent>(_onDeleteQuestionAnswerEvent);
    on<AuthDeleteQuestionAnswerEvent>(_onAuthDeleteQuestionAnswerEvent);
    on<ShowMediaBottomSheetEvent>(_onShowMediaBottomSheetEvent);
    on<AuthShowMediaBottomSheetEvent>(_onAuthShowMediaBottomSheetEvent);
    on<ShowDialogToDeleteQuestionAnswerEvent>(
        _onShowDialogToDeleteQuestionAnswerEvent);
    on<AuthShowDialogToDeleteQuestionAnswerEvent>(
        _onAuthShowDialogToDeleteQuestionAnswerEvent);
    on<SelectDynamicImageEvent>(_onSelectDynamicImageEvent);
    on<AuthSelectDynamicImageEvent>(_onAuthSelectDynamicImageEvent);
    on<ScrollToUnAnsweredMandatoryQuestionEvent>(
        _onScrollToUnAnsweredMandatoryQuestionEvent);
    on<AuthScrollToUnAnsweredMandatoryQuestionEvent>(
        _onAuthScrollToUnAnsweredMandatoryQuestionEvent);
    on<SubmitDelegationEvent>(_onSubmitDelegationEvent);
    on<ShowQrSearchableBottomSheetEvent>(_onShowQrSearchableBottomSheetEvent);
    on<OwnerUpdateSearchableSingleQuestionEvent>(
        _onOwnerUpdateSearchableSingleQuestionEvent);
    on<OwnerUpdateSearchableMultiQuestionEvent>(
        _onOwnerUpdateSearchableMultiQuestionEvent);
    on<AuthUpdateSearchableSingleQuestionEvent>(
        _onAuthUpdateSearchableSingleQuestionEvent);
    on<AuthUpdateSearchableMultiQuestionEvent>(
        _onAuthUpdateSearchableMultiQuestionEvent);
  }

  FutureOr<void> _onGetQuestionsEvent(
      GetQuestionsEvent event, Emitter<DelegatedStepsState> emit) async {
    emit(ShowStepsSkeletonState());

    PageFieldsRequest pageFieldsRequest = PageFieldsRequest(
        userTypeId: 0,
        compoundId: _getUserUnitUseCase().compoundId,
        generalExtrafield: [
          const PageCodeRequest(pageCode: "ownerDelegation"),
          const PageCodeRequest(pageCode: "authDelegation"),
        ]);

    final DataState<List<pg.Page>> dataState =
        await _getPageFieldsUseCase(pageFieldsRequest);
    if (dataState is DataSuccess) {
      var result = dataState.data as List<pg.Page>;
      for (int i = 0; i < result.length; i++) {
        if (result[i].code == "ownerDelegation") {
          ownerQuestions = result[i].fields;
        } else if (result[i].code == "authDelegation") {
          authQuestions = result[i].fields;
        }
      }
      emit(GetQuestionsSuccessState(
        ownerQuestions: ownerQuestions,
        authQuestions: authQuestions,
      ));
    } else {
      emit(GetQuestionsErrorState(errorMessage: dataState.message ?? ""));
    }
    add(MapQuestionToWidgetEvent());
    emit(HideStepsLoadingState());
  }

//************** Owner *******************
  FutureOr<void> _onDelegatedGetUserInformationEvent(
      OwnerGetUserInformationEvent event, Emitter<DelegatedStepsState> emit) {
    String unitId = _getUserUnitUseCase().unitName.toString();
    emit(OwnerGetUserInformationState(_getUserInformationUseCase(), unitId));
  }

  FutureOr<void> _onDelegatedImagePermissionDeniedEvent(
      DelegatedImagePermissionDeniedEvent event,
      Emitter<DelegatedStepsState> emit) {
    emit(DelegatedImagePermissionDeniedState());
  }

  FutureOr<void> _onDelegatedPickImageEvent(
      DelegatedPickImageEvent event, Emitter<DelegatedStepsState> emit) {
    emit(DelegatedPickImageState(event.imageFile));
  }

  FutureOr<void> _onDelegatedDeleteImageEvent(
      DelegatedDeleteImageEvent event, Emitter<DelegatedStepsState> emit) {
    emit(DelegatedDeleteImageState());
  }

  FutureOr<void> _onDelegatedShowMassageDialogEvent(
      DelegatedShowMassageDialogEvent event,
      Emitter<DelegatedStepsState> emit) {
    emit(DelegatedShowMassageDialogState(event.message, event.icon));
  }

  FutureOr<void> _onDelegatedCaptureSignatureEvent(
      DelegatedCaptureSignatureEvent event, Emitter<DelegatedStepsState> emit) {
    emit(DelegatedCaptureSignatureState());
  }

  FutureOr<void> _onDelegatedOnTapStepEvent(
      DelegatedOnTapStepEvent event, Emitter<DelegatedStepsState> emit) {
    emit(OnTapStepState(id: event.id));
  }

  FutureOr<void> _onDelegatedOnOwnerSaveEvent(
      OnOwnerSaveEvent event, Emitter<DelegatedStepsState> emit) {
    var validationsState =
        _ownerWidgetValidationUseCase.validateOwnerWidgetFormUseCase(
            message: event.message,
            id: event.id,
            dateFrom: event.dateFrom,
            dateTo: event.dateTo,
            imagePath: event.imagePath,
            signature: event.signature,
            questions: event.questions);

    for (var i = 0; i < event.questions.length; i++) {
      if (event.questions[i].value.isNotEmpty) {
        Map<String, dynamic> validation = _dynamicQuestionValidationUseCase(
          validation: event.questions[i].validations,
          value: event.questions[i].value,
          questionCode: event.questions[i].code,
        );
        if (!validation["isValid"]) {
          event.questions[i] = event.questions[i].copyWith(
            isValid: false,
            validationMessage: validation["validationMessage"],
          );
          validationsState.add(DelegatedStepsValidationState.invalidQuestions);
        } else {
          event.questions[i] =
              event.questions[i].copyWith(isValid: true, validationMessage: "");
        }
      } else {
        event.questions[i] = event.questions[i].copyWith(
          isValid: true,
        );
      }
    }

    if (validationsState.isNotEmpty) {
      for (var element in validationsState) {
        if (element == DelegatedStepsValidationState.messageEmpty) {
          emit(ValidateMessageEmptyFormatState(
            messageValidatorMessage: S.current.thisFieldIsRequired,
          ));
        } else if (element == DelegatedStepsValidationState.idEmpty) {
          emit(ValidateIdEmptyFormatState(
            idValidatorMessage: S.current.thisFieldIsRequired,
          ));
        } else if (element == DelegatedStepsValidationState.dateFromEmpty) {
          emit(ValidateDateFromEmptyFormatState(
            dateFromValidatorMessage: S.current.thisFieldIsRequired,
          ));
        } else if (element == DelegatedStepsValidationState.dateToEmpty) {
          emit(ValidateDateToEmptyFormatState(
            dateToValidatorMessage:
                S.current.pleaseSelectAnEndDateThatIsLaterThanThe,
          ));
        } else if (element == DelegatedStepsValidationState.imageEmpty) {
          emit(ValidateSelectImageEmptyState(
            imageValidatorMessage: S.current.thisImageRequired,
          ));
        } else if (element == DelegatedStepsValidationState.signatureEmpty) {
          emit(ValidateSignatureEmptyState(
            signatureErrorMessage: S.current.signatureRequired,
          ));
        } else if (element == DelegatedStepsValidationState.invalidQuestions) {
          add(MapQuestionToWidgetEvent());
          add(ScrollToUnAnsweredMandatoryQuestionEvent());
        }
      }
    } else {
      emit(OnOwnerSaveState(
          message: event.message,
          id: event.id,
          dateFrom: event.dateFrom,
          dateTo: event.dateTo));
    }
  }

  FutureOr<void> _onDelegatedSelectedDateEvent(
      DelegatedSelectedDateEvent event, Emitter<DelegatedStepsState> emit) {
    emit(DelegatedSelectedDateState(event.date, event.isFrom));
  }

  FutureOr<void> _onDelegatedValidateTypeNameEvent(
      DelegatedValidateMessageEvent event, Emitter<DelegatedStepsState> emit) {
    DelegatedStepsValidationState validationState =
        _validateMessageUseCase.validateMessage(
      event.message,
    );

    if (validationState == DelegatedStepsValidationState.valid) {
      emit(ValidateMessageValidFormatState());
    } else {
      emit(ValidateMessageEmptyFormatState(
        messageValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onDelegatedValidateIdEvent(
      DelegatedValidateIdEvent event, Emitter<DelegatedStepsState> emit) {
    DelegatedStepsValidationState validationState =
        _validateIdUseCase.validateId(
      event.id,
    );

    if (validationState == DelegatedStepsValidationState.valid) {
      emit(ValidateIdValidFormatState());
    } else {
      emit(ValidateIdEmptyFormatState(
        idValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onDelegatedValidateDateFromEvent(
      DelegatedValidateDateFromEvent event, Emitter<DelegatedStepsState> emit) {
    DelegatedStepsValidationState validationState =
        _validateDateUseCase.validateDate(
      event.dateFrom,
    );

    if (validationState == DelegatedStepsValidationState.valid) {
      emit(ValidateDateFromValidFormatState());
    } else {
      emit(ValidateDateFromEmptyFormatState(
        dateFromValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onDelegatedValidateDateToEvent(
      DelegatedValidateDateToEvent event, Emitter<DelegatedStepsState> emit) {
    DelegatedStepsValidationState validationState =
        _validateDateUseCase.validateDate(
      event.dateTo,
    );

    if (validationState == DelegatedStepsValidationState.valid) {
      emit(ValidateDateToValidFormatState());
    } else {
      emit(ValidateDateToEmptyFormatState(
        dateToValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onDelegatedValidateSelectImageEvent(
      DelegatedValidateSelectImageEvent event,
      Emitter<DelegatedStepsState> emit) {
    DelegatedStepsValidationState validationState =
        _validateImageSelectionUseCase.validateImageSelected(
      event.imagePath,
    );

    if (validationState == DelegatedStepsValidationState.valid) {
      emit(ValidateSelectImageValidState());
    } else {
      emit(ValidateSelectImageEmptyState(
          imageValidatorMessage: S.current.thisImageRequired));
    }
  }

  FutureOr<void> _onValidateSignatureEvent(
      ValidateSignatureEvent event, Emitter<DelegatedStepsState> emit) {
    DelegatedStepsValidationState validationState =
        _validateSignatureUseCase.validateSignatureCaptured(
      event.bytes == null ? "" : event.bytes.toString(),
    );

    if (validationState == DelegatedStepsValidationState.valid) {
      emit(ValidateSignatureValidState(event.bytes));
    } else {
      emit(ValidateSignatureEmptyState(
          signatureErrorMessage: S.current.signatureRequired));
    }
  }

  FutureOr<void> _onSetEditDateEvent(
      SetEditDateEvent event, Emitter<DelegatedStepsState> emit) {
    emit(SetEditDateState());
  }

  FutureOr<void> _onAuthSaveSignatureEvent(
      AuthSaveSignatureEvent event, Emitter<DelegatedStepsState> emit) {
    emit(AuthSaveSignatureState(event.bytes));
  }

  FutureOr<void> _onClearSignatureEvent(
      ClearSignatureEvent event, Emitter<DelegatedStepsState> emit) {
    emit(ClearSignatureState());
  }

  //************** Authorized *******************

  FutureOr<void> _onOnAuthorizedSaveEvent(
      OnAuthorizedSaveEvent event, Emitter<DelegatedStepsState> emit) async {
    final validationsState =
        _authorizedWidgetValidationUseCase.validateAuthorizedWidgetFormUseCase(
      name: event.name,
      id: event.id,
      mobileNumber: event.mobileNo,
      imagePath: event.imagePath,
      questions: event.questions,
    );

    for (var i = 0; i < event.questions.length; i++) {
      if (event.questions[i].value.isNotEmpty) {
        Map<String, dynamic> validation = _dynamicQuestionValidationUseCase(
          validation: event.questions[i].validations,
          value: event.questions[i].value,
          questionCode: event.questions[i].code,
        );
        if (!validation["isValid"]) {
          event.questions[i] = event.questions[i].copyWith(
            isValid: false,
            validationMessage: validation["validationMessage"],
          );
          validationsState.add(DelegatedStepsValidationState.invalidQuestions);
        } else {
          event.questions[i] =
              event.questions[i].copyWith(isValid: true, validationMessage: "");
        }
      } else {
        event.questions[i] = event.questions[i].copyWith(
          isValid: true,
        );
      }
    }

    if (validationsState.isNotEmpty) {
      for (var element in validationsState) {
        if (element == DelegatedStepsValidationState.nameEmpty) {
          emit(ValidateAuthNameEmptyFormatState(
            nameValidatorMessage: S.current.thisFieldIsRequired,
          ));
        } else if (element == DelegatedStepsValidationState.nameInvalid) {
          emit(ValidateAuthNameEmptyFormatState(
            nameValidatorMessage:
                S.current.enterTwoWordsEachWordContains2Characters,
          ));
        } else if (element == DelegatedStepsValidationState.idEmpty) {
          emit(ValidateIdEmptyFormatState(
            idValidatorMessage: S.current.thisFieldIsRequired,
          ));
        } else if (element == DelegatedStepsValidationState.mobileNumberEmpty) {
          emit(ValidateAuthMobileNumberEmptyFormatState(
            mobileValidatorMessage: S.current.mobileNumberCantBeEmpty,
          ));
        } else if (element == DelegatedStepsValidationState.imageEmpty) {
          emit(ValidateSelectImageEmptyState(
            imageValidatorMessage: S.current.thisImageRequired,
          ));
        } else if (element == DelegatedStepsValidationState.invalidQuestions) {
          add(AuthMapQuestionToWidgetEvent());
          add(AuthScrollToUnAnsweredMandatoryQuestionEvent());
        }
      }
    } else if (await PhoneNumberUtil.getNumberType(
            event.mobileNo, event.countryCode) !=
        PhoneNumberType.MOBILE) {
      emit(ValidateAuthMobileNumberEmptyFormatState(
        mobileValidatorMessage: getMobileValidationErrorMessage(
          mobileNumber: event.mobileNo,
          regionCode: event.countryCode,
        ),
      ));
    } else {
      emit(AuthIsValidateState());
    }
  }

  FutureOr<void> _onSubmitDelegationEvent(
      SubmitDelegationEvent event, Emitter<DelegatedStepsState> emit) async {
    emit(ShowStepsLoadingState());
    DataState dataState = await _submitDelegationUseCase(
      ownerIDPath: event.ownerIdPath,
      authIDPath: event.authIdPath,
      ownerSignaturePath: event.ownerSignaturePath,
      authSignaturePath: event.authSignaturePath,
      submitDelegatedRequest: event.submitDelegatedRequest,
    );

    if (dataState is DataSuccess) {
      emit(OnAuthorizedSaveSuccessState(
        submitDelegation: dataState.data as SubmitDelegation,
      ));
    } else {
      emit(OnAuthorizedSaveErrorState(errorMessage: dataState.message ?? ""));
    }
    emit(HideStepsLoadingState());
  }

  FutureOr<void> _onValidateAuthNameFormatEvent(
      ValidateAuthNameFormatEvent event, Emitter<DelegatedStepsState> emit) {
    DelegatedStepsValidationState validationState =
        _authorizedNameUseCase.validateName(event.name);

    if (validationState == DelegatedStepsValidationState.valid) {
      emit(ValidateAuthNameValidFormatState());
    } else if (validationState == DelegatedStepsValidationState.nameEmpty) {
      emit(ValidateAuthNameEmptyFormatState(
        nameValidatorMessage: S.current.thisFieldIsRequired,
      ));
    } else if (validationState == DelegatedStepsValidationState.nameInvalid) {
      emit(ValidateAuthNameEmptyFormatState(
        nameValidatorMessage:
            S.current.enterTwoWordsEachWordContains2Characters,
      ));
    }
  }

  FutureOr<void> _onValidateAuthMobileNumberFormatEvent(
      ValidateAuthMobileNumberFormatEvent event,
      Emitter<DelegatedStepsState> emit) async {
    try {
      if (await PhoneNumberUtil.getNumberType(event.mobileNo, event.code) ==
          PhoneNumberType.MOBILE) {
        emit(ValidateAuthMobileNumberValidFormatState());
      } else {
        emit(ValidateAuthMobileNumberEmptyFormatState(
          mobileValidatorMessage: getMobileValidationErrorMessage(
            mobileNumber: event.mobileNo,
            regionCode: event.code,
          ),
        ));
      }
    } catch (e) {
      emit(ValidateAuthMobileNumberEmptyFormatState(
        mobileValidatorMessage: getMobileValidationErrorMessage(
          mobileNumber: event.mobileNo,
          regionCode: event.code,
        ),
      ));
    }
  }

  FutureOr<void> _onPreviewOnTapDoneEvent(
      PreviewOnTapDoneEvent event, Emitter<DelegatedStepsState> emit) {
    emit(PreviewOnTapDoneState());
  }

  //**************** Dynamic ****************
  bool isLoaded = false;
  List<PageField> ownerQuestions = [];
  List<PageField> authQuestions = [];

  FutureOr<void> _onMapQuestionToWidgetEvent(
      MapQuestionToWidgetEvent event, Emitter<DelegatedStepsState> emit) {
    for (var i = 0; i < ownerQuestions.length; i++) {
      GlobalKey key = GlobalKey();
      ownerQuestions[i] = ownerQuestions[i].copyWith(
        key: key,
      );
    }
    for (int i = 0; i < ownerQuestions.length; i++) {
      if (ownerQuestions[i].code == QuestionsCode.singleChoice ||
          ownerQuestions[i].code == QuestionsCode.multiChoice ||
          ownerQuestions[i].code == QuestionsCode.searchableMulti ||
          ownerQuestions[i].code == QuestionsCode.searchableSingle) {
        if (ownerQuestions[i].value.isNotEmpty) {
          List<int> choices = ownerQuestions[i]
              .value
              .split(",")
              .map((e) => int.parse(e))
              .toList();
          for (int j = 0; j < ownerQuestions[i].choices.length; j++) {
            for (int k = 0; k < choices.length; k++) {
              if (ownerQuestions[i].choices[j].id == choices[k]) {
                ownerQuestions[i].choices[j] =
                    ownerQuestions[i].choices[j].copyWith(
                          isSelected: true,
                        );
              }
            }
          }
        }
      } else if (ownerQuestions[i].code == QuestionsCode.image) {
        if (isUrl(ownerQuestions[i].value)) {
          ownerQuestions[i] = ownerQuestions[i].copyWith(
            isFromServer: true,
          );
        }
      }
    }
    /*for (var i = 0; i < ownerQuestions.length; i++) {
        if (ownerQuestions[i].code == QuestionsCode.searchableMulti ||
            ownerQuestions[i].code == QuestionsCode.searchableSingle) {
          for (var j = 0; j < ownerQuestions[i].choices.length; j++) {
            if (ownerQuestions[i]
                .value
                .contains(ownerQuestions[i].choices[j].id.toString())) {
              ownerQuestions[i].choices[j] = ownerQuestions[i].choices[j].copyWith(
                    isSelected: true,
                  );
            }
          }
        }
      }
      for (var i = 0; i < authQuestions.length; i++) {
        if (authQuestions[i].code == QuestionsCode.searchableMulti ||
            authQuestions[i].code == QuestionsCode.searchableSingle) {
          for (var j = 0; j < authQuestions[i].choices.length; j++) {
            if (authQuestions[i]
                .value
                .contains(authQuestions[i].choices[j].id.toString())) {
              authQuestions[i].choices[j] = authQuestions[i].choices[j].copyWith(
                isSelected: true,
              );
            }
          }
        }
      }*/
    isLoaded = true;
    emit(MapQuestionToWidgetState(questions: ownerQuestions));
  }

  FutureOr<void> _onAuthMapQuestionToWidgetEvent(
      AuthMapQuestionToWidgetEvent event, Emitter<DelegatedStepsState> emit) {
    for (var i = 0; i < authQuestions.length; i++) {
      GlobalKey key = GlobalKey();
      authQuestions[i] = authQuestions[i].copyWith(
        key: key,
      );
    }
    for (int i = 0; i < authQuestions.length; i++) {
      if (authQuestions[i].code == QuestionsCode.singleChoice ||
          authQuestions[i].code == QuestionsCode.multiChoice ||
          authQuestions[i].code == QuestionsCode.searchableMulti ||
          authQuestions[i].code == QuestionsCode.searchableSingle) {
        if (authQuestions[i].value.isNotEmpty) {
          List<int> choices = authQuestions[i]
              .value
              .split(",")
              .map((e) => int.parse(e))
              .toList();
          for (int j = 0; j < authQuestions[i].choices.length; j++) {
            for (int k = 0; k < choices.length; k++) {
              if (authQuestions[i].choices[j].id == choices[k]) {
                authQuestions[i].choices[j] =
                    authQuestions[i].choices[j].copyWith(
                          isSelected: true,
                        );
              }
            }
          }
        }
      } else if (authQuestions[i].code == QuestionsCode.image) {
        if (isUrl(authQuestions[i].value)) {
          authQuestions[i] = authQuestions[i].copyWith(
            isFromServer: true,
          );
        }
      }
    }
    isLoaded = true;
    emit(AuthMapQuestionToWidgetState(questions: authQuestions));
  }

  FutureOr<void> _onSelectSingleSelectionAnswerEvent(
      SelectSingleSelectionAnswerEvent event,
      Emitter<DelegatedStepsState> emit) {
    for (var i = 0; i < ownerQuestions.length; i++) {
      if (ownerQuestions[i].id == event.question.id) {
        for (var j = 0; j < ownerQuestions[i].choices.length; j++) {
          if (ownerQuestions[i].choices[j].id == event.answerId) {
            ownerQuestions[i].choices[j].isSelected =
                !ownerQuestions[i].choices[j].isSelected;
            ownerQuestions[i] = ownerQuestions[i].copyWith(
              notAnswered: false,
              value: ownerQuestions[i].choices[j].id.toString(),
            );
          } else {
            ownerQuestions[i].choices[j].isSelected = false;
          }
        }
      }
    }
    emit(UpdateMapQuestionToWidgetState(questions: ownerQuestions));
  }

  FutureOr<void> _onAuthSelectSingleSelectionAnswerEvent(
      AuthSelectSingleSelectionAnswerEvent event,
      Emitter<DelegatedStepsState> emit) {
    for (var i = 0; i < authQuestions.length; i++) {
      if (authQuestions[i].id == event.question.id) {
        for (var j = 0; j < authQuestions[i].choices.length; j++) {
          if (authQuestions[i].choices[j].id == event.answerId) {
            authQuestions[i].choices[j].isSelected =
                !authQuestions[i].choices[j].isSelected;
            authQuestions[i] = authQuestions[i].copyWith(
              notAnswered: false,
              value: authQuestions[i].choices[j].id.toString(),
            );
          } else {
            authQuestions[i].choices[j].isSelected = false;
          }
        }
      }
    }
    emit(UpdateAuthMapQuestionToWidgetState(questions: authQuestions));
  }

  FutureOr<void> _onSelectMultiSelectionAnswerEvent(
      SelectMultiSelectionAnswerEvent event,
      Emitter<DelegatedStepsState> emit) {
    for (var i = 0; i < ownerQuestions.length; i++) {
      if (ownerQuestions[i].id == event.question.id) {
        bool isAnswered = false;
        for (var j = 0; j < ownerQuestions[i].choices.length; j++) {
          if (ownerQuestions[i].choices[j].id == event.answerId) {
            if (ownerQuestions[i].value.contains(event.answerId.toString())) {
              ownerQuestions[i].choices[j].isSelected = false;
              ownerQuestions[i] = ownerQuestions[i].copyWith(
                value: ownerQuestions[i].value.replaceAll(
                      ownerQuestions[i].choices[j].id.toString(),
                      '',
                    ),
              );
              try {
                ownerQuestions[i] = ownerQuestions[i].copyWith(
                  value: ownerQuestions[i].value.replaceAll(
                        ",,",
                        ',',
                      ),
                );
                if (ownerQuestions[i].value.startsWith(",")) {
                  ownerQuestions[i] = ownerQuestions[i].copyWith(
                    value: ownerQuestions[i].value.substring(1),
                  );
                }
                if (ownerQuestions[i].value.endsWith(",")) {
                  ownerQuestions[i] = ownerQuestions[i].copyWith(
                    value: ownerQuestions[i]
                        .value
                        .substring(0, ownerQuestions[i].value.length - 1),
                  );
                }
              } catch (_) {}
            } else {
              ownerQuestions[i] = ownerQuestions[i].copyWith(
                notAnswered: false,
              );
              ownerQuestions[i].choices[j].isSelected = true;
              if (ownerQuestions[i].value == "") {
                ownerQuestions[i] = ownerQuestions[i].copyWith(
                  value: ownerQuestions[i].choices[j].id.toString(),
                );
              } else {
                ownerQuestions[i] = ownerQuestions[i].copyWith(
                  value:
                      "${ownerQuestions[i].value},${ownerQuestions[i].choices[j].id}",
                );
              }
              isAnswered = true;
            }
          }
        }
        if (isAnswered) {
          ownerQuestions[i] = ownerQuestions[i].copyWith(
            notAnswered: false,
          );
        } else if (!isAnswered && ownerQuestions[i].isRequired) {
          ownerQuestions[i] = ownerQuestions[i].copyWith(
            notAnswered: true,
          );
        }
      }
    }

    emit(UpdateMapQuestionToWidgetState(questions: ownerQuestions));
  }

  FutureOr<void> _onAuthSelectMultiSelectionAnswerEvent(
      AuthSelectMultiSelectionAnswerEvent event,
      Emitter<DelegatedStepsState> emit) {
    for (var i = 0; i < authQuestions.length; i++) {
      if (authQuestions[i].id == event.question.id) {
        bool isAnswered = false;
        for (var j = 0; j < authQuestions[i].choices.length; j++) {
          if (authQuestions[i].choices[j].id == event.answerId) {
            if (authQuestions[i].value.contains(event.answerId.toString())) {
              authQuestions[i].choices[j].isSelected = false;
              authQuestions[i] = authQuestions[i].copyWith(
                value: authQuestions[i].value.replaceAll(
                      authQuestions[i].choices[j].id.toString(),
                      '',
                    ),
              );
              try {
                authQuestions[i] = authQuestions[i].copyWith(
                  value: authQuestions[i].value.replaceAll(
                        ",,",
                        ',',
                      ),
                );
                if (authQuestions[i].value.startsWith(",")) {
                  authQuestions[i] = authQuestions[i].copyWith(
                    value: authQuestions[i].value.substring(1),
                  );
                }
                if (authQuestions[i].value.endsWith(",")) {
                  authQuestions[i] = authQuestions[i].copyWith(
                    value: authQuestions[i]
                        .value
                        .substring(0, authQuestions[i].value.length - 1),
                  );
                }
              } catch (_) {}
            } else {
              authQuestions[i] = authQuestions[i].copyWith(
                notAnswered: false,
              );
              authQuestions[i].choices[j].isSelected = true;
              if (authQuestions[i].value == "") {
                authQuestions[i] = authQuestions[i].copyWith(
                  value: authQuestions[i].choices[j].id.toString(),
                );
              } else {
                authQuestions[i] = authQuestions[i].copyWith(
                  value:
                      "${authQuestions[i].value},${authQuestions[i].choices[j].id}",
                );
              }
              isAnswered = true;
            }
          }
        }
        if (isAnswered) {
          authQuestions[i] = authQuestions[i].copyWith(
            notAnswered: false,
          );
        } else if (!isAnswered && authQuestions[i].isRequired) {
          authQuestions[i] = authQuestions[i].copyWith(
            notAnswered: true,
          );
        }
      }
    }

    emit(UpdateAuthMapQuestionToWidgetState(questions: authQuestions));
  }

  FutureOr<void> _onAddAnswerToQuestionEvent(
      AddAnswerToQuestionEvent event, Emitter<DelegatedStepsState> emit) {
    for (var i = 0; i < ownerQuestions.length; i++) {
      if (ownerQuestions[i].id == event.question.id) {
        ownerQuestions[i] = ownerQuestions[i].copyWith(
          value: event.answer,
          notAnswered: false,
        );
      }
      if (ownerQuestions[i].value.isNotEmpty) {
        Map<String, dynamic> validation = _dynamicQuestionValidationUseCase(
          validation: ownerQuestions[i].validations,
          value: ownerQuestions[i].value,
          questionCode: ownerQuestions[i].code,
        );

        if (!validation["isValid"]) {
          ownerQuestions[i] = ownerQuestions[i].copyWith(
            isValid: false,
            validationMessage: validation["validationMessage"],
          );
        } else {
          ownerQuestions[i] = ownerQuestions[i].copyWith(
            isValid: true,
            validationMessage: "",
          );
        }
      } else {
        ownerQuestions[i] = ownerQuestions[i].copyWith(
          isValid: true,
        );
      }
    }
    emit(UpdateMapQuestionToWidgetState(questions: ownerQuestions));
  }

  FutureOr<void> _onAuthAddAnswerToQuestionEvent(
      AuthAddAnswerToQuestionEvent event, Emitter<DelegatedStepsState> emit) {
    for (var i = 0; i < authQuestions.length; i++) {
      if (authQuestions[i].id == event.question.id) {
        authQuestions[i] = authQuestions[i].copyWith(
          value: event.answer,
          notAnswered: false,
        );
      }

      if (authQuestions[i].value.isNotEmpty) {
        Map<String, dynamic> validation = _dynamicQuestionValidationUseCase(
          validation: authQuestions[i].validations,
          value: authQuestions[i].value,
          questionCode: authQuestions[i].code,
        );

        if (!validation["isValid"]) {
          authQuestions[i] = authQuestions[i].copyWith(
            isValid: false,
            validationMessage: validation["validationMessage"],
          );
        } else {
          authQuestions[i] = authQuestions[i].copyWith(
            isValid: true,
            validationMessage: "",
          );
        }
      } else {
        authQuestions[i] = authQuestions[i].copyWith(
          isValid: true,
        );
      }
    }
    emit(UpdateAuthMapQuestionToWidgetState(questions: authQuestions));
  }

  FutureOr<void> _onDeleteQuestionAnswerEvent(
      DeleteQuestionAnswerEvent event, Emitter<DelegatedStepsState> emit) {
    for (var i = 0; i < ownerQuestions.length; i++) {
      if (ownerQuestions[i].id == event.question.id) {
        ownerQuestions[i] = ownerQuestions[i].copyWith(
          value: '',
          notAnswered: true,
        );
      }
    }
    emit(UpdateMapQuestionToWidgetState(questions: ownerQuestions));
  }

  FutureOr<void> _onAuthDeleteQuestionAnswerEvent(
      AuthDeleteQuestionAnswerEvent event, Emitter<DelegatedStepsState> emit) {
    for (var i = 0; i < authQuestions.length; i++) {
      if (authQuestions[i].id == event.question.id) {
        authQuestions[i] = authQuestions[i].copyWith(
          value: "",
          notAnswered: true,
        );
      }
    }
    emit(UpdateAuthMapQuestionToWidgetState(questions: authQuestions));
  }

  FutureOr<void> _onShowMediaBottomSheetEvent(
      ShowMediaBottomSheetEvent event, Emitter<DelegatedStepsState> emit) {
    emit(ShowMediaBottomSheetState(question: event.question));
  }

  FutureOr<void> _onAuthShowMediaBottomSheetEvent(
      AuthShowMediaBottomSheetEvent event, Emitter<DelegatedStepsState> emit) {
    emit(ShowMediaBottomSheetState(question: event.question));
  }

  FutureOr<void> _onShowDialogToDeleteQuestionAnswerEvent(
      ShowDialogToDeleteQuestionAnswerEvent event,
      Emitter<DelegatedStepsState> emit) {
    emit(ShowDialogToDeleteQuestionAnswerState(question: event.question));
  }

  FutureOr<void> _onAuthShowDialogToDeleteQuestionAnswerEvent(
      AuthShowDialogToDeleteQuestionAnswerEvent event,
      Emitter<DelegatedStepsState> emit) {
    emit(ShowDialogToDeleteQuestionAnswerState(question: event.question));
  }

  FutureOr<void> _onSelectDynamicImageEvent(
      SelectDynamicImageEvent event, Emitter<DelegatedStepsState> emit) {
    for (var i = 0; i < ownerQuestions.length; i++) {
      if (ownerQuestions[i].id == event.question.id) {
        ownerQuestions[i] = ownerQuestions[i].copyWith(
          value: event.xFile.path,
          notAnswered: false,
          isFromServer: false,
        );
      }
    }
    emit(UpdateMapQuestionToWidgetState(questions: ownerQuestions));
  }

  FutureOr<void> _onAuthSelectDynamicImageEvent(
      AuthSelectDynamicImageEvent event, Emitter<DelegatedStepsState> emit) {
    for (var i = 0; i < authQuestions.length; i++) {
      if (authQuestions[i].id == event.question.id) {
        authQuestions[i] = authQuestions[i].copyWith(
          value: event.xFile.path,
          notAnswered: false,
          isFromServer: false,
        );
      }
    }
    emit(UpdateAuthMapQuestionToWidgetState(questions: authQuestions));
  }

  FutureOr<void> _onScrollToUnAnsweredMandatoryQuestionEvent(
      ScrollToUnAnsweredMandatoryQuestionEvent event,
      Emitter<DelegatedStepsState> emit) {
    for (int i = 0; i < ownerQuestions.length; i++) {
      if (ownerQuestions[i].isRequired && ownerQuestions[i].notAnswered) {
        emit(ScrollToUnAnsweredMandatoryQuestionState(
            key: ownerQuestions[i].key ?? GlobalKey()));
        break;
      }
    }
  }

  FutureOr<void> _onAuthScrollToUnAnsweredMandatoryQuestionEvent(
      AuthScrollToUnAnsweredMandatoryQuestionEvent event,
      Emitter<DelegatedStepsState> emit) {
    for (int i = 0; i < authQuestions.length; i++) {
      if (authQuestions[i].isRequired && authQuestions[i].notAnswered) {
        emit(ScrollToUnAnsweredMandatoryQuestionState(
            key: authQuestions[i].key ?? GlobalKey()));
        break;
      }
    }
  }

  FutureOr<void> _onShowQrSearchableBottomSheetEvent(
      ShowQrSearchableBottomSheetEvent event,
      Emitter<DelegatedStepsState> emit) {
    emit(ShowQrSearchableBottomSheetState(
        question: event.question, isMultiChoice: event.isMultiChoice));
  }

  void _onOwnerUpdateSearchableSingleQuestionEvent(
      OwnerUpdateSearchableSingleQuestionEvent event,
      Emitter<DelegatedStepsState> emit) {
    for (var i = 0; i < ownerQuestions.length; i++) {
      if (ownerQuestions[i].id == event.question.id) {
        ownerQuestions[i] = ownerQuestions[i].copyWith(
          value: event.answer.id.toString(),
          notAnswered: false,
        );
        for (var j = 0; j < ownerQuestions[i].choices.length; j++) {
          if (ownerQuestions[i].choices[j].id == event.answer.id) {
            ownerQuestions[i].choices[j] =
                ownerQuestions[i].choices[j].copyWith(
                      isSelected: true,
                    );
            ownerQuestions[i] = ownerQuestions[i].copyWith(notAnswered: false);
          } else {
            ownerQuestions[i].choices[j] =
                ownerQuestions[i].choices[j].copyWith(
                      isSelected: false,
                    );
          }
        }

        if (ownerQuestions[i].value.isNotEmpty) {
          ownerQuestions[i] = ownerQuestions[i].copyWith(
            notAnswered: false,
          );
        } else {
          ownerQuestions[i] =
              ownerQuestions[i].copyWith(value: "", notAnswered: false);
        }
      }
    }
    emit(UpdateMapQuestionToWidgetState(questions: ownerQuestions));
  }

  FutureOr<void> _onOwnerUpdateSearchableMultiQuestionEvent(
      OwnerUpdateSearchableMultiQuestionEvent event,
      Emitter<DelegatedStepsState> emit) {
    bool isAnswered = false;
    for (var i = 0; i < ownerQuestions.length; i++) {
      if (ownerQuestions[i].id == event.question.id) {
        ownerQuestions[i] = ownerQuestions[i].copyWith(
          value: "",
        );
        for (var j = 0; j < ownerQuestions[i].choices.length; j++) {
          ownerQuestions[i].choices[j] = ownerQuestions[i].choices[j].copyWith(
                isSelected: false,
              );
        }
        for (var j = 0; j < ownerQuestions[i].choices.length; j++) {
          for (var k = 0; k < event.answer.length; k++) {
            if (ownerQuestions[i].choices[j].id == event.answer[k].id) {
              ownerQuestions[i].choices[j] =
                  ownerQuestions[i].choices[j].copyWith(
                        isSelected: true,
                      );
              ownerQuestions[i] = ownerQuestions[i].copyWith(
                value: ownerQuestions[i].value == ""
                    ? ownerQuestions[i].choices[j].id.toString()
                    : ownerQuestions[i].value.contains(
                            ownerQuestions[i].choices[j].id.toString())
                        ? ownerQuestions[i].value
                        : "${ownerQuestions[i].value},${ownerQuestions[i].choices[j].id.toString()}",
                notAnswered: false,
              );
              isAnswered = true;
            }
          }
        }
        if (isAnswered) {
          ownerQuestions[i] = ownerQuestions[i].copyWith(
            notAnswered: false,
          );
        } else {
          ownerQuestions[i] = ownerQuestions[i].copyWith(
            notAnswered: true,
          );
        }
      }
    }
    emit(UpdateMapQuestionToWidgetState(questions: ownerQuestions));
  }

  void _onAuthUpdateSearchableSingleQuestionEvent(
      AuthUpdateSearchableSingleQuestionEvent event,
      Emitter<DelegatedStepsState> emit) {
    for (var i = 0; i < authQuestions.length; i++) {
      if (authQuestions[i].id == event.question.id) {
        authQuestions[i] = authQuestions[i].copyWith(
          value: event.answer.id.toString(),
          notAnswered: false,
        );
        for (var j = 0; j < authQuestions[i].choices.length; j++) {
          if (authQuestions[i].choices[j].id == event.answer.id) {
            authQuestions[i].choices[j] = authQuestions[i].choices[j].copyWith(
                  isSelected: true,
                );
            authQuestions[i] = authQuestions[i].copyWith(notAnswered: false);
          } else {
            authQuestions[i].choices[j] = authQuestions[i].choices[j].copyWith(
                  isSelected: false,
                );
          }
        }

        if (authQuestions[i].value.isNotEmpty) {
          authQuestions[i] = authQuestions[i].copyWith(
            notAnswered: false,
          );
        } else {
          authQuestions[i] =
              authQuestions[i].copyWith(value: "", notAnswered: false);
        }
      }
    }
    emit(UpdateAuthMapQuestionToWidgetState(questions: authQuestions));
  }

  FutureOr<void> _onAuthUpdateSearchableMultiQuestionEvent(
      AuthUpdateSearchableMultiQuestionEvent event,
      Emitter<DelegatedStepsState> emit) {
    bool isAnswered = false;
    for (var i = 0; i < authQuestions.length; i++) {
      if (authQuestions[i].id == event.question.id) {
        authQuestions[i] = authQuestions[i].copyWith(
          value: "",
        );
        for (var j = 0; j < authQuestions[i].choices.length; j++) {
          authQuestions[i].choices[j] = authQuestions[i].choices[j].copyWith(
                isSelected: false,
              );
        }
        for (var j = 0; j < authQuestions[i].choices.length; j++) {
          for (var k = 0; k < event.answer.length; k++) {
            if (authQuestions[i].choices[j].id == event.answer[k].id) {
              authQuestions[i].choices[j] =
                  authQuestions[i].choices[j].copyWith(
                        isSelected: true,
                      );
              authQuestions[i] = authQuestions[i].copyWith(
                value: authQuestions[i].value == ""
                    ? authQuestions[i].choices[j].id.toString()
                    : authQuestions[i]
                            .value
                            .contains(authQuestions[i].choices[j].id.toString())
                        ? authQuestions[i].value
                        : "${authQuestions[i].value},${authQuestions[i].choices[j].id.toString()}",
                notAnswered: false,
              );
              isAnswered = true;
            }
          }
        }
        if (isAnswered) {
          authQuestions[i] = authQuestions[i].copyWith(
            notAnswered: false,
          );
        } else {
          authQuestions[i] = authQuestions[i].copyWith(
            notAnswered: true,
          );
        }
      }
    }
    emit(UpdateAuthMapQuestionToWidgetState(questions: authQuestions));
  }
}
