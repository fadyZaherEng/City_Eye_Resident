import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/get_mobile_validation_error_message.dart';
import 'package:city_eye/src/core/utils/validation/sign_in_validator.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/request/login_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/request_otp_request.dart';
import 'package:city_eye/src/domain/entities/register/otp.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/domain/usecase/get_remember_me_use_case.dart';
import 'package:city_eye/src/domain/usecase/login_use_case.dart';
import 'package:city_eye/src/domain/usecase/request_otp_use_case.dart';
import 'package:city_eye/src/domain/usecase/save_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_notifications_switch_button_value_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_remember_me_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/sign_in_validation_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<AbstractSignInEvent, SignInState> {
  final LoginUseCase _loginUseCase;
  final GetRememberMeUseCase _getRememberMeUseCase;
  final SetRememberMeUseCase _setRememberMeUseCase;
  final SaveUserInformationUseCase _saveUserInformationUseCase;
  final SetUserUnitUseCase _setUserUnitUseCase;
  final RequestOTPUseCase _requestOTPUseCase;
  final LoginValidationUseCase _signInValidationUseCase;
  final SetNotificationsSwitchButtonValueUseCase
      _setNotificationsSwitchButtonValueUseCase;

  User user = User();
  bool _rememberMeValue = false;

  SignInBloc(
    this._loginUseCase,
    this._signInValidationUseCase,
    this._setRememberMeUseCase,
    this._getRememberMeUseCase,
    this._saveUserInformationUseCase,
    this._setUserUnitUseCase,
    this._requestOTPUseCase,
    this._setNotificationsSwitchButtonValueUseCase,
  ) : super(SignInInitialState()) {
    on<SignInEvent>(_onSignInEvent);
    on<ChangeRememberMeValueEvent>(_onChangeRememberMeValueEvent);
    on<NavigateToForgotPasswordScreenState>(_onForgetPasswordEvent);
    on<NavigateToSignUpScreenEvent>(_onCreateAccountEvent);
    on<OpenUnitsBottomSheetEvent>(_onOpenCompoundsBottomSheetEvent);
    on<SelectCompoundEvent>(_onSelectCompoundEvent);
    on<ValidateMobileNumberEvent>(_onValidateUsernameEvent);
    on<ValidatePasswordEvent>(_onValidatePasswordEvent);
    on<GetRememberMeEvent>(_onGetRememberMeEvent);
    on<NavigateToRegisterScreenEvent>(_onNavigateToRegisterScreenEvent);
    on<RequestOTPEvent>(_onRequestOTPEvent);
  }

  bool? isValidMobileNumber = false;
  var phoneType = PhoneNumberType.UNKNOWN;

  FutureOr<void> _onSignInEvent(
      SignInEvent event, Emitter<SignInState> emit) async {
    final validationsState = _signInValidationUseCase.validateFormUseCase(
      mobileNumber: event.mobileNumber,
      password: event.password,
    );
    if (validationsState.isNotEmpty) {
      for (var element in validationsState) {
        if (element == SignInValidationState.mobileNumberEmpty) {
          emit(MobileNumberEmptyFormatState(
            mobileNumberValidatorMessage: S.current.mobileNumberCantBeEmpty,
          ));
        } else if (element == SignInValidationState.passwordEmpty) {
          emit(PasswordEmptyFormatState(
            passwordValidatorMessage: S.current.passwordCantBeEmpty,
          ));
        }
      }
    } else if (isValidMobileNumber == false &&
        phoneType != PhoneNumberType.MOBILE) {
      emit(MobileNumberEmptyFormatState(
        mobileNumberValidatorMessage: getMobileValidationErrorMessage(
          mobileNumber: event.mobileNumber,
          regionCode: event.regionCode,
        ),
      ));
    } else {
      emit(SignInLoadingState());
      final DataState dataState = await _loginUseCase(LoginRequest(
        mobile: event.mobileNumber,
        password: event.password,
      ));

      if (dataState is DataSuccess) {
        user = dataState.data;

        await _setNotificationsSwitchButtonValueUseCase(
            user.userDeviceInfo.isAllowNotification);
        if (user.userInformation.otpStatus == false) {
          add(RequestOTPEvent(
            phoneNumber: event.mobileNumber,
            userId: user.userInformation.id,
            compoundId: user.userUnits.first.compoundId,
          ));
        } else if (user.userInformation.status == false) {
          emit(
            SignInErrorState(
              errorMessage: dataState.message ?? "",
              icon: ImagePaths.error,
            ),
          );
        } else {
          if (user.userUnits.length == 1) {
            if (user.userUnits.first.isCompoundVerified == false ||
                user.userUnits.first.isActive == false) {
              emit(
                SignInErrorState(
                  errorMessage: user.userUnits.first.message,
                  icon: ImagePaths.info,
                ),
              );
            } else {
              add(SelectCompoundEvent(userUnit: user.userUnits.first));
            }
          } else {
            emit(SignInSuccessState(
              userUnits: dataState.data.userUnits,
              userId: user.userInformation.id,
            ));
          }
        }
      } else if (dataState is DataFailed) {
        emit(
          SignInErrorState(
            errorMessage: dataState.message ?? "",
            icon: ImagePaths.error,
          ),
        );
      }
    }
  }

  FutureOr<void> _onChangeRememberMeValueEvent(
      ChangeRememberMeValueEvent event, Emitter<SignInState> emit) {
    _rememberMeValue = event.rememberMeValue;
    emit(ChangeRememberMeValueState(
      rememberMeValue: _rememberMeValue,
    ));
  }

  FutureOr<void> _onForgetPasswordEvent(
      NavigateToForgotPasswordScreenState event, Emitter<SignInState> emit) {
    emit(NavigateToForgotPasswordScreenEvent());
  }

  FutureOr<void> _onCreateAccountEvent(
      NavigateToSignUpScreenEvent event, Emitter<SignInState> emit) {
    emit(NavigateToSignUpScreenState());
  }

  FutureOr<void> _onOpenCompoundsBottomSheetEvent(
      OpenUnitsBottomSheetEvent event, Emitter<SignInState> emit) {
    emit(OpenUnitsBottomSheetState(
        userUnits: event.userUnits, userId: event.userId));
  }

  FutureOr<void> _onSelectCompoundEvent(
      SelectCompoundEvent event, Emitter<SignInState> emit) {
    _setRememberMeUseCase(_rememberMeValue);
    _saveUserInformationUseCase(user);
    _setUserUnitUseCase(event.userUnit);
    emit(SelectCompoundState());
  }

  FutureOr<void> _onValidateUsernameEvent(
      ValidateMobileNumberEvent event, Emitter<SignInState> emit) async {
    try {
      phoneType = await PhoneNumberUtil.getNumberType(
          event.mobileNumber, event.regionCode);
      isValidMobileNumber = await PhoneNumberUtil.isValidPhoneNumber(
          event.mobileNumber, event.regionCode);

      if (isValidMobileNumber == true && phoneType == PhoneNumberType.MOBILE) {
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

  FutureOr<void> _onValidatePasswordEvent(
      ValidatePasswordEvent event, Emitter<SignInState> emit) {
    SignInValidationState validationState =
        _signInValidationUseCase.validatePassword(
      event.password,
    );
    if (validationState == SignInValidationState.valid) {
      emit(PasswordFormatValidState());
    } else {
      emit(PasswordEmptyFormatState(
        passwordValidatorMessage: S.current.passwordCantBeEmpty,
      ));
    }
  }

  FutureOr<void> _onGetRememberMeEvent(
      GetRememberMeEvent event, Emitter<SignInState> emit) async {
    emit(GetRememberMeState(rememberMe: await _getRememberMeUseCase()));
  }

  FutureOr<void> _onNavigateToRegisterScreenEvent(
      NavigateToRegisterScreenEvent event, Emitter<SignInState> emit) {
    emit(NavigateToRegisterScreenState(
        userId: event.userId, userUnits: event.userUnits));
  }

  FutureOr<void> _onRequestOTPEvent(
      RequestOTPEvent event, Emitter<SignInState> emit) async {
    emit(SignInLoadingState());
    DataState<OTP> dataState = await _requestOTPUseCase(
        RequestOTPRequest(
          userId: event.userId,
        ),
        event.compoundId);
    if (dataState is DataSuccess) {
      emit(NavigateToOTPScreenState(
        phoneNumber: event.phoneNumber,
        userId: event.userId,
        otp: dataState.data?.number ?? "",
        compoundID: event.compoundId,
      ));
    } else {
      emit(SignInErrorState(
        errorMessage: dataState.message ?? "",
        icon: ImagePaths.error,
      ));
    }
  }
}
