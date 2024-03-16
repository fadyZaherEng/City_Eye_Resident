import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/request/payment_request.dart';
import 'package:city_eye/src/domain/entities/payment/payment.dart';
import 'package:city_eye/src/domain/entities/payment/payment_request_payment_methods.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/usecase/get_local_compound_configuration_use_case.dart';
import 'package:city_eye/src/domain/usecase/payment/get_payment_url_use_case.dart';
import 'package:city_eye/src/domain/usecase/payment/get_payments_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_event.dart';

part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final GetPaymentsUseCase _getPaymentsUseCase;
  final GetPaymentUrlUseCase _getPaymentUrlUseCase;
  final GetLocalCompoundConfigurationUseCase
      _getLocalCompoundConfigurationUseCase;
  List<Payment> _paymentsFilter = [];
  List<Payment> _payments = [];

  PaymentBloc(
    this._getPaymentsUseCase,
    this._getPaymentUrlUseCase,
    this._getLocalCompoundConfigurationUseCase,
  ) : super(PaymentInitialState()) {
    on<GetCompoundConfigurationEvent>(_onGetCompoundConfigurationEvent);
    on<GetPaymentsEvent>(_onGetPaymentsEvent);
    on<PaymentBackEvent>(_onPaymentBackEvent);
    on<PaymentSearchEvent>(_onPaymentSearchEvent);
    on<PaymentPayNowEvent>(_onPaymentPayNowEvent);
    on<PaymentDetailsEvent>(_onPaymentDetailsEvent);
    on<ShowPaymentMethodsBottomSheetEvent>(
        _onShowPaymentMethodsBottomSheetEvent);
    on<OnSelectedPaymentMethodEvent>(_onOnSelectedPaymentMethodEvent);
  }

  FutureOr<void> _onGetCompoundConfigurationEvent(
      GetCompoundConfigurationEvent event, Emitter<PaymentState> emit) {
    emit(GetCompoundConfigurationState(
      compoundConfiguration: _getLocalCompoundConfigurationUseCase(),
    ));
  }

  FutureOr<void> _onGetPaymentsEvent(
      GetPaymentsEvent event, Emitter<PaymentState> emit) async {
    emit(GetPaymentsLoadingState());
    final paymentsState = await _getPaymentsUseCase();
    if (paymentsState is DataSuccess<List<Payment>>) {
      final payments = paymentsState.data ?? [];
      _payments = payments;
      emit(GetPaymentsSuccessState(payments: payments));
    } else if (paymentsState is DataFailed) {
      emit(GetPaymentsErrorState(errorMessage: paymentsState.message ?? ""));
    }
  }

  FutureOr<void> _onPaymentBackEvent(
      PaymentBackEvent event, Emitter<PaymentState> emit) {
    emit(PaymentBackState());
  }

  FutureOr<void> _onPaymentSearchEvent(
      PaymentSearchEvent event, Emitter<PaymentState> emit) {
    _paymentsFilter = _payments;
    _paymentsFilter = _paymentsFilter
        .where((element) =>
            element.title.toLowerCase().contains(event.value.toLowerCase()) ||
            element.description
                .toUpperCase()
                .contains(event.value.toUpperCase()) ||
            element.createDate
                .toUpperCase()
                .contains(event.value.toUpperCase()) ||
            element.paymentMethod.name
                .toUpperCase()
                .contains(event.value.toUpperCase()))
        .toList();
    emit(PaymentSearchState(
      payments: _paymentsFilter,
    ));
  }

  FutureOr<void> _onPaymentPayNowEvent(
      PaymentPayNowEvent event, Emitter<PaymentState> emit) async {
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

  FutureOr<void> _onPaymentDetailsEvent(
      PaymentDetailsEvent event, Emitter<PaymentState> emit) {
    emit(PaymentDetailsState(payment: event.payment));
  }

  FutureOr<void> _onShowPaymentMethodsBottomSheetEvent(
      ShowPaymentMethodsBottomSheetEvent event, Emitter<PaymentState> emit) {
    emit(ShowPaymentMethodsBottomSheetState(payment: event.payment));
  }

  FutureOr<void> _onOnSelectedPaymentMethodEvent(
      OnSelectedPaymentMethodEvent event, Emitter<PaymentState> emit) {
    for (int i = 0; i < _payments.length; i++) {
      if (_payments[i].id == event.payment.id) {
        for (int j = 0;
            j < _payments[i].paymentRequestPaymentMethods.length;
            j++) {
          if (_payments[i].paymentRequestPaymentMethods[j].id ==
              event.paymentMethod.id) {
            _payments[i].paymentRequestPaymentMethods[j] =
                _payments[i].paymentRequestPaymentMethods[j].copyWith(
                      isSelected: true,
                    );
          } else {
            _payments[i].paymentRequestPaymentMethods[j] =
                _payments[i].paymentRequestPaymentMethods[j].copyWith(
                      isSelected: false,
                    );
          }
        }
      }
    }

    for (int i = 0; i < event.payment.paymentRequestPaymentMethods.length; i++) {
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
        payment: event.payment,
        payments: _payments,
        paymentMethod: event.paymentMethod));
  }
}
