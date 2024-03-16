// ignore_for_file: must_be_immutable

part of 'landing_bloc.dart';

abstract class LandingState extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LandingInitialState extends LandingState {}

class ShowSkeletonState extends LandingState {}

class ShowLoadingState extends LandingState {}

class HideLoadingState extends LandingState {}

class GetLanguagesSuccessState extends LandingState {
  final List<Language> languages;

  GetLanguagesSuccessState({
    required this.languages,
  });
}

class GetLanguagesErrorState extends LandingState {
  final String message;

  GetLanguagesErrorState({
    required this.message,
  });
}

class OpenLanguageBottomSheetState extends LandingState {
  final List<Language> languages;

  OpenLanguageBottomSheetState({
    required this.languages,
  });
}

class SetLanguageState extends LandingState {
  final String languageCode;

  SetLanguageState({
    required this.languageCode,
  });
}

class GetLanguageState extends LandingState {
  final String languageCode;

  GetLanguageState({
    required this.languageCode,
  });
}

class NavigateToSignInScreenState extends LandingState {
  final FirebaseNotificationData? firebaseNotificationData;

  NavigateToSignInScreenState({
    this.firebaseNotificationData,
  });
}

class NavigateToSignUpScreenState extends LandingState {}

class NavigateToContactUsScreenState extends LandingState {}

class OpenFeatureScreenState extends LandingState {
  final Feature feature;

  OpenFeatureScreenState({
    required this.feature,
  });
}

class OpenSocialMediaState extends LandingState {
  final SocialMedia socialMedia;

  OpenSocialMediaState({
    required this.socialMedia,
  });
}

class NavigateBackState extends LandingState {}

class GetLandingDataSuccessState extends LandingState {
  Landing landingData;

  GetLandingDataSuccessState({required this.landingData});
}

class GetLandingDataErrorState extends LandingState {
  final String message;

  GetLandingDataErrorState({required this.message});
}

class GetOffersDataSuccessState extends LandingState {
  List<Offer> offers;

  GetOffersDataSuccessState({required this.offers});
}

class GetOffersDataFailedState extends LandingState {
  final String message;

  GetOffersDataFailedState({required this.message});
}

class GetLandingsDataSuccessState extends LandingState {
  final List<Language> languages;
  final List<Offer> offers;
  final Landing landingData;

  GetLandingsDataSuccessState({
    required this.languages,
    required this.offers,
    required this.landingData,
  });
}

class OnTapOfferNavigateToWebViewState extends LandingState {
  final Offer offer;

  OnTapOfferNavigateToWebViewState({required this.offer});
}

