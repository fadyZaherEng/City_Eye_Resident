import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/get_mobile_validation_error_message.dart';
import 'package:city_eye/src/core/utils/validation/family_member_validator.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/add_user_family_member_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/update_user_family_member_request.dart';
import 'package:city_eye/src/domain/entities/profile/family_member.dart';
import 'package:city_eye/src/domain/entities/profile/family_member_invitation.dart';
import 'package:city_eye/src/domain/entities/profile/family_member_type.dart';
import 'package:city_eye/src/domain/entities/profile/invitation.dart';
import 'package:city_eye/src/domain/usecase/add_family_member_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/add_user_family_member_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_family_relation_use_case.dart';
import 'package:city_eye/src/domain/usecase/select_family_relation_use_case.dart';
import 'package:city_eye/src/domain/usecase/update_user_family_member_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart';

part 'add_family_event.dart';

part 'add_family_state.dart';

class AddFamilyBloc extends Bloc<AddFamilyEvent, AddFamilyState> {
  final GetFamilyRelationUseCase _getFamilyRelationUseCase;
  final SelectFamilyRelationUseCase _selectFamilyRelationUseCase;
  final AddFamilyMemberValidationUseCase _addFamilyMemberValidationUseCase;
  final AddUserFamilyMemberUseCase _addUserFamilyMemberUseCase;
  final UpdateUserFamilyMemberUseCase _updateUserFamilyMemberUseCase;

  AddFamilyBloc(
    this._getFamilyRelationUseCase,
    this._selectFamilyRelationUseCase,
    this._addFamilyMemberValidationUseCase,
    this._addUserFamilyMemberUseCase,
    this._updateUserFamilyMemberUseCase,
  ) : super(AddFamilyMemberInitial()) {
    on<InitializeAddFamilyMemberEvent>(_onInitializeAddFamilyMemberEvent);
    on<SelectFamilyRelationEvent>(_onSelectFamilyRelationEvent);
    on<ValidateNameEvent>(_onValidateNameEvent);
    on<ValidateMobileNumberEvent>(_onValidateMobileNumberEvent);
    on<ValidateFamilyMemberFormEvent>(_onValidateFamilyMemberFormEvent);
    on<AddFamilyMemberEvent>(_onAddFamilyMemberEvent);
    on<UpdateFamilyMemberEvent>(_onUpdateFamilyMemberEvent);
    on<NavigateBackEvent>(_onNavigateBackEvent);
    on<ValidateEmailAddressEvent>(_onValidateEmailAddressEvent);
    on<ValidateImageSelectionEvent>(_onValidateImageSelectionEvent);
  }

  FutureOr<void> _onNavigateBackEvent(
      NavigateBackEvent event, Emitter<AddFamilyState> emit) {
    emit(NavigateBackState(
      arguments: event.arguments,
    ));
  }

  FutureOr<void> _onInitializeAddFamilyMemberEvent(
      InitializeAddFamilyMemberEvent event, Emitter<AddFamilyState> emit) {
    emit(InitializeAddFamilyMemberState(
        familyMember: event.familyMember,
        familyMemberTypes: _getFamilyRelationUseCase(
          event.familyMember,
          event.familyMembersTypes,
        )));
  }

  FutureOr<void> _onSelectFamilyRelationEvent(
      SelectFamilyRelationEvent event, Emitter<AddFamilyState> emit) {
    List<FamilyMemberType> familyMemberTypes = _selectFamilyRelationUseCase(
        event.familyMemberTypes, event.selectedFamilyMemberType);
    FamilyMemberValidationState validationState =
        _addFamilyMemberValidationUseCase.validateFamilyMemberType(
      familyMemberTypes,
    );
    if (validationState == FamilyMemberValidationState.valid) {
      emit(FamilyMemberTypeValidState());
    } else {
      emit(FamilyMemberTypeInvalidState(
          errorMessage: S.current.thisFieldIsRequired));
    }
    emit(SelectFamilyRelationState(familyMemberTypes: familyMemberTypes));
  }

  FutureOr<void> _onValidateNameEvent(
      ValidateNameEvent event, Emitter<AddFamilyState> emit) {
    FamilyMemberValidationState validationState =
        _addFamilyMemberValidationUseCase.validateName(
      event.name,
    );
    if (validationState == FamilyMemberValidationState.valid) {
      emit(NameValidState());
    } else if (validationState == FamilyMemberValidationState.invalidName) {
      emit(NameInvalidState(
          errorMessage: S.current.enterTwoWordsEachWordContains2Characters));
    } else {
      emit(NameInvalidState(errorMessage: S.current.thisFieldIsRequired));
    }
  }

  bool? isValidMobileNumber = false;
  var phoneType = PhoneNumberType.UNKNOWN;

  FutureOr<void> _onValidateMobileNumberEvent(
      ValidateMobileNumberEvent event, Emitter<AddFamilyState> emit) async {
    try {
      phoneType = await PhoneNumberUtil.getNumberType(
          event.mobileNumber, event.regionCode);
      isValidMobileNumber = await PhoneNumberUtil.isValidPhoneNumber(
          event.mobileNumber, event.regionCode);

      if (isValidMobileNumber == true && phoneType == PhoneNumberType.MOBILE) {
        emit(MobileNumberValidState(countryCode: event.regionCode));
      } else {
        emit(MobileNumberInvalidState(
          errorMessage: getMobileValidationErrorMessage(
            mobileNumber: event.mobileNumber,
            regionCode: event.regionCode,
          ),
        ));
      }
    } catch (e) {
      emit(MobileNumberInvalidState(
        errorMessage: getMobileValidationErrorMessage(
          mobileNumber: event.mobileNumber,
          regionCode: event.regionCode,
        ),
      ));
    }
  }

