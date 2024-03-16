part of 'service_details_cart_bloc.dart';

abstract class ServiceDetailsCartEvent extends Equatable {
  const ServiceDetailsCartEvent();

  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class ResetServiceDetailsCartEvent extends ServiceDetailsCartEvent {}

class GetServiceDetailsCartEvent extends ServiceDetailsCartEvent {
  final int serviceId;

  const GetServiceDetailsCartEvent({
    required this.serviceId,
  });
}

class ChangeServiceStateEvent extends ServiceDetailsCartEvent {
  final List<ServiceDetailsCart> servicesDetailsCart;
  final ServiceDetailsCart selectedServiceDetailsCart;

  const ChangeServiceStateEvent({
    required this.servicesDetailsCart,
    required this.selectedServiceDetailsCart,
  });
}

class AddServiceCountEvent extends ServiceDetailsCartEvent {
  final List<ServiceDetailsCart> servicesDetailsCart;
  final ServiceDetailsCart selectedServiceDetailsCart;

  const AddServiceCountEvent({
    required this.servicesDetailsCart,
    required this.selectedServiceDetailsCart,
  });
}

class MinusServiceCountEvent extends ServiceDetailsCartEvent {
  final List<ServiceDetailsCart> servicesDetailsCart;
  final ServiceDetailsCart selectedServiceDetailsCart;

  const MinusServiceCountEvent({
    required this.servicesDetailsCart,
    required this.selectedServiceDetailsCart,
  });
}

class GetTotalPriceEvent extends ServiceDetailsCartEvent {
  final List<ServiceDetailsCart> servicesDetailsCart;

  const GetTotalPriceEvent({
    required this.servicesDetailsCart,
  });
}

class CheckIsThereItemInCartEvent extends ServiceDetailsCartEvent {
  final double totalPrice;

  const CheckIsThereItemInCartEvent({
    required this.totalPrice,
  });
}

class NavigateBackEvent extends ServiceDetailsCartEvent {}

class ContinueServiceDetailsCartEvent extends ServiceDetailsCartEvent {
  final List<ServiceDetailsCart> servicesDetailsCart;
  final HomeService serviceDetails;

  const ContinueServiceDetailsCartEvent({
    required this.servicesDetailsCart,
    required this.serviceDetails,
  });
}

class ResetServicesDetailsCart extends ServiceDetailsCartEvent{}

class OpenDynamicQuestionBottomSheetEvent extends ServiceDetailsCartEvent{
  final List<PageField> questions;
  final ServiceDetailsCart serviceDetailsCart;

  const OpenDynamicQuestionBottomSheetEvent({
    required this.questions,
    required this.serviceDetailsCart,
  });
}