import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/enable_disable_notifications.dart';
import 'package:city_eye/src/domain/entities/settings/language.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/domain/usecase/delete_account_use_case.dart';
import 'package:city_eye/src/domain/usecase/delete_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_language_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_languages_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_notifications_switch_button_value_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_units_use_case.dart';
import 'package:city_eye/src/domain/usecase/notifications/enable_disable_notifications_use_case.dart';
import 'package:city_eye/src/domain/usecase/remove_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/remove_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/save_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_is_app_language_changed_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_switch_logo_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_language_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_notifications_switch_button_value_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_remember_me_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_user_unit_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetNotificationsSwitchButtonValueUseCase
      _getNotificationsSwitchButtonValueUseCase;
  final SetNotificationsSwitchButtonValueUseCase
      _setNotificationsSwitchButtonValueUseCase;
  final EnableDisableNotificationsUseCase _setEnableDisableNotificationsUseCase;
  final GetLanguagesUseCase _getLanguagesUseCase;
  final GetLanguageUseCase _getLanguageUseCase;
  final SetLanguageUseCase _setLanguageUseCase;
  final GetUserInformationUseCase _getUserInformationUseCase;
  final SetUserUnitUseCase _setUserUnitUseCase;
  final GetUserUnitUseCase _getUserUnitUseCase;
  final SaveUserInformationUseCase _saveUserInformationUseCase;
  final SetRememberMeUseCase _setRememberMeUseCase;
  final GetUserUnitsUseCase _getUserUnitsUseCase;
  final DeleteUnitUseCase _deleteUnitUseCase;
  final RemoveUserInformationUseCase _removeUserInformationUseCase;
  final RemoveUserUnitsUseCase _removeUserUnitsUseCase;
  final SetSwitchLogoUseCase _setSwitchLogoUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final SetIsAppLanguageChangedUseCase _setIsAppLanguageChangedUseCase;

  List<Language> _languages = [];
  List<UserUnit> _userUnits = [];
  User _user = User();

  SettingsBloc(
    this._getNotificationsSwitchButtonValueUseCase,
    this._setEnableDisableNotificationsUseCase,
    this._setNotificationsSwitchButtonValueUseCase,
    this._getLanguagesUseCase,
    this._getLanguageUseCase,
    this._setLanguageUseCase,
    this._getUserInformationUseCase,
    this._setUserUnitUseCase,
    this._saveUserInformationUseCase,
    this._setRememberMeUseCase,
    this._getUserUnitsUseCase,
    this._getUserUnitUseCase,
    this._deleteUnitUseCase,
    this._removeUserInformationUseCase,
    this._removeUserUnitsUseCase,
    this._setSwitchLogoUseCase,
    this._deleteAccountUseCase,
    this._setIsAppLanguageChangedUseCase,
  ) : super(SettingsInitialState()) {
    on<NavigationPopEvent>(_onNavigationPopEvent);
    on<NavigationToNotificationsScreenEvent>(
        _onNavigationToNotificationsScreenEvent);
    on<NavigationToChangePasswordScreenEvent>(
        _onNavigationToChangePasswordScreenEvent);
    on<OpenLanguagesBottomSheetEvent>(_onOpenLanguagesBottomSheetEvent);
    on<GetNotificationsSwitchButtonValueEvent>(
        _onGetNotificationsSwitchButtonValueEvent);
    // on<SetNotificationsSwitchButtonValueEvent>(
    //     _onSetNotificationsSwitchButtonValueEvent);
    on<GetAppVersionEvent>(_onGetAppVersionEvent);
    on<SetLanguageEvent>(_onSetLanguageEvent);
    on<DeleteUnitEvent>(_onDeleteUnitEvent);
    on<GetLanguagesEvent>(_onGetLanguagesEvent);
    on<GetLanguageEvent>(_onGetLanguageEvent);
    on<OpenCompoundsBottomSheetEvent>(_onOpenCompoundsBottomSheetEvent);
    on<SelectUnitEvent>(_onSelectUnitEvent);
    on<WhenCompletedOpenCompoundsBottomSheetEvent>(
        _onWhenCompletedOpenCompoundsBottomSheetEvent);
    on<EnableDisableNotificationsEvent>(_onEnableDisableNotificationsEvent);
    on<DeleteAccountEvent>(_onDeleteAccountEvent);
  }

  FutureOr<void> _onNavigationPopEvent(
      NavigationPopEvent event, Emitter<SettingsState> emit) {
    emit(NavigationPopState());
  }

  FutureOr<void> _onNavigationToNotificationsScreenEvent(
      NavigationToNotificationsScreenEvent event, Emitter<SettingsState> emit) {
    emit(NavigationToNotificationsScreenState());
  }

  FutureOr<void> _onNavigationToChangePasswordScreenEvent(
      NavigationToChangePasswordScreenEvent event,
      Emitter<SettingsState> emit) {
    emit(NavigationToChangePasswordScreenState());
  }

  FutureOr<void> _onOpenLanguagesBottomSheetEvent(
      OpenLanguagesBottomSheetEvent event, Emitter<SettingsState> emit) {
    emit(OpenLanguagesBottomSheetState(languages: event.languages));
  }

  FutureOr<void> _onGetNotificationsSwitchButtonValueEvent(
      GetNotificationsSwitchButtonValueEvent event,
      Emitter<SettingsState> emit) async {
    emit(GetNotificationsSwitchButtonValueState(
        value: _getNotificationsSwitchButtonValueUseCase()));
  }

  // FutureOr<void> _onSetNotificationsSwitchButtonValueEvent(
  //     SetNotificationsSwitchButtonValueEvent event,
  //     Emitter<SettingsState> emit) {
  //   _setNotificationsSwitchButtonValueUseCase(event.value);
  //   emit(SetNotificationsSwitchButtonValueState(value: event.value));
  // }

  FutureOr<void> _onGetAppVersionEvent(
      GetAppVersionEvent event, Emitter<SettingsState> emit) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    emit(GetAppVersionState(appVersion: packageInfo.version));
  }

  FutureOr<void> _onSetLanguageEvent(
      SetLanguageEvent event, Emitter<SettingsState> emit) async {
    await _setLanguageUseCase(event.languageCode);
    await _setIsAppLanguageChangedUseCase(true);
    emit(SetLanguageState(
      languageCode: event.languageCode,
    ));
  }

  FutureOr<void> _onSelectUnitEvent(
      SelectUnitEvent event, Emitter<SettingsState> emit) async {
    _user = _getUserInformationUseCase();
    UserUnit userUnit = _getUserUnitUseCase();
    if (userUnit.unitId == event.userUnit.unitId) {
      emit(NavigateBackState());
      return;
    }
    await _setUserUnitUseCase(event.userUnit);
    for (int i = 0; i < _user.userUnits.length; i++) {
      if (_user.userUnits[i].unitId == event.userUnit.unitId) {
        _user.userUnits[i] = event.userUnit;
      }
    }
    await _saveUserInformationUseCase(_user);
    await _setSwitchLogoUseCase(event.userUnit.compoundLogo);
    emit(SelectCompoundState());
  }

  FutureOr<void> _onDeleteUnitEvent(
      DeleteUnitEvent event, Emitter<SettingsState> emit) async {
    emit(DeleteUnitLoadingState());

    final DataState dataState = await _deleteUnitUseCase();
    if (dataState is DataSuccess) {
      _setRememberMeUseCase(false);
      _removeUserInformationUseCase();
      _removeUserUnitsUseCase();

      emit(DeleteUnitSuccessState(
        message: dataState.message ?? "",
      ));
    } else {
      emit(DeleteUnitErrorState(
        message: dataState.message ?? "",
      ));
    }
  }

  FutureOr<void> _onGetLanguagesEvent(
      GetLanguagesEvent event, Emitter<SettingsState> emit) async {
    if (_languages.isNotEmpty) {
      emit(GetLanguagesSuccessState(languages: _languages));
      return;
    }
    emit(ShowLoadingState());

    DataState dataState = await _getLanguagesUseCase();
    _languages = dataState.data ?? [];
    if (dataState is DataSuccess) {
      emit(GetLanguagesSuccessState(languages: dataState.data ?? []));
    } else {
      emit(GetLanguagesErrorState(message: dataState.message ?? ""));
    }

    emit(HideLoadingState());
  }

  FutureOr<void> _onGetLanguageEvent(
      GetLanguageEvent event, Emitter<SettingsState> emit) {
    emit(GetLanguageState(languageCode: _getLanguageUseCase()));
  }

  FutureOr<void> _onOpenCompoundsBottomSheetEvent(
      OpenCompoundsBottomSheetEvent event, Emitter<SettingsState> emit) async {
    emit(ShowLoadingState());
    DataState<List<UserUnit>> dataState = await _getUserUnitsUseCase();
    if (dataState is DataSuccess) {
      _userUnits = dataState.data ?? [];
      UserUnit userUnit = _getUserUnitUseCase();
      for (int i = 0; i < _userUnits.length; i++) {
        if (_userUnits[i].unitId == userUnit.unitId) {
          _userUnits[i] = _userUnits[i].copyWith(isSelected: true);
        }
      }
      emit(OpenCompoundsBottomSheetState(
        userUnits: _userUnits,
      ));
    } else {
      emit(GetUserUnitsErrorState(message: dataState.message ?? ""));
    }
    emit(HideLoadingState());
  }

  FutureOr<void> _onWhenCompletedOpenCompoundsBottomSheetEvent(
      WhenCompletedOpenCompoundsBottomSheetEvent event,
      Emitter<SettingsState> emit) {
    emit(WhenCompletedOpenCompoundsBottomSheetState());
  }

  FutureOr<void> _onEnableDisableNotificationsEvent(
      EnableDisableNotificationsEvent event,
      Emitter<SettingsState> emit) async {
    emit(ShowLoadingState());
    DataState dataState = await _setEnableDisableNotificationsUseCase(
        EnableDisableNotificationsRequest(
      status: event.value,
    ));
    if (dataState is DataSuccess) {
      await _setNotificationsSwitchButtonValueUseCase(event.value);
      emit(EnableDisableNotificationSuccessState(
          value: event.value, message: dataState.message ?? ""));
    } else {
      emit(EnableDisableNotificationErrorState(
          value: event.value, message: dataState.message ?? ""));
    }
    emit(HideLoadingState());
  }

  FutureOr<void> _onDeleteAccountEvent(
      DeleteAccountEvent event, Emitter<SettingsState> emit) async {
    emit(ShowLoadingState());
    final DataState dataState = await _deleteAccountUseCase();
    if (dataState is DataSuccess) {
      _setRememberMeUseCase(false);
      _removeUserInformationUseCase();
      _removeUserUnitsUseCase();

      emit(DeleteAccountSuccessState(
        message: dataState.message ?? "",
      ));
    } else {
      emit(DeleteAccountErrorState(
        errorMessage: dataState.message ?? "",
      ));
    }
    emit(HideLoadingState());
  }
}