  FutureOr<void> _onValidateFamilyMemberFormEvent(
      ValidateFamilyMemberFormEvent event, Emitter<AddFamilyState> emit) {
    final validationsState =
        _addFamilyMemberValidationUseCase.validateAddFamilyMemberFormUseCase(
      name: event.name,
      mobileNumber: event.mobileNumber,
      familyMemberTypes: event.familyMemberTypes,
      emailAddress: event.emailAddress,
      imagePath: event.imagePath,
    );

    bool isScrollable = false;
    if (validationsState.isNotEmpty) {
      for (var element in validationsState) {
        if (element == FamilyMemberValidationState.nameEmpty) {
          emit(NameInvalidState(
            errorMessage: S.current.thisFieldIsRequired,
          ));
          isScrollable = true;
        } else if (element == FamilyMemberValidationState.invalidMobileNumber) {
          emit(MobileNumberInvalidState(
            errorMessage: S.current.thisFieldIsRequired,
          ));
          isScrollable = true;
        } else if (element ==
            FamilyMemberValidationState.invalidFamilyMemberType) {
          emit(FamilyMemberTypeInvalidState(
            errorMessage: S.current.thisFieldIsRequired,
          ));
          isScrollable = true;
        } else if (element == FamilyMemberValidationState.emailAddressEmpty) {
          emit(EmailInvalidState(
            errorMessage: S.current.thisFieldIsRequired,
          ));
          isScrollable = true;
        } else if (element == FamilyMemberValidationState.emailFormat) {
          emit(EmailInvalidState(
            errorMessage: S.current.pleaseEnterAValidEmailAddressForExample,
          ));
          isScrollable = true;
        } else if (element == FamilyMemberValidationState.invalidImage) {
          emit(ImageSelectionInvalidState(
            errorMessage: S.current.thisFieldIsRequired,
          ));
          isScrollable = true;
        }
      }
    } else if (isValidMobileNumber == false &&
        phoneType != PhoneNumberType.MOBILE) {
      emit(MobileNumberInvalidState(
        errorMessage: getMobileValidationErrorMessage(
          mobileNumber: event.mobileNumber,
          regionCode: event.countryCode,
        ),
      ));
      isScrollable = true;
    } else {
      isScrollable = false;
      emit(
        ValidAddFamilyFormState(
          name: event.name,
          mobileNumber: event.mobileNumber,
          familyMemberTypeId: 0,
          email: event.emailAddress,
          attachment: event.imagePath,
          countryCode: event.countryCode,
        ),
      );
    }

    if (isScrollable) {
      emit(ScrollToItemState());
      isScrollable = false;
    }
  }

  FutureOr<void> _onAddFamilyMemberEvent(
      AddFamilyMemberEvent event, Emitter<AddFamilyState> emit) async {
    emit(ShowLoadingState());

    final DataState<FamilyMemberInvitation> dataState =
        await _addUserFamilyMemberUseCase(event.request, event.imagePath);

    if (dataState is DataSuccess) {
      emit(AddFamilyMemberSuccessState(
          familyMembersList: dataState.data!.familyMembers ?? [],
          invitation: dataState.data!.invitation ?? const Invitation(),
          message: dataState.message ?? ""));
    } else {
      emit(AddFamilyMemberErrorState(message: dataState.message ?? ""));
    }

    emit(HideLoadingState());
  }

  FutureOr<void> _onUpdateFamilyMemberEvent(
      UpdateFamilyMemberEvent event, Emitter<AddFamilyState> emit) async {
    emit(ShowLoadingState());

    final DataState dataState =
        await _updateUserFamilyMemberUseCase(event.request, event.imagePath);

    if (dataState is DataSuccess) {
      emit(UpdateFamilyMemberSuccessState(
          familyMembersList: dataState.data as List<FamilyMember>,
          message: dataState.message ?? ""));
    } else {
      emit(UpdateFamilyMemberErrorState(message: dataState.message ?? ""));
    }

    emit(HideLoadingState());
  }

  FutureOr<void> _onValidateEmailAddressEvent(
      ValidateEmailAddressEvent event, Emitter<AddFamilyState> emit) {
    FamilyMemberValidationState validationState =
        _addFamilyMemberValidationUseCase.validateEmailAddress(
      event.emailAddress,
    );
    if (validationState == FamilyMemberValidationState.valid) {
      emit(EmailValidState());
    } else if (validationState == FamilyMemberValidationState.emailFormat) {
      emit(EmailInvalidState(
        errorMessage: S.current.pleaseEnterAValidEmailAddressForExample,
      ));
    } else {
      emit(EmailInvalidState(
        errorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onValidateImageSelectionEvent(
      ValidateImageSelectionEvent event, Emitter<AddFamilyState> emit) {
    FamilyMemberValidationState validationState =
        _addFamilyMemberValidationUseCase.validateImageSelection(
      event.imagePath,
    );

    if (validationState == FamilyMemberValidationState.valid) {
      emit(ImageSelectionValidState(imagePath: event.imagePath!));
    } else {
      emit(ImageSelectionInvalidState(
        errorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }
}
