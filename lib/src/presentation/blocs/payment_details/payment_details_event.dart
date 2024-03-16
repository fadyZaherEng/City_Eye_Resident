part of 'payment_details_bloc.dart';

abstract class PaymentDetailsEvent {}

class GetPaymentDetailsEvent extends PaymentDetailsEvent {
  final int paymentId;

  GetPaymentDetailsEvent({
    required this.paymentId,
  });
}

class ShowPaymentMethodsBottomSheetEvent extends PaymentDetailsEvent {
  final List<PaymentRequestPaymentMethods> paymentMethods;

  ShowPaymentMethodsBottomSheetEvent({
    required this.paymentMethods,
  });
}

class OnSelectedPaymentMethodEvent extends PaymentDetailsEvent {
  final Payment payment;
  final PaymentRequestPaymentMethods paymentMethod;

  OnSelectedPaymentMethodEvent({
    required this.payment,
    required this.paymentMethod,
  });
}

class PayClickedEvent extends PaymentDetailsEvent {
  final Payment payment;
  final PaymentRequestPaymentMethods paymentMethod;

  PayClickedEvent({
    required this.payment,
    required this.paymentMethod,
  });
}
