part of 'payment_bloc.dart';

@immutable
abstract class PaymentState extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class PaymentInitialState extends PaymentState {}

class GetPaymentsLoadingState extends PaymentState {}

class GetPaymentsSuccessState extends PaymentState {
  final List<Payment> payments;

  GetPaymentsSuccessState({required this.payments});
}

class GetPaymentsErrorState extends PaymentState {
  final String errorMessage;

  GetPaymentsErrorState({required this.errorMessage});
}

class PaymentBackState extends PaymentState {}

class PaymentSearchState extends PaymentState {
  final List<Payment> payments;

  PaymentSearchState({required this.payments});
}

class PaymentPayNowLoadingState extends PaymentState {}

class PaymentPayNowSuccessState extends PaymentState {
  final String link;

  PaymentPayNowSuccessState({
    required this.link,
  });
}

class PaymentPayNowErrorState extends PaymentState {
  final String errorMessage;

  PaymentPayNowErrorState({required this.errorMessage});
}

class GetCompoundConfigurationState extends PaymentState {
  final CompoundConfiguration compoundConfiguration;

  GetCompoundConfigurationState({
    required this.compoundConfiguration,
  });
}

class PaymentDetailsState extends PaymentState {
  final Payment payment;

  PaymentDetailsState({
    required this.payment,
  });
}

class ShowPaymentMethodsBottomSheetState extends PaymentState {
  final Payment payment;

  ShowPaymentMethodsBottomSheetState({
    required this.payment,
  });
}

class OnSelectedPaymentMethodState extends PaymentState {
  final Payment payment;
  final List<Payment> payments;
  final PaymentRequestPaymentMethods paymentMethod;

  OnSelectedPaymentMethodState({
    required this.payment,
    required this.payments,
    required this.paymentMethod,
  });
}