part of 'payment_details_bloc.dart';

abstract class PaymentDetailsState {}

class ShowSkeletonState extends PaymentDetailsState {}

class GetPaymentDetailsSuccessState extends PaymentDetailsState {
  final Payment payment;

  GetPaymentDetailsSuccessState({
    required this.payment,
  });
}

class GetPaymentDetailsErrorState extends PaymentDetailsState {
  final String errorMessage;

  GetPaymentDetailsErrorState({
    required this.errorMessage,
  });
}

class ShowPaymentMethodsBottomSheetState extends PaymentDetailsState {
  final List<PaymentRequestPaymentMethods> paymentMethods;

  ShowPaymentMethodsBottomSheetState({
    required this.paymentMethods,
  });
}

class OnSelectedPaymentMethodState extends PaymentDetailsState {
  final Payment payment;
  final PaymentRequestPaymentMethods paymentMethod;

  OnSelectedPaymentMethodState({
    required this.payment,
    required this.paymentMethod,
  });
}

class PaymentPayNowLoadingState extends PaymentDetailsState {}

class PaymentPayNowSuccessState extends PaymentDetailsState {
  final String link;

  PaymentPayNowSuccessState({
    required this.link,
  });
}

class PaymentPayNowErrorState extends PaymentDetailsState {
  final String errorMessage;

  PaymentPayNowErrorState({required this.errorMessage});
}