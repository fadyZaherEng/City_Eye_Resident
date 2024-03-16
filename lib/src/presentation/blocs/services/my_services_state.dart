part of 'my_services_bloc.dart';

abstract class MyServicesState extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class MyServicesInitialState extends MyServicesState {}

class GetMyServicesSkeletonState extends MyServicesState {}

class GetMyServicesSuccessState extends MyServicesState {
  final List<MyService> myServices;

  GetMyServicesSuccessState({
    required this.myServices,
  });
}

class GetMyServicesErrorState extends MyServicesState {
  final String errorMessage;

  GetMyServicesErrorState({
    required this.errorMessage,
  });
}

class ClearSearchState extends MyServicesState {
  final List<HomeService> myServices;

  ClearSearchState({
    required this.myServices,
  });
}

class SearchMyServicesState extends MyServicesState {
  final List<HomeService> myServices;

  SearchMyServicesState({
    required this.myServices,
  });
}

class NavigateToMyServiceDetailsState extends MyServicesState {
  final HomeService myService;

  NavigateToMyServiceDetailsState({
    required this.myService,
  });
}

class GetOffersSuccessState extends MyServicesState {
  final List<Offer> offers;

  GetOffersSuccessState({
    required this.offers,
  });
}

class GetOffersErrorState extends MyServicesState {
  final String errorMessage;

  GetOffersErrorState({
    required this.errorMessage,
  });
}


class GetServicesAfterFilterationForSpecificServiceState
    extends MyServicesState {
  final List<HomeService> filteredServices;

  GetServicesAfterFilterationForSpecificServiceState({
    required this.filteredServices,
  });
}

class OnTapOfferNavigateToWebViewState extends MyServicesState {
  final Offer offer;

  OnTapOfferNavigateToWebViewState({required this.offer});
}