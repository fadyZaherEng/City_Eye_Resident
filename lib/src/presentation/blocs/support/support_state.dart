part of 'support_bloc.dart';

abstract class SupportState extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SupportInitial extends SupportState {}

class ShowSkeletonState extends SupportState {}

class ShowLoadingSupportState extends SupportState {}

class HideLoadingSupportState extends SupportState {}

class GetSupportServicesSuccessState extends SupportState {
  final List<HomeSupport> supportServices;

  GetSupportServicesSuccessState({
    required this.supportServices,
  });
}

class GetSupportServicesErrorState extends SupportState {
  final String errorMessage;

  GetSupportServicesErrorState({
    required this.errorMessage,
  });
}

class SearchSupportServicesSuccessState extends SupportState {
  final List<HomeSupport> supportServices;
  final List<HomeSupport> searchedSupportServices;

  SearchSupportServicesSuccessState({
    required this.supportServices,
    required this.searchedSupportServices,
  });
}

class SearchSupportServicesNotFoundState extends SupportState {
  final List<HomeSupport> searchedSupportServices;

  SearchSupportServicesNotFoundState({
    required this.searchedSupportServices,
  });
}

class NavigateToSupportServiceDetailsScreenState extends SupportState {
  final HomeSupport supportService;

  NavigateToSupportServiceDetailsScreenState({
    required this.supportService,
  });
}

class GetOffersDataSuccessState extends SupportState {
  final List<Offer> offers;

  GetOffersDataSuccessState({required this.offers});
}

class GetOffersDataFailedState extends SupportState {
  final String message;

  GetOffersDataFailedState({required this.message});
}

class ResetSupportServicesState extends SupportState {
  final List<HomeSupport> supportServices;

  ResetSupportServicesState({
    required this.supportServices,
  });
}

class ResetSearchTextSupportServicesState extends SupportState {}

class OnTapOfferNavigateToWebViewState extends SupportState {
  final Offer offer;

  OnTapOfferNavigateToWebViewState({required this.offer});
}
