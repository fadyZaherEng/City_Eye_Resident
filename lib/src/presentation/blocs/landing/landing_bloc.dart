import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/offers_request.dart';
import 'package:city_eye/src/domain/entities/landing/landing.dart';
import 'package:city_eye/src/domain/entities/offers/offer.dart';
import 'package:city_eye/src/domain/entities/push_notification/firebase_notification_data.dart';
import 'package:city_eye/src/domain/entities/settings/language.dart';
import 'package:city_eye/src/domain/entities/landing/feature.dart';
import 'package:city_eye/src/domain/entities/landing/social_media.dart';
import 'package:city_eye/src/domain/usecase/get_landing_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_language_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_languages_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_offers_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_language_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'landing_event.dart';

part 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  final SetLanguageUseCase _setLanguageUseCase;
  final GetLanguageUseCase _getLanguageUseCase;
  final GetLanguagesUseCase _getLanguagesUseCase;
  final GetLandingUseCase _getLandingUseCase;
  final GetOffersUseCase _getOffersUseCase;
  List<Language> _languages = [];

  LandingBloc(
    this._setLanguageUseCase,
    this._getLanguageUseCase,
    this._getLanguagesUseCase,
    this._getLandingUseCase,
    this._getOffersUseCase,
  ) : super(ShowSkeletonState()) {
    on<GetLanguagesEvent>(_onGetLanguagesEvent);
    on<OpenLanguageBottomSheetEvent>(_onOpenLanguageBottomSheetEvent);
    on<GetLanguageEvent>(_onGetLanguageEvent);
    on<SetLanguageEvent>(_onSetLanguageEvent);
    on<NavigateToSignInScreenEvent>(_onNavigateToSignInScreenEvent);
    on<NavigateToSignUpScreenEvent>(_onNavigateToSignUpScreenEvent);
    on<NavigateToContactUsScreenEvent>(_onNavigateToContactUsScreenEvent);
    on<OpenFeatureScreenEvent>(_onOpenFeatureScreenEvent);
    on<OpenSocialMediaEvent>(_onOpenSocialMediaEvent);
    on<NavigateBackEvent>(_onNavigateBackEvent);
    on<GetLandingDataEvent>(_onGetLandingDataEvent);
    on<GetOffersDataEvent>(_onGetOffersDataEvent);
    on<GatLandingDataEvent>(_onGatLandingDataEvent);
    on<OnTapOfferEvent>(_onOnTapOfferEvent);
  }

  FutureOr<void> _onOpenLanguageBottomSheetEvent(
      OpenLanguageBottomSheetEvent event, Emitter<LandingState> emit) {
    emit(OpenLanguageBottomSheetState(languages: event.languages));
  }

  FutureOr<void> _onNavigateToSignInScreenEvent(
      NavigateToSignInScreenEvent event, Emitter<LandingState> emit) {
    emit(NavigateToSignInScreenState(firebaseNotificationData: event.firebaseNotificationData));
  }

  FutureOr<void> _onNavigateToSignUpScreenEvent(
      NavigateToSignUpScreenEvent event, Emitter<LandingState> emit) {
    emit(NavigateToSignUpScreenState());
  }

  FutureOr<void> _onNavigateToContactUsScreenEvent(
      NavigateToContactUsScreenEvent event, Emitter<LandingState> emit) {
    emit(NavigateToContactUsScreenState());
  }

  FutureOr<void> _onNavigateBackEvent(
      NavigateBackEvent event, Emitter<LandingState> emit) {
    emit(NavigateBackState());
  }

  FutureOr<void> _onGetLanguageEvent(
      GetLanguageEvent event, Emitter<LandingState> emit) async {
    String languageCode = _getLanguageUseCase();
    emit(GetLanguageState(languageCode: languageCode));
  }

  FutureOr<void> _onSetLanguageEvent(
      SetLanguageEvent event, Emitter<LandingState> emit) async {
    await _setLanguageUseCase(event.languageCode);
    emit(SetLanguageState(languageCode: event.languageCode));
  }

  FutureOr<void> _onOpenFeatureScreenEvent(
      OpenFeatureScreenEvent event, Emitter<LandingState> emit) {
    emit(OpenFeatureScreenState(feature: event.feature));
  }

  FutureOr<void> _onOpenSocialMediaEvent(
      OpenSocialMediaEvent event, Emitter<LandingState> emit) {
    emit(OpenSocialMediaState(socialMedia: event.socialMedia));
  }

  FutureOr<void> _onGetLanguagesEvent(
      GetLanguagesEvent event, Emitter<LandingState> emit) async {
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

  FutureOr<void> _onGetLandingDataEvent(
      GetLandingDataEvent event, Emitter<LandingState> emit) async {
    DataState dataState = await _getLandingUseCase();
    if (dataState is DataSuccess) {
      emit(GetLandingDataSuccessState(landingData: dataState.data as Landing));
    } else {
      emit(GetLandingDataErrorState(message: dataState.message ?? ""));
    }
  }

  FutureOr<void> _onGetOffersDataEvent(
      GetOffersDataEvent event, Emitter<LandingState> emit) async {
    DataState dataState = await _getOffersUseCase(event.request);
    if (dataState is DataSuccess) {
      emit(GetOffersDataSuccessState(offers: dataState.data as List<Offer>));
    } else {
      emit(GetOffersDataFailedState(message: dataState.message ?? ""));
    }
  }

  FutureOr<void> _onGatLandingDataEvent(
      GatLandingDataEvent event, Emitter<LandingState> emit) async {
    emit(ShowSkeletonState());
    DataState offersDataState = await _getOffersUseCase(event.request);
    DataState landingDataState = await _getLandingUseCase();
    DataState languageDataState = await _getLanguagesUseCase();

    if (offersDataState is DataSuccess &&
        landingDataState is DataSuccess &&
        languageDataState is DataSuccess) {
      _languages = languageDataState.data as List<Language>;
      emit(GetLandingsDataSuccessState(
          landingData: landingDataState.data as Landing,
          offers: offersDataState.data as List<Offer>,
          languages: languageDataState.data as List<Language>));
    } else if (offersDataState is DataFailed) {
      emit(GetOffersDataFailedState(message: offersDataState.message ?? ""));
    } else if (landingDataState is DataFailed) {
      emit(GetLandingDataErrorState(message: landingDataState.message ?? ""));
    } else if (languageDataState is DataFailed) {
      emit(GetLanguagesErrorState(message: languageDataState.message ?? ""));
    }
  }

  FutureOr<void> _onOnTapOfferEvent(
      OnTapOfferEvent event, Emitter<LandingState> emit) {
    if (event.offer.iSRedirectUrl) {
      emit(OnTapOfferNavigateToWebViewState(offer: event.offer));
    }
  }
}
