part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(
          this,
        ),
      ];
}

class GetAppVersionEvent extends SettingsEvent {}

class NavigationPopEvent extends SettingsEvent {}

class NavigationToNotificationsScreenEvent extends SettingsEvent {}

class NavigationToChangePasswordScreenEvent extends SettingsEvent {}

class OpenLanguagesBottomSheetEvent extends SettingsEvent {
  final List<Language> languages;

  OpenLanguagesBottomSheetEvent({
    required this.languages,
  });
}

class OpenCompoundsBottomSheetEvent extends SettingsEvent {}

class GetNotificationsSwitchButtonValueEvent extends SettingsEvent {}

class SetNotificationsSwitchButtonValueEvent extends SettingsEvent {
  final bool value;

  SetNotificationsSwitchButtonValueEvent({required this.value});
}

class EnableDisableNotificationsEvent extends SettingsEvent {
  final bool value;

  EnableDisableNotificationsEvent({required this.value});
}

class GetLanguagesEvent extends SettingsEvent {}

class GetLanguageEvent extends SettingsEvent {}

class SetLanguageEvent extends SettingsEvent {
  final String languageCode;

  SetLanguageEvent({
    required this.languageCode,
  });

}
class WhenCompletedOpenCompoundsBottomSheetEvent extends SettingsEvent {}

class SelectUnitEvent extends SettingsEvent {
  final UserUnit userUnit;

  SelectUnitEvent({
    required this.userUnit,
  });
}

class DeleteUnitEvent extends SettingsEvent {}

class DeleteAccountEvent extends SettingsEvent {}
