import 'dart:async';
import 'dart:developer';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/validation/contact_us_validator.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/contact_us/request/add_contact_us_request.dart';
import 'package:city_eye/src/domain/entities/contact_us/country.dart';
import 'package:city_eye/src/domain/usecase/contact_us/add_contact_us_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/contact_us_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/get_countries_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/set_country_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/validate_country_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/validate_email_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/validate_message_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/validate_mobile_number_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/validate_name_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_us_event.dart';
part 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  final SetCountryUseCase _setCountryUseCase;
  final ContactUsValidationUseCase _contactUsValidationUseCase;
  final ValidateNameUseCase _validateNameUseCase;
  final ValidateEmailUseCase _validateEmailUseCase;
  final ValidateMobileNumberUseCase _validateMobileNumberUseCase;
  final ValidateCountryUseCase _validateCountryUseCase;
  final ValidateMessageUseCase _validateMessageUseCase;
  final GetCountriesUseCase _getCountriesUseCase;
  final AddContactUsUseCase _addContactUsUseCase;
  List<Country> _countries = [];

  ContactUsBloc(
    this._setCountryUseCase,
    this._contactUsValidationUseCase,
    this._validateNameUseCase,
    this._validateEmailUseCase,
    this._validateMobileNumberUseCase,
    this._validateCountryUseCase,
    this._validateMessageUseCase,
    this._getCountriesUseCase,
    this._addContactUsUseCase,
  ) : super(ContactUsInitial()) {
    on<NavigateBackEvent>(_onContactUsPopEvent);
    on<ContactUsSendEvent>(_onContactUsSendEvent);
    on<SetCountryEvent>(_onSetCountryEvent);
    on<OpenCountryBottomSheetEvent>(_onOpenCountryBottomSheetEvent);
    on<ValidateUsernameEvent>(_onValidateUsernameEvent);
    on<ValidateEmailEvent>(_onValidateEmailEvent);
    on<ValidateMobileNumberEvent>(_onValidateMobileNumberEvent);
    on<ValidateCountryEvent>(_onValidateCountryEvent);
    on<ValidateMessageEvent>(_onValidateMessageEvent);
    on<FetchCountriesEvent>(_onFetchCountriesEvent);
    on<ClearContactUsDataFieldsEvent>(_onClearContactUsDataFieldsEvent);
    on<NavigateBackForClearDataEvent>(_onNavigateBackForClearDataEvent);
    on<DisplayDialogWhenSuccessAddContactUsEvent>(
        _onDisplayDialogWhenSuccessAddContactUsEvent);
  }

  FutureOr<void> _onContactUsPopEvent(
      NavigateBackEvent event, Emitter<ContactUsState> emit) {
    emit(NavigateBackState());
  }

  FutureOr<void> _onContactUsSendEvent(
      ContactUsSendEvent event, Emitter<ContactUsState> emit) async {
    final validationsState = _contactUsValidationUseCase.validateFormUseCase(
      name: event.addContactUsRequest.name ?? "",
      emailAddress: event.addContactUsRequest.email ?? "",
      mobileNumber: event.addContactUsRequest.mobile ?? "",
      country: event.countryName,
      message: event.addContactUsRequest.message ?? "",
    );

    if (validationsState.isNotEmpty) {
      for (var element in validationsState) {
        if (element == ContactUsItemsValidationState.nameEmpty) {
          emit(ValidateUsernameEmptyFormatState(
            nameValidatorMessage: S.current.thisFieldIsRequired,
          ));
        } else if (element == ContactUsItemsValidationState.nameInvalid) {
          emit(ValidateUsernameEmptyFormatState(
            nameValidatorMessage: S.current.invalidName,
          ));
        } else if (element == ContactUsItemsValidationState.emailEmpty) {
          emit(ValidateEmailEmptyFormatState(
            emailValidatorMessage: S.current.thisFieldIsRequired,
          ));
        } else if (element == ContactUsItemsValidationState.emailInvalid) {
          emit(ValidateEmailEmptyFormatState(
            emailValidatorMessage: S.current.invalidEmailAddress,
          ));
        } else if (element == ContactUsItemsValidationState.mobileNumberEmpty) {
          emit(ValidateMobileNumberEmptyFormatState(
            mobileNumberValidatorMessage: S.current.thisFieldIsRequired,
          ));
        } else if (element == ContactUsItemsValidationState.countryEmpty) {
          emit(ValidateCountryEmptyFormatState(
            countryValidatorMessage: S.current.thisFieldIsRequired,
          ));
        } else if (element == ContactUsItemsValidationState.messageEmpty) {
          emit(ValidateMessageEmptyFormatState(
            messageValidatorMessage: S.current.thisFieldIsRequired,
          ));
        } else if (element == ContactUsItemsValidationState.messageInvalid) {
          emit(ValidateMessageEmptyFormatState(
            messageValidatorMessage:
                S.current.messageShouldBeMoreThen10Characters,
          ));
        }
      }
    } else {
      emit(ShowLoadingState());
      final addContactUsState = await _addContactUsUseCase(
        event.addContactUsRequest,
      );

      if (addContactUsState is DataSuccess) {
        emit(SuccessContactUsSendState(addContactUsState.message ?? ""));
      } else if (addContactUsState is DataFailed) {
        emit(ErrorContactUsSendState(addContactUsState.message ?? ""));
      }
      emit(HideLoadingState());
    }
  }

  FutureOr<void> _onSetCountryEvent(
      SetCountryEvent event, Emitter<ContactUsState> emit) async {
    await _setCountryUseCase(event.countryCode);
    emit(SetCountryState(
        countryCode: event.countryCode, countryName: event.countryName));
  }

  FutureOr<void> _onOpenCountryBottomSheetEvent(
      OpenCountryBottomSheetEvent event, Emitter<ContactUsState> emit) {
    emit(OpenCountryBottomSheetState());
  }

  FutureOr<void> _onValidateUsernameEvent(
      ValidateUsernameEvent event, Emitter<ContactUsState> emit) {
    ContactUsItemsValidationState validationState =
        _validateNameUseCase.validateName(event.name);

    if (validationState == ContactUsItemsValidationState.valid) {
      emit(ValidateUsernameState());
    } else if (validationState == ContactUsItemsValidationState.nameInvalid) {
      emit(ValidateUsernameEmptyFormatState(
        nameValidatorMessage: S.current.invalidName,
      ));
    } else {
      emit(ValidateUsernameEmptyFormatState(
        nameValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onValidateEmailEvent(
      ValidateEmailEvent event, Emitter<ContactUsState> emit) {
    ContactUsItemsValidationState validationState =
        _validateEmailUseCase.validateEmailAddress(
      event.email,
    );

    if (validationState == ContactUsItemsValidationState.valid) {
      emit(ValidateEmailState());
    } else if (validationState == ContactUsItemsValidationState.emailInvalid) {
      emit(ValidateEmailEmptyFormatState(
        emailValidatorMessage: S.current.invalidEmailAddress,
      ));
    } else {
      emit(ValidateEmailEmptyFormatState(
        emailValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onValidateMobileNumberEvent(
      ValidateMobileNumberEvent event, Emitter<ContactUsState> emit) {
    ContactUsItemsValidationState validationState =
        _validateMobileNumberUseCase.validateMobileNumber(
      event.mobileNo,
    );

    if (validationState == ContactUsItemsValidationState.valid) {
      emit(ValidateMobileNumberState());
    } else {
      emit(ValidateMobileNumberEmptyFormatState(
        mobileNumberValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onValidateCountryEvent(
      ValidateCountryEvent event, Emitter<ContactUsState> emit) {
    ContactUsItemsValidationState validationState =
        _validateCountryUseCase.validateCountry(
      event.countryCode,
    );

    if (validationState == ContactUsItemsValidationState.valid) {
      emit(ValidateCountryState(
          countryCode: event.countryCode, countryName: event.countryName));
    } else {
      emit(ValidateCountryEmptyFormatState(
        countryValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onValidateMessageEvent(
      ValidateMessageEvent event, Emitter<ContactUsState> emit) {
    ContactUsItemsValidationState validationState =
        _validateMessageUseCase.validateMessage(
      event.message,
    );

    if (validationState == ContactUsItemsValidationState.valid) {
      emit(ValidateMessageState());
    } else if (validationState ==
        ContactUsItemsValidationState.messageInvalid) {
      emit(ValidateMessageEmptyFormatState(
        messageValidatorMessage: S.current.messageShouldBeMoreThen10Characters,
      ));
    } else {
      emit(ValidateMessageEmptyFormatState(
        messageValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  Future<void> _onFetchCountriesEvent(
      FetchCountriesEvent event, Emitter<ContactUsState> emit) async {
    emit(ShowLoadingState());
    if (_countries.isEmpty) {
      log("Here  _countries isEmpty");
      final countriesState = await _getCountriesUseCase();
      if (countriesState is DataSuccess<List<Country>>) {
        _countries = countriesState.data ?? [];
        emit(SuccessFetchCountriesState(countries: countriesState.data ?? []));
      } else if (countriesState is DataFailed) {
        emit(ErrorFetchCountriesState(message: countriesState.message ?? ""));
      }
    } else {
      log("Here _countries isNotEmpty");
      emit(SuccessFetchCountriesState(countries: _countries));
    }

    emit(HideLoadingState());
  }

  Future<void> _onDisplayDialogWhenSuccessAddContactUsEvent(
      DisplayDialogWhenSuccessAddContactUsEvent event,
      Emitter<ContactUsState> emit) async {
    emit(DisplayDialogWhenSuccessAddContactUsState(event.message));
  }

  FutureOr<void> _onClearContactUsDataFieldsEvent(
      ClearContactUsDataFieldsEvent event, Emitter<ContactUsState> emit) {
    emit(ClearContactUsDataFieldsState());
  }

  FutureOr<void> _onNavigateBackForClearDataEvent(
      NavigateBackForClearDataEvent event, Emitter<ContactUsState> emit) {
    emit(NavigateBackForClearDataState());
  }
}
