part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class GetPaymentsEvent extends PaymentEvent {}

class PaymentBackEvent extends PaymentEvent {}

class PaymentSearchEvent extends PaymentEvent {
  final String value;

  PaymentSearchEvent({
    required this.value,
  });
}

class PaymentPayNowEvent extends PaymentEvent {
  final Payment payment;

  PaymentPayNowEvent({
    required this.payment,
  });
}

class GetCompoundConfigurationEvent extends PaymentEvent {}

class PaymentDetailsEvent extends PaymentEvent {
  final Payment payment;

  PaymentDetailsEvent({
    required this.payment,
  });
}

class ShowPaymentMethodsBottomSheetEvent extends PaymentEvent {
  final Payment payment;

  ShowPaymentMethodsBottomSheetEvent({
    required this.payment,
  });
}

class OnSelectedPaymentMethodEvent extends PaymentEvent {
  final Payment payment;
  final PaymentRequestPaymentMethods paymentMethod;

  OnSelectedPaymentMethodEvent({
    required this.payment,
    required this.paymentMethod,
  });
}