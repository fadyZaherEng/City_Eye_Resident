import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/validation/forget_password_validation.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/request/forgot_password_request.dart';
import 'package:city_eye/src/domain/usecase/forget_password_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/forgot_password_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forget_password_event.dart';

part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final ForgetPasswordValidationUseCase _forgetPasswordValidationUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgetPasswordBloc(
    this._forgetPasswordValidationUseCase,
    this._forgotPasswordUseCase,
  ) : super(ForgetPasswordInitialState()) {
    on<ResetPasswordEvent>(_onResetPasswordEvent);
    on<ValidateEmailEvent>(_onValidateEmailEvent);
  }

  FutureOr<void> _onResetPasswordEvent(
      ResetPasswordEvent event, Emitter<ForgetPasswordState> emit) async {
    ForgetPasswordValidationState validationState =
        _forgetPasswordValidationUseCase.validateEmailAddress(
      email: event.email,
    );
    if (validationState == ForgetPasswordValidationState.valid) {
      final dataState = await _forgotPasswordUseCase(
        ForgotPasswordRequest(
          email: event.email,
        ),
      );
      if (dataState is DataSuccess) {
        emit(ForgetPasswordSuccessState(
          message: dataState.message ?? "",
        ));
      } else {
        emit(ForgetPasswordErrorState(
          errorMessage: dataState.message ?? "",
        ));
      }
    } else if (validationState == ForgetPasswordValidationState.format) {
      emit(EmailNotValidState(emailValidatorMessage: S.current.invalidEmail));
    } else {
      emit(EmailEmptyState(
        emailValidatorMessage: S.current.emailAddressCantBeEmpty,
      ));
    }
  }

  FutureOr<void> _onValidateEmailEvent(
      ValidateEmailEvent event, Emitter<ForgetPasswordState> emit) {
    ForgetPasswordValidationState validationState =
        _forgetPasswordValidationUseCase.validateEmailAddress(
      email: event.email,
    );
    if (validationState == ForgetPasswordValidationState.valid) {
      emit(EmailValidState());
    } else if (validationState == ForgetPasswordValidationState.format) {
      emit(EmailNotValidState(emailValidatorMessage: S.current.invalidEmail));
    } else {
      emit(EmailEmptyState(
        emailValidatorMessage: S.current.emailAddressCantBeEmpty,
      ));
    }
  }
}
