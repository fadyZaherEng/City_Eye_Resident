part of 'more_bloc.dart';

abstract class MoreState extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class MoreInitial extends MoreState {}

class ShowLoadingState extends MoreState {}

class HideLoadingState extends MoreState {}

class NavigateToProfileScreenState extends MoreState {}

class NavigateToGalleryScreenState extends MoreState {}

class NavigateToCommunityScreenState extends MoreState {}

class NavigateToCompoundRulesScreenState extends MoreState {}

class NavigateToTermsAndConditionsScreenState extends MoreState {}

class NavigateToAboutUsScreenState extends MoreState {}

class NavigateToStuffScreenState extends MoreState {}

class NavigateToFAQScreenState extends MoreState {}

class NavigateToSettingsScreenState extends MoreState {}

class NavigateToComplainScreenState extends MoreState {}

class LogoutState extends MoreState {}

class OpenWhatsAppState extends MoreState {
  final String phoneNumber;

  OpenWhatsAppState({
    required this.phoneNumber,
  });
}

class GetUserInformationState extends MoreState {
  final User user;
  final UserUnit userUnit;

  GetUserInformationState({
    required this.user,
    required this.userUnit,
  });
}

class LaunchToSocialMediaState extends MoreState {
  final CompoundSocialMedia socialMedia;

  LaunchToSocialMediaState({
    required this.socialMedia,
  });
}

class NavigateToPaymentScreenState extends MoreState {}

class NavigateToDelegatedScreenState extends MoreState {}

class NavigateToRegisterScreenState extends MoreState {}

class OpenCompoundsBottomSheetState extends MoreState {
  final List<UserUnit> userUnits;

  OpenCompoundsBottomSheetState({
    required this.userUnits,
  });
}

class WhenCompletedOpenCompoundsBottomSheetState extends MoreState {}
class SelectCompoundState extends MoreState {}

class SwitchCompoundState extends MoreState {}

class GetCompoundConfigurationState extends MoreState {
  final CompoundConfiguration compoundConfiguration;

  GetCompoundConfigurationState({
    required this.compoundConfiguration,
  });

}

class SwitchCompoundErrorState extends MoreState {
  final String message;

  SwitchCompoundErrorState({
    required this.message,
  });
}

class GetUserUnitsSuccessState extends MoreState {
  final List<UserUnit> userUnits;

  GetUserUnitsSuccessState({
    required this.userUnits,
  });
}

class GetUserUnitsErrorState extends MoreState {
  final String message;

  GetUserUnitsErrorState({
    required this.message,
  });
}

class NavigateBackState extends MoreState {}

class NavigateToBadgeIdentityScreenState extends MoreState {}
