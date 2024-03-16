part of 'my_cart_bloc.dart';

abstract class MyCartEvent {}

class GetCompoundConfigurationEvent extends MyCartEvent {}

class ApplyCouponClickEvent extends MyCartEvent {
  final String couponCode;

  ApplyCouponClickEvent({required this.couponCode});
}

class CheckNowClickEvent extends MyCartEvent {
  final List<ServiceDetailsCart> servicesDetailsCart;

  CheckNowClickEvent({
    required this.servicesDetailsCart,
  });
}
