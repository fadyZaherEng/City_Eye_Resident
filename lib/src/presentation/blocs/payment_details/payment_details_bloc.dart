import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/request/payment_details_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/request/payment_request.dart';
import 'package:city_eye/src/domain/entities/payment/payment.dart';
import 'package:city_eye/src/domain/entities/payment/payment_request_payment_methods.dart';
import 'package:city_eye/src/domain/usecase/payment/get_payment_details_use_case.dart';
import 'package:city_eye/src/domain/usecase/payment/get_payment_url_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_details_event.dart';

part 'payment_details_state.dart';

class PaymentDetailsBloc
    extends Bloc<PaymentDetailsEvent, PaymentDetailsState> {
  final GetPaymentDetailsUseCase _getPaymentDetailsUseCase;
  final GetPaymentUrlUseCase _getPaymentUrlUseCase;

  PaymentDetailsBloc(
    this._getPaymentDetailsUseCase,
    this._getPaymentUrlUseCase,
  ) : super(ShowSkeletonState()) {
    on<GetPaymentDetailsEvent>(_onGetPaymentDetailsEvent);
    on<ShowPaymentMethodsBottomSheetEvent>(
        _onShowPaymentMethodsBottomSheetEvent);
    on<OnSelectedPaymentMethodEvent>(_onOnSelectedPaymentMethodEvent);
    on<PayClickedEvent>(_onPayClickedEvent);
  }

  FutureOr<void> _onGetPaymentDetailsEvent(
      GetPaymentDetailsEvent event, Emitter<PaymentDetailsState> emit) async {
    emit(ShowSkeletonState());
    final paymentsState = await _getPaymentDetailsUseCase(
        PaymentDetailsRequest(invoiceId: event.paymentId));
    if (paymentsState is DataSuccess) {
      emit(GetPaymentDetailsSuccessState(
          payment: paymentsState.data ?? const Payment()));
    } else if (paymentsState is DataFailed) {
      emit(GetPaymentDetailsErrorState(
          errorMessage: paymentsState.message ?? ""));
    }
  }

  FutureOr<void> _onShowPaymentMethodsBottomSheetEvent(
      ShowPaymentMethodsBottomSheetEvent event,
      Emitter<PaymentDetailsState> emit) {
    emit(ShowPaymentMethodsBottomSheetState(
        paymentMethods: event.paymentMethods));
  }

  FutureOr<void> _onOnSelectedPaymentMethodEvent(
      OnSelectedPaymentMethodEvent event, Emitter<PaymentDetailsState> emit) {
    for (int i = 0;
        i < event.payment.paymentRequestPaymentMethods.length;
        i++) {
      if (event.payment.paymentRequestPaymentMethods[i].id ==
          event.paymentMethod.id) {
        event.payment.paymentRequestPaymentMethods[i] =
            event.payment.paymentRequestPaymentMethods[i].copyWith(
          isSelected: true,
        );
      } else {
        event.payment.paymentRequestPaymentMethods[i] =
            event.payment.paymentRequestPaymentMethods[i].copyWith(
          isSelected: false,
        );
      }
    }

    emit(OnSelectedPaymentMethodState(
        payment: event.payment, paymentMethod: event.paymentMethod));
  }

  FutureOr<void> _onPayClickedEvent(
      PayClickedEvent event, Emitter<PaymentDetailsState> emit) async {
    emit(PaymentPayNowLoadingState());
    final paymentUrlState = await _getPaymentUrlUseCase(
        PaymentRequest(paymentId: event.payment.id));
    if (paymentUrlState is DataSuccess<String>) {
      emit(PaymentPayNowSuccessState(link: paymentUrlState.data ?? ""));
    } else if (paymentUrlState is DataFailed) {
      emit(
          PaymentPayNowErrorState(errorMessage: paymentUrlState.message ?? ""));
    }
  }
}
