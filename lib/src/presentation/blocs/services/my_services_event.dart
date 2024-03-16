part of 'my_services_bloc.dart';

@immutable
abstract class MyServicesEvent extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class GetMyServicesEvent extends MyServicesEvent {}

class ClearSearchEvent extends MyServicesEvent {
  final List<HomeService> myServices;

  ClearSearchEvent({required this.myServices});
}

class SearchMyServicesEvent extends MyServicesEvent {
  final String searchValue;
  final List<HomeService> myServices;

  SearchMyServicesEvent({
    required this.searchValue,
    required this.myServices,
  });
}

class NavigateToMyServiceDetailsEvent extends MyServicesEvent {
  final HomeService myService;

  NavigateToMyServiceDetailsEvent({
    required this.myService,
  });
}

class GetOffersEvent extends MyServicesEvent {
  final String pageCode;

  GetOffersEvent({
    required this.pageCode,
  });
}

class FilterServicesAccordingBySpecificServiceEvent extends MyServicesEvent {
  final List<HomeService> homeServices;
  final HomeService homeService;

  FilterServicesAccordingBySpecificServiceEvent({
    required this.homeServices,
    required this.homeService,
  });
}

class OnTapOfferEvent extends MyServicesEvent {
  final Offer offer;

  OnTapOfferEvent({required this.offer});
}
