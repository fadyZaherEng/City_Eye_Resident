import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/local/singleton/support/my_support_singleton.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/offers_request.dart';
import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:city_eye/src/domain/entities/offers/offer.dart';
import 'package:city_eye/src/domain/usecase/get_offers_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'support_event.dart';

part 'support_state.dart';

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  final GetOffersUseCase _getOffersUseCase;
  List<HomeSupport> supportServices = [];
  List<Offer> _offers = [];
  int startTabIndex = 0;

  SupportBloc(this._getOffersUseCase) : super(ShowSkeletonState()) {
    on<SearchSupportServicesEvent>(_onSearchSupportServicesEvent);
    on<NavigateToSupportServiceDetailsScreenEvent>(
        _onNavigateToSupportServiceDetailsScreenEvent);
    on<GetOffersDataEvent>(_onGetOffersDataEvent);
    on<ResetSupportServicesEvent>(_onResetSupportServicesEvent);
    on<ResetSearchTextSupportServicesEvent>(
        _onResetSearchTextSupportServicesEvent);
    on<OnTapOfferEvent>(_onOnTapOfferEvent);
  }

  FutureOr<void> _onSearchSupportServicesEvent(
      SearchSupportServicesEvent event, Emitter<SupportState> emit) {
    if (event.searchText.isEmpty) {
      emit(SearchSupportServicesSuccessState(
          supportServices: supportServices,
          searchedSupportServices: supportServices));
    } else {
      List<HomeSupport> filteredSupportServices = event.supportServices
          .where((element) => element.name
              .toLowerCase()
              .contains(event.searchText.trim().toLowerCase()))
          .toList();
      if (filteredSupportServices.isNotEmpty) {
        emit(
          SearchSupportServicesSuccessState(
            supportServices: supportServices,
            searchedSupportServices: filteredSupportServices,
          ),
        );
      } else {
        emit(SearchSupportServicesNotFoundState(
          searchedSupportServices: const [],
        ));
      }
    }
  }

  FutureOr<void> _onNavigateToSupportServiceDetailsScreenEvent(
      NavigateToSupportServiceDetailsScreenEvent event,
      Emitter<SupportState> emit) {
    emit(NavigateToSupportServiceDetailsScreenState(
        supportService: event.supportService));
  }

  FutureOr<void> _onGetOffersDataEvent(
      GetOffersDataEvent event, Emitter<SupportState> emit) async {
    if (_offers.isNotEmpty) {
      emit(GetOffersDataSuccessState(offers: _offers));
    } else {
      emit(ShowSkeletonState());
      DataState dataState = await _getOffersUseCase(event.request);
      _offers = dataState.data as List<Offer>;
      if (dataState is DataSuccess) {
        emit(GetOffersDataSuccessState(offers: _offers));
      } else {
        emit(GetOffersDataFailedState(message: dataState.message ?? ""));
      }
    }
  }

  FutureOr<void> _onResetSupportServicesEvent(
      ResetSupportServicesEvent event, Emitter<SupportState> emit) {
    emit(ResetSupportServicesState(
        supportServices: MySupportSingleton().supports));
  }

  FutureOr<void> _onResetSearchTextSupportServicesEvent(
      ResetSearchTextSupportServicesEvent event, Emitter<SupportState> emit) {
    emit(ResetSearchTextSupportServicesState());
  }

  FutureOr<void> _onOnTapOfferEvent(
      OnTapOfferEvent event, Emitter<SupportState> emit) {
    if (event.offer.iSRedirectUrl) {
      emit(OnTapOfferNavigateToWebViewState(offer: event.offer));
    }
  }
}
