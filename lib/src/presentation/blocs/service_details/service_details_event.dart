part of 'service_details_bloc.dart';

@immutable
abstract class ServiceDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class GetServiceDetailsEvent extends ServiceDetailsEvent {}

class NavigateToServiceScreenEvent extends ServiceDetailsEvent {
  final String parentServiceName;
  final HomeService homeService;

  NavigateToServiceScreenEvent({
    required this.parentServiceName,
    required this.homeService,
  });
}
