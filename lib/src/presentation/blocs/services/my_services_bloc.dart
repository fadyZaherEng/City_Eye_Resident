import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/offers_request.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/domain/entities/offers/offer.dart';
import 'package:city_eye/src/domain/entities/services/my_services.dart';
import 'package:city_eye/src/domain/usecase/get_offers_use_case.dart';
import 'package:city_eye/src/domain/usecase/home/filter_home_services_for_specific_service_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_services_event.dart';

part 'my_services_state.dart';

class MyServicesBloc extends Bloc<MyServicesEvent, MyServicesState> {
  List<HomeService> _myServicesSearch = [];
  final GetOffersUseCase _getOffersUseCase;
  final FilterHomeServicesForSpecificServiceUseCase
      _filterHomeServicesForSpecificServiceUseCase;

  MyServicesBloc(
      this._getOffersUseCase, this._filterHomeServicesForSpecificServiceUseCase)
      : super(MyServicesInitialState()) {
    on<GetOffersEvent>(_onFetchOffersEvent);
    on<ClearSearchEvent>(_onClearSearchEvent);
    on<SearchMyServicesEvent>(_onChangeSearchEvent);
    on<NavigateToMyServiceDetailsEvent>(_onNavigateToMyServiceDetailsEvent);
    on<FilterServicesAccordingBySpecificServiceEvent>(
        _onFilterServicesAccordingBySpecificServiceEvent);
    on<OnTapOfferEvent>(_onOnTapOfferEvent);
  }

  FutureOr<void> _onClearSearchEvent(
      ClearSearchEvent event, Emitter<MyServicesState> emit) {
    emit(SearchMyServicesState(
      myServices: event.myServices,
    ));
  }

  FutureOr<void> _onChangeSearchEvent(
      SearchMyServicesEvent event, Emitter<MyServicesState> emit) {
    if (event.searchValue.isNotEmpty) {
      _myServicesSearch = event.myServices
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(event.searchValue.toLowerCase()) ||
              element.name
                  .toUpperCase()
                  .contains(event.searchValue.toUpperCase()))
          .toList();
      emit(SearchMyServicesState(
        myServices: _myServicesSearch,
      ));
    } else {
      emit(SearchMyServicesState(
        myServices: event.myServices,
      ));
    }
  }

  FutureOr<void> _onNavigateToMyServiceDetailsEvent(
      NavigateToMyServiceDetailsEvent event, Emitter<MyServicesState> emit) {
    emit(NavigateToMyServiceDetailsState(
      myService: event.myService,
    ));
  }

  FutureOr<void> _onFetchOffersEvent(
      GetOffersEvent event, Emitter<MyServicesState> emit) async {
    emit(GetMyServicesSkeletonState());
    final offersState =
        await _getOffersUseCase(OffersRequest(pageCode: event.pageCode));
    if (offersState is DataSuccess<List<Offer>>) {
      emit(GetOffersSuccessState(offers: offersState.data ?? []));
    } else if (offersState is DataFailed) {
      emit(GetOffersErrorState(errorMessage: offersState.message ?? ""));
    }
  }

  FutureOr<void> _onFilterServicesAccordingBySpecificServiceEvent(
      FilterServicesAccordingBySpecificServiceEvent event,
      Emitter<MyServicesState> emit) {
    final filteredHomeServices = _filterHomeServicesForSpecificServiceUseCase(
      event.homeServices,
      event.homeService,
    );
    emit(GetServicesAfterFilterationForSpecificServiceState(
        filteredServices: filteredHomeServices));
  }

  FutureOr<void> _onOnTapOfferEvent(
      OnTapOfferEvent event, Emitter<MyServicesState> emit) {
    if (event.offer.iSRedirectUrl) {
      emit(OnTapOfferNavigateToWebViewState(offer: event.offer));
    }
  }
}
