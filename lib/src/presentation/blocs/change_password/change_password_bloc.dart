import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/validation/change_password_validator.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/request/change_password_request.dart';
import 'package:city_eye/src/domain/usecase/change_password_use_case.dart';
import 'package:city_eye/src/domain/usecase/change_password_validation_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<AbstractChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordValidationUseCase _changePasswordValidationUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordBloc(
    this._changePasswordValidationUseCase,
    this._changePasswordUseCase,
  ) : super(ChangePasswordInitialState()) {
    on<ChangePasswordEvent>(_onChangePasswordEvent);
    on<ValidateOldPasswordEvent>(_onValidateOldPasswordEvent);
    on<ValidateNewPasswordEvent>(_onValidateNewPasswordEvent);
    on<ValidateConfirmPasswordEvent>(_onValidateConfirmPasswordEvent);
    on<NavigationBackEvent>(_onNavigationBackEvent);
  }

  FutureOr<void> _onChangePasswordEvent(
      ChangePasswordEvent event, Emitter<ChangePasswordState> emit) async {
    final validationsState =
        _changePasswordValidationUseCase.validateFormUseCase(
      oldPassword: event.oldPassword,
      newPassword: event.newPassword,
      confirmPassword: event.confirmPassword,
    );
    if (validationsState.isNotEmpty) {
      for (var element in validationsState) {
        if (element == ChangePasswordValidationState.oldPasswordEmpty) {
          emit(OldPasswordEmptyFormatState(
            oldPasswordValidatorMessage: S.current.thisFieldIsRequired,
          ));
        } else if (element == ChangePasswordValidationState.newPasswordEmpty) {
          emit(NewPasswordEmptyFormatState(
            newPasswordValidatorMessage: S.current.thisFieldIsRequired,
          ));
        } else if (element ==
            ChangePasswordValidationState.confirmPasswordEmpty) {
          emit(ConfirmPasswordEmptyFormatState(
            confirmPasswordValidatorMessage: S.current.thisFieldIsRequired,
          ));
        } else if (element ==
            ChangePasswordValidationState.confirmPasswordNotMatchNewPassword) {
          emit(ConfirmPasswordNotMatchNewPasswordFormatState(
            confirmPasswordValidatorMessage:
                S.current.sorryTheNewPasswordAndConfirmPasswordDoNotMatch,
          ));
        }
      }
    } else {
      emit(ShowLoadingState());
      final dataState = await _changePasswordUseCase(ChangePasswordRequest(
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
        oldPassword: event.oldPassword,
      ));
      if (dataState is DataSuccess) {
        emit(ChangePasswordSuccessState(
          message: dataState.message ?? "",
        ));
      } else {
        emit(
          ChangePasswordErrorState(
            errorMessage: dataState.message ?? "",
          ),
        );
      }

      emit(HideLoadingState());
    }
  }

  FutureOr<void> _onValidateOldPasswordEvent(
      ValidateOldPasswordEvent event, Emitter<ChangePasswordState> emit) {
    ChangePasswordValidationState validationState =
        _changePasswordValidationUseCase.validateOldPassword(
      event.oldPassword,
    );
    if (validationState == ChangePasswordValidationState.valid) {
      emit(OldPasswordFormatValidState());
    } else {
      emit(OldPasswordEmptyFormatState(
        oldPasswordValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onValidateNewPasswordEvent(
      ValidateNewPasswordEvent event, Emitter<ChangePasswordState> emit) {
    ChangePasswordValidationState validationState =
        _changePasswordValidationUseCase.validateNewPassword(
      event.newPassword,
    );
    if (validationState == ChangePasswordValidationState.valid) {
      emit(NewPasswordFormatValidState());
    } else if (validationState ==
        ChangePasswordValidationState.newPasswordMustBeSixCharacter) {
      emit(NewPasswordMostBeMustBeSixCharacterFormatState(
          newPasswordValidatorMessage:
              S.current.sorryTheNewPasswordMustBeAtLeast6CharactersLong));
    } else {
      emit(NewPasswordEmptyFormatState(
        newPasswordValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onValidateConfirmPasswordEvent(
      ValidateConfirmPasswordEvent event, Emitter<ChangePasswordState> emit) {
    ChangePasswordValidationState validationState =
        _changePasswordValidationUseCase.validateConfirmPassword(
            event.newPassword, event.confirmPassword);
    if (validationState == ChangePasswordValidationState.valid) {
      emit(ConfirmPasswordFormatValidState());
    } else if (validationState ==
        ChangePasswordValidationState.confirmPasswordNotMatchNewPassword) {
      emit(ConfirmPasswordNotMatchNewPasswordFormatState(
        confirmPasswordValidatorMessage:
            S.current.sorryTheNewPasswordAndConfirmPasswordDoNotMatch,
      ));
    } else {
      emit(ConfirmPasswordEmptyFormatState(
        confirmPasswordValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onNavigationBackEvent(
      NavigationBackEvent event, Emitter<ChangePasswordState> emit) {
    emit(NavigationBackState());
  }
}
