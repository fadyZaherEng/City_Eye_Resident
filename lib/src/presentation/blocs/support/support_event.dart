part of 'support_bloc.dart';

abstract class SupportEvent extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class GetSupportServicesEvent extends SupportEvent {}

class NavigateToSupportServiceDetailsScreenEvent extends SupportEvent {
  final HomeSupport supportService;

  NavigateToSupportServiceDetailsScreenEvent({
    required this.supportService,
  });
}

class SearchSupportServicesEvent extends SupportEvent {
  final String searchText;
  final List<HomeSupport> supportServices;

  SearchSupportServicesEvent({
    required this.searchText,
    required this.supportServices,
  });
}

class GetOffersDataEvent extends SupportEvent {
  final OffersRequest request;

  GetOffersDataEvent({required this.request});
}

class ResetSupportServicesEvent extends SupportEvent {}

class ResetSearchTextSupportServicesEvent extends SupportEvent {}

class OnTapOfferEvent extends SupportEvent {
  final Offer offer;

  OnTapOfferEvent({required this.offer});
}