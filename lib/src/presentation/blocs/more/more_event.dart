part of 'more_bloc.dart';

abstract class MoreEvent extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class NavigateToProfileScreenEvent extends MoreEvent {}

class NavigateToGalleryScreenEvent extends MoreEvent {}

class NavigateToCommunityScreenEvent extends MoreEvent {}

class NavigateToCompoundRulesScreenEvent extends MoreEvent {}

class NavigateToTermsAndConditionsScreenEvent extends MoreEvent {}

class NavigateToAboutUsScreenEvent extends MoreEvent {}

class NavigateToStuffScreenEvent extends MoreEvent {}

class NavigateToFAQScreenEvent extends MoreEvent {}

class NavigateToSettingsScreenEvent extends MoreEvent {}

class NavigateToComplainScreenEvent extends MoreEvent {}

class LogoutEvent extends MoreEvent {}

class OpenWhatsAppEvent extends MoreEvent {
  final String phoneNumber;

  OpenWhatsAppEvent({
    required this.phoneNumber,
  });
}

class GetUserInformationEvent extends MoreEvent {}

class LaunchToSocialMediaEvent extends MoreEvent {
  final CompoundSocialMedia socialMedia;

  LaunchToSocialMediaEvent({
    required this.socialMedia,
  });
}

class NavigateToPaymentScreenEvent extends MoreEvent {}

class NavigateToDelegatedScreenEvent extends MoreEvent {}

class NavigateToRegisterScreenEvent extends MoreEvent {}

class OpenCompoundsBottomSheetEvent extends MoreEvent {
  final List<UserUnit> userUnits;
  final bool isRefresh;

  OpenCompoundsBottomSheetEvent({
    required this.userUnits,
    required this.isRefresh,
  });
}

class WhenCompletedOpenCompoundsBottomSheetEvent extends MoreEvent {}

class SelectUnitEvent extends MoreEvent {
  final UserUnit userUnit;

  SelectUnitEvent({
    required this.userUnit,
  });
}

class SwitchCompoundEvent extends MoreEvent {
  final List<UserUnit> userUnits;

  SwitchCompoundEvent({
    required this.userUnits,
  });
}

class GetCompoundConfigurationEvent extends MoreEvent {}

class GetUserUnitsEvent extends MoreEvent {
  final bool isRefresh;

  GetUserUnitsEvent({
    required this.isRefresh,
  });
}

class NavigateToBadgeIdentityScreenEvent extends MoreEvent {}
