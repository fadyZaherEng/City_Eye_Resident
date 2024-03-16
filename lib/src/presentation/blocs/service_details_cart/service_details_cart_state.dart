part of 'service_details_cart_bloc.dart';

abstract class ServiceDetailsCartState extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class ServiceDetailsCartInitial extends ServiceDetailsCartState {}

class ResetServiceDetailsCartState extends ServiceDetailsCartState {}

class ShowSkeletonState extends ServiceDetailsCartState {}

class GetServiceDetailsCartSuccessState extends ServiceDetailsCartState {
  final List<ServiceDetailsCart> servicesDetailsCart;
  final CompoundConfiguration compoundConfiguration;

  GetServiceDetailsCartSuccessState({
    required this.servicesDetailsCart,
    required this.compoundConfiguration,
  });

  @override
  List<Object> get props => [servicesDetailsCart];
}

class GetServiceDetailsCartErrorState extends ServiceDetailsCartState {
  final String errorMessage;

  GetServiceDetailsCartErrorState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

class ChangeServiceState extends ServiceDetailsCartState {
  final List<ServiceDetailsCart> servicesDetailsCart;

  ChangeServiceState({
    required this.servicesDetailsCart,
  });

  @override
  List<Object> get props => [
        servicesDetailsCart,
      ];
}

class AddServiceCountState extends ServiceDetailsCartState {
  final List<ServiceDetailsCart> servicesDetailsCart;

  AddServiceCountState({
    required this.servicesDetailsCart,
  });

  @override
  List<Object> get props => [servicesDetailsCart];
}

class AddServiceCountErrorState extends ServiceDetailsCartState {
  final String errorMessage;

  AddServiceCountErrorState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

class MinusServiceCountState extends ServiceDetailsCartState {
  final List<ServiceDetailsCart> servicesDetailsCart;

  MinusServiceCountState({
    required this.servicesDetailsCart,
  });

  @override
  List<Object> get props => [servicesDetailsCart];
}

class GetTotalPriceState extends ServiceDetailsCartState {
  final double totalPrice;

  GetTotalPriceState({
    required this.totalPrice,
  });

  @override
  List<Object> get props => [totalPrice];
}

class ShowAreYouSureDialogState extends ServiceDetailsCartState {}

class NavigateBackState extends ServiceDetailsCartState {}

class OpenDynamicBottomSheetState extends ServiceDetailsCartState {
  final List<PageField> questions;
  final ServiceDetailsCart serviceDetailsCart;
  final bool isEdit;

  OpenDynamicBottomSheetState({
    required this.questions,
    required this.serviceDetailsCart,
    this.isEdit = false,
  });

  @override
  List<Object> get props => [
        questions,
        serviceDetailsCart,
        isEdit,
      ];
}

class LoadingContinueServiceDetailsCart extends ServiceDetailsCartState {}

class SuccessContinueServiceDetailsCart extends ServiceDetailsCartState {
  final SubmitServiceDetailsCart submitServiceDetailsCart;
  final String message;

  SuccessContinueServiceDetailsCart({
    required this.submitServiceDetailsCart,
    required this.message,
  });
}

class ErrorContinueServiceDetailsCart extends ServiceDetailsCartState {
  final String errorMessage;

  ErrorContinueServiceDetailsCart({
    required this.errorMessage,
  });
}

class NavigateToCartScreenState extends ServiceDetailsCartState {
  final List<ServiceDetailsCart> servicesDetailsCart;
  final HomeService serviceDetails;

  NavigateToCartScreenState({
    required this.servicesDetailsCart,
    required this.serviceDetails,
  });
}

class ResetServicesDetailsCartState extends ServiceDetailsCartState {}
