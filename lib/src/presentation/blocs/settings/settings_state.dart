part of 'settings_bloc.dart';

@immutable
abstract class SettingsState extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(
          this,
        ),
      ];
}

class SettingsInitialState extends SettingsState {}

class ShowLoadingState extends SettingsState {}

class HideLoadingState extends SettingsState {}

class GetAppVersionState extends SettingsState {
  final String appVersion;

  GetAppVersionState({
    required this.appVersion,
  });
}

class NavigationPopState extends SettingsState {}

class NavigationToNotificationsScreenState extends SettingsState {}

class NavigationToChangePasswordScreenState extends SettingsState {}

class GetLanguagesSuccessState extends SettingsState {
  final List<Language> languages;

  GetLanguagesSuccessState({
    required this.languages,
  });
}

class GetLanguagesErrorState extends SettingsState {
  final String message;

  GetLanguagesErrorState({
    required this.message,
  });
}

class OpenLanguagesBottomSheetState extends SettingsState {
  final List<Language> languages;

  OpenLanguagesBottomSheetState({
    required this.languages,
  });
}

class GetLanguageState extends SettingsState {
  final String languageCode;

  GetLanguageState({
    required this.languageCode,
  });
}

class SetLanguageState extends SettingsState {
  final String languageCode;

  SetLanguageState({
    required this.languageCode,
  });
}

class OpenCompoundsBottomSheetState extends SettingsState {
  final List<UserUnit> userUnits;

  OpenCompoundsBottomSheetState({
    required this.userUnits,
  });
}

class SetNotificationsSwitchButtonValueState extends SettingsState {
  final bool value;

  SetNotificationsSwitchButtonValueState({required this.value});
}

class GetNotificationsSwitchButtonValueState extends SettingsState {
  final bool value;

  GetNotificationsSwitchButtonValueState({
    required this.value,
  });
}

class EnableDisableNotificationSuccessState extends SettingsState {
  final bool value;
  final String message;

  EnableDisableNotificationSuccessState(
      {required this.value, required this.message});
}

class EnableDisableNotificationErrorState extends SettingsState {
  final bool value;
  final String message;

  EnableDisableNotificationErrorState(
      {required this.value, required this.message});
}

class WhenCompletedOpenCompoundsBottomSheetState extends SettingsState {}

class SelectCompoundState extends SettingsState {}

class DeleteUnitSuccessState extends SettingsState {
  final String message;

  DeleteUnitSuccessState({
    required this.message,
  });
}

class DeleteUnitLoadingState extends SettingsState {}

class DeleteUnitErrorState extends SettingsState {
  final String message;

  DeleteUnitErrorState({
    required this.message,
  });
}

class GetUserUnitsErrorState extends SettingsState {
  final String message;

  GetUserUnitsErrorState({
    required this.message,
  });
}

class NavigateBackState extends SettingsState {}

class DeleteAccountSuccessState extends SettingsState {
  final String message;

  DeleteAccountSuccessState({
    required this.message,
  });
}

class DeleteAccountErrorState extends SettingsState {
  final String errorMessage;

  DeleteAccountErrorState({
    required this.errorMessage,
  });
}
