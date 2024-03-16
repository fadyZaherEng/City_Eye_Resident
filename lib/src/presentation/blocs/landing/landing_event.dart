part of 'landing_bloc.dart';

abstract class LandingEvent extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class OpenLanguageBottomSheetEvent extends LandingEvent {
  final List<Language> languages;

  OpenLanguageBottomSheetEvent({
    required this.languages,
  });
}

class GetLanguagesEvent extends LandingEvent {}

class SetLanguageEvent extends LandingEvent {
  final String languageCode;

  SetLanguageEvent({
    required this.languageCode,
  });
}

class GatLandingDataEvent extends LandingEvent {
  final OffersRequest request;

  GatLandingDataEvent({
    required this.request,
  });
}

class OnTapOfferEvent extends LandingEvent {
  final Offer offer;

  OnTapOfferEvent({required this.offer});
}

class GetLanguageEvent extends LandingEvent {}

class NavigateToSignInScreenEvent extends LandingEvent {
  final FirebaseNotificationData? firebaseNotificationData;

  NavigateToSignInScreenEvent({
    this.firebaseNotificationData,
  });
}

class NavigateToSignUpScreenEvent extends LandingEvent {}

class NavigateToContactUsScreenEvent extends LandingEvent {}

class OpenSocialMediaIconsEvent extends LandingEvent {}

class OpenFeatureScreenEvent extends LandingEvent {
  final Feature feature;

  OpenFeatureScreenEvent({
    required this.feature,
  });
}

class OpenSocialMediaEvent extends LandingEvent {
  final SocialMedia socialMedia;

  OpenSocialMediaEvent({
    required this.socialMedia,
  });
}

class NavigateBackEvent extends LandingEvent {}

class GetLandingDataEvent extends LandingEvent {}

class GetOffersDataEvent extends LandingEvent {
  OffersRequest request;

  GetOffersDataEvent({required this.request});
}
