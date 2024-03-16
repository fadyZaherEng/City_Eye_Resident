part of 'service_details_bloc.dart';

@immutable
abstract class ServiceDetailsState extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class ServiceDetailsInitialState extends ServiceDetailsState {}

class GetServiceDetailsLoadingState extends ServiceDetailsState {}

class GetServiceDetailsSuccessState extends ServiceDetailsState {
  final List<ServiceDetails> serviceDetails;

  GetServiceDetailsSuccessState({
    required this.serviceDetails,
  });
}

class GetServiceDetailsErrorState extends ServiceDetailsState {
  final String errorMessage;

  GetServiceDetailsErrorState({
    required this.errorMessage,
  });
}

class NavigateToServiceScreenState extends ServiceDetailsState {
  final String parentServiceName;
  final HomeService homeService;

  NavigateToServiceScreenState({
    required this.parentServiceName,
    required this.homeService,
  });
}
