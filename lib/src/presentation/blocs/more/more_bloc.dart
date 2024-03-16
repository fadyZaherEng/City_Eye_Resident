import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/entities/settings/compound_social_media.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/domain/usecase/get_local_compound_configuration_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_units_use_case.dart';
import 'package:city_eye/src/domain/usecase/remove_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/remove_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/save_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_switch_logo_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_remember_me_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_user_unit_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'more_event.dart';

part 'more_state.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {
  final GetUserInformationUseCase _getUserInformationUseCase;
  final GetUserUnitUseCase _getUserUnitUseCase;
  final SetRememberMeUseCase _setRememberMeUseCase;
  final SaveUserInformationUseCase _saveUserInformationUseCase;
  final RemoveUserInformationUseCase _removeUserInformationUseCase;
  final RemoveUserUnitsUseCase _removeUserUnitsUseCase;
  final SetUserUnitUseCase _setUserUnitUseCase;
  final GetLocalCompoundConfigurationUseCase
      _getLocalCompoundConfigurationUseCase;
  final GetUserUnitsUseCase _getUserUnitsUseCase;
  final SetSwitchLogoUseCase _setSwitchLogoUseCase;
  List<UserUnit> _userUnits = [];
  User _user = const User();

  MoreBloc(
    this._getUserInformationUseCase,
    this._getUserUnitUseCase,
    this._setRememberMeUseCase,
    this._saveUserInformationUseCase,
    this._removeUserInformationUseCase,
    this._removeUserUnitsUseCase,
    this._setUserUnitUseCase,
    this._getLocalCompoundConfigurationUseCase,
    this._getUserUnitsUseCase,
    this._setSwitchLogoUseCase,
  ) : super(MoreInitial()) {
    on<GetUserInformationEvent>(_onGetUserInformationEvent);
    on<NavigateToProfileScreenEvent>(_onNavigateToProfileScreenEvent);
    on<NavigateToGalleryScreenEvent>(_onNavigateToGalleryScreenEvent);
    on<NavigateToCommunityScreenEvent>(_onNavigateToCommunityScreenEvent);
    on<NavigateToCompoundRulesScreenEvent>(
        _onNavigateToCompoundRulesScreenEvent);
    on<NavigateToTermsAndConditionsScreenEvent>(
        _onNavigateToTermsAndConditionsScreenEvent);
    on<NavigateToAboutUsScreenEvent>(_onNavigateToAboutUsScreenEvent);
    on<NavigateToStuffScreenEvent>(_onNavigateToStuffScreenEvent);
    on<NavigateToFAQScreenEvent>(_onNavigateToFAQScreenEvent);
    on<NavigateToSettingsScreenEvent>(_onNavigateToSettingsScreenEvent);
    on<NavigateToComplainScreenEvent>(_onNavigateToComplainScreenEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<OpenWhatsAppEvent>(_onOpenWhatsAppEvent);
    on<LaunchToSocialMediaEvent>(_onLaunchToSocialMediaEvent);
    on<NavigateToPaymentScreenEvent>(_onNavigateToPaymentScreenEvent);
    on<NavigateToDelegatedScreenEvent>(_onNavigateToDelegatedScreenEvent);
    on<SwitchCompoundEvent>(_onSwitchCompoundEvent);
    on<OpenCompoundsBottomSheetEvent>(_onOpenCompoundsBottomSheetEvent);
    on<SelectUnitEvent>(_onSelectUnitEvent);
    on<NavigateToRegisterScreenEvent>(_onNavigateToRegisterScreenEvent);
    on<WhenCompletedOpenCompoundsBottomSheetEvent>(
        _onWhenCompletedOpenCompoundsBottomSheetEvent);
    on<GetCompoundConfigurationEvent>(_onGetCompoundConfigurationEvent);
    on<GetUserUnitsEvent>(_onGetUserUnitsEvent);
    on<NavigateToBadgeIdentityScreenEvent>(
        _onNavigateToBadgeIdentityScreenEvent);
  }

  FutureOr<void> _onNavigateToProfileScreenEvent(
      NavigateToProfileScreenEvent event, Emitter<MoreState> emit) {
    emit(NavigateToProfileScreenState());
  }

  FutureOr<void> _onNavigateToGalleryScreenEvent(
      NavigateToGalleryScreenEvent event, Emitter<MoreState> emit) {
    emit(NavigateToGalleryScreenState());
  }

  FutureOr<void> _onNavigateToCommunityScreenEvent(
      NavigateToCommunityScreenEvent event, Emitter<MoreState> emit) {
    emit(NavigateToCommunityScreenState());
  }

  FutureOr<void> _onNavigateToCompoundRulesScreenEvent(
      NavigateToCompoundRulesScreenEvent event, Emitter<MoreState> emit) {
    emit(NavigateToCompoundRulesScreenState());
  }

  FutureOr<void> _onNavigateToTermsAndConditionsScreenEvent(
      NavigateToTermsAndConditionsScreenEvent event, Emitter<MoreState> emit) {
    emit(NavigateToTermsAndConditionsScreenState());
  }

  FutureOr<void> _onNavigateToAboutUsScreenEvent(
      NavigateToAboutUsScreenEvent event, Emitter<MoreState> emit) {
    emit(NavigateToAboutUsScreenState());
  }

  FutureOr<void> _onNavigateToStuffScreenEvent(
      NavigateToStuffScreenEvent event, Emitter<MoreState> emit) {
    emit(NavigateToStuffScreenState());
  }

  FutureOr<void> _onNavigateToFAQScreenEvent(
      NavigateToFAQScreenEvent event, Emitter<MoreState> emit) {
    emit(NavigateToFAQScreenState());
  }

  FutureOr<void> _onNavigateToSettingsScreenEvent(
      NavigateToSettingsScreenEvent event, Emitter<MoreState> emit) {
    emit(NavigateToSettingsScreenState());
  }

  FutureOr<void> _onNavigateToComplainScreenEvent(
      NavigateToComplainScreenEvent event, Emitter<MoreState> emit) {
    emit(NavigateToComplainScreenState());
  }

  FutureOr<void> _onLogoutEvent(LogoutEvent event, Emitter<MoreState> emit) {
    _setRememberMeUseCase(false);
    _removeUserInformationUseCase();
    _removeUserUnitsUseCase();
    emit(LogoutState());
  }

  FutureOr<void> _onOpenWhatsAppEvent(
      OpenWhatsAppEvent event, Emitter<MoreState> emit) {
    emit(OpenWhatsAppState(phoneNumber: event.phoneNumber));
  }

  FutureOr<void> _onGetUserInformationEvent(
      GetUserInformationEvent event, Emitter<MoreState> emit) {
    User user = _getUserInformationUseCase();
    UserUnit userUnit = _getUserUnitUseCase();
    emit(GetUserInformationState(user: user, userUnit: userUnit));
  }

  FutureOr<void> _onLaunchToSocialMediaEvent(
      LaunchToSocialMediaEvent event, Emitter<MoreState> emit) {
    emit(LaunchToSocialMediaState(
      socialMedia: event.socialMedia,
    ));
  }

  FutureOr<void> _onNavigateToPaymentScreenEvent(
      NavigateToPaymentScreenEvent event, Emitter<MoreState> emit) {
    emit(NavigateToPaymentScreenState());
  }

  FutureOr<void> _onNavigateToDelegatedScreenEvent(
      NavigateToDelegatedScreenEvent event, Emitter<MoreState> emit) {
    emit(NavigateToDelegatedScreenState());
  }

  FutureOr<void> _onSwitchCompoundEvent(
    SwitchCompoundEvent event,
    Emitter<MoreState> emit,
  ) async {
    int currentUnitIndex =
        event.userUnits.indexWhere((element) => element.isSelected);
    UserUnit selectedUserUnit = const UserUnit();
    if (_userUnits.length > 1) {
      for (int i = currentUnitIndex + 1; i < _userUnits.length; i++) {
        if (_userUnits[i].isCompoundVerified == true &&
            _userUnits[i].isActive == true) {
          selectedUserUnit = _userUnits[i];
          break;
        }
      }
      if (selectedUserUnit.unitId == 0) {
        for (int i = 0; i < currentUnitIndex - 1; i++) {
          if (_userUnits[i].isCompoundVerified == true &&
              _userUnits[i].isActive == true) {
            selectedUserUnit = _userUnits[i];
            break;
          }
        }
      }
    }

    for (int i = 0; i < _userUnits.length; i++) {
      if (_userUnits[i].unitId == selectedUserUnit.unitId) {
        _userUnits[i] = _userUnits[i].copyWith(isSelected: true);
      } else {
        _userUnits[i] = _userUnits[i].copyWith(isSelected: false);
      }
    }

    if (selectedUserUnit.unitId != 0) {
      _user = _getUserInformationUseCase();
      await _setUserUnitUseCase(selectedUserUnit);
      for (int i = 0; i < _user.userUnits.length; i++) {
        if (_user.userUnits[i].unitId == selectedUserUnit.unitId) {
          _user.userUnits[i] = selectedUserUnit;
        }
      }
      await _saveUserInformationUseCase(_user);
      await _setSwitchLogoUseCase(selectedUserUnit.compoundLogo);
      emit(SwitchCompoundState());
    }
  }

  FutureOr<void> _onOpenCompoundsBottomSheetEvent(
      OpenCompoundsBottomSheetEvent event, Emitter<MoreState> emit) async {
    if (_userUnits.isNotEmpty) {
      emit(OpenCompoundsBottomSheetState(
        userUnits: event.userUnits,
      ));
      return;
    } else {
      add(GetUserUnitsEvent(isRefresh: true));
    }
  }

  FutureOr<void> _onSelectUnitEvent(
      SelectUnitEvent event, Emitter<MoreState> emit) async {
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

  FutureOr<void> _onNavigateToRegisterScreenEvent(
      NavigateToRegisterScreenEvent event, Emitter<MoreState> emit) {
    emit(NavigateToRegisterScreenState());
  }

  FutureOr<void> _onWhenCompletedOpenCompoundsBottomSheetEvent(
      WhenCompletedOpenCompoundsBottomSheetEvent event,
      Emitter<MoreState> emit) {
    emit(WhenCompletedOpenCompoundsBottomSheetState());
  }

  FutureOr<void> _onGetCompoundConfigurationEvent(
      GetCompoundConfigurationEvent event, Emitter<MoreState> emit) {
    emit(GetCompoundConfigurationState(
      compoundConfiguration: _getLocalCompoundConfigurationUseCase(),
    ));
  }

  FutureOr<void> _onGetUserUnitsEvent(
      GetUserUnitsEvent event, Emitter<MoreState> emit) async {
    // if (_userUnits.isNotEmpty && event.isRefresh == false) {
    //   emit(GetUserUnitsSuccessState(
    //     userUnits: _userUnits,
    //   ));
    // } else {
    DataState<List<UserUnit>> dataState = await _getUserUnitsUseCase();
    if (dataState is DataSuccess) {
      _userUnits = dataState.data ?? [];
      UserUnit userUnit = _getUserUnitUseCase();
      for (int i = 0; i < _userUnits.length; i++) {
        if (_userUnits[i].unitId == userUnit.unitId) {
          _userUnits[i] = _userUnits[i].copyWith(isSelected: true);
        }
      }
      emit(GetUserUnitsSuccessState(
        userUnits: _userUnits,
      ));
    } else {
      emit(GetUserUnitsErrorState(message: dataState.message ?? ""));
    }
    // }
  }

  FutureOr<void> _onNavigateToBadgeIdentityScreenEvent(
      NavigateToBadgeIdentityScreenEvent event, Emitter<MoreState> emit) {
    emit(NavigateToBadgeIdentityScreenState());
  }
}
