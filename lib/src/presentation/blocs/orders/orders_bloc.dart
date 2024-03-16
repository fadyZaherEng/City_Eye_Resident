import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/my_orders_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/order_cancel_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/order_rating_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/payment_url_request.dart';
import 'package:city_eye/src/domain/entities/support/orders.dart';
import 'package:city_eye/src/domain/entities/support/payment_url.dart';
import 'package:city_eye/src/domain/usecase/get_my_order_payment_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_my_orders_use_case.dart';
import 'package:city_eye/src/domain/usecase/my_order_cancel_use_case.dart';
import 'package:city_eye/src/domain/usecase/send_order_rating_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'orders_event.dart';

part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetMyOrdersUseCase _getMyOrdersUseCase;
  final MyOrderCancelUseCase _myOrderCancelUseCase;
  final GetMyOrdersPaymentUseCase _getMyOrdersPaymentUseCase;
  final SendOrderRatingUseCase _sendOrderRatingUseCase;

  List<Orders> _orders = [];

  OrdersBloc(
    this._getMyOrdersUseCase,
    this._myOrderCancelUseCase,
    this._getMyOrdersPaymentUseCase,
    this._sendOrderRatingUseCase,
  ) : super(OrdersInitial()) {
    on<GetOrdersEvent>(_onGetOrdersEvent);
    on<SelectOrderTypeEvent>(_onSelectOrderTypeEvent);
    on<OrdersSearchEvent>(_onOrdersSearchEvent);
    on<NavigateToPaymentDetailsEvent>(_onNavigateToPaymentDetailsEvent);
    on<CancelOrderPressedEvent>(_onCancelOrderPressedEvent);
    on<RateOrderPressedEvent>(_onRateOrderPressedEvent);
    on<CommentOrderEvent>(_onCommentOrderEvent);
    on<NavigateBackEvent>(_onNavigateBackEvent);
    on<CancelOrderEvent>(_onCancelOrderEvent);
    on<RateOrderEvent>(_onRateOrderEvent);
    on<ScrollToItemEvent>(_onScrollToItemEvent);
  }

  FutureOr<void> _onGetOrdersEvent(
      GetOrdersEvent event, Emitter<OrdersState> emit) async {
    emit(ShowSkeletonState());
    DataState dataState = await _getMyOrdersUseCase(event.myOrdersRequest);
    if (dataState is DataSuccess) {
      _orders = dataState.data as List<Orders>;

      for (int i = 0; i < _orders.length; i++) {
        GlobalKey key = GlobalKey();
        _orders[i] = _orders[i].copyWith(key: key);
      }
      emit(GetOrdersSuccessState(orders: _orders));
    } else {
      emit(GetOrdersErrorState(message: dataState.message ?? ""));
    }
  }

  FutureOr<void> _onSelectOrderTypeEvent(
      SelectOrderTypeEvent event, Emitter<OrdersState> emit) {
    emit(SelectOrderTypeState(isCurrent: event.isCurrent));
  }

  FutureOr<void> _onOrdersSearchEvent(
      OrdersSearchEvent event, Emitter<OrdersState> emit) {
    List<Orders> orders = _orders
        .where((element) =>
            element.id.toString().contains(event.value) ||
            element.category.name
                .toLowerCase()
                .contains(event.value.trim().toLowerCase()))
        .toList();
    emit(OrdersSearchState(orders: orders));
  }

  FutureOr<void> _onNavigateToPaymentDetailsEvent(
      NavigateToPaymentDetailsEvent event, Emitter<OrdersState> emit) async {
    // emit(ShowLoadingState());
    //
    // DataState dataState = await _getMyOrdersPaymentUseCase(
    //     PaymentUrlRequest(requestId: event.paymentId));
    // if (dataState is DataSuccess) {
    //   var response = dataState.data as PaymentUrl;
    //   emit(PayOrderSuccessState(paymentUrl: response.paymentUrl));
    // } else {
    //   emit(PayOrderErrorState(errorMessage: dataState.message ?? ""));
    // }

   emit(NavigateToPaymentDetailsState(
     paymentId: event.paymentId,
       ));
    // emit(HideLoadingState());
  }

  FutureOr<void> _onCancelOrderPressedEvent(
      CancelOrderPressedEvent event, Emitter<OrdersState> emit) {
    emit(OpenCancelBottomSheetState(order: event.order));
  }

  FutureOr<void> _onRateOrderPressedEvent(
      RateOrderPressedEvent event, Emitter<OrdersState> emit) {
    emit(OpenRateBottomSheetState(order: event.order));
  }

  FutureOr<void> _onCommentOrderEvent(
      CommentOrderEvent event, Emitter<OrdersState> emit) {
    emit(NavigateToCommentScreenState(order: event.order));
  }

  FutureOr<void> _onNavigateBackEvent(
      NavigateBackEvent event, Emitter<OrdersState> emit) {
    emit(NavigateBackState());
  }

  FutureOr<void> _onCancelOrderEvent(
      CancelOrderEvent event, Emitter<OrdersState> emit) async {
    emit(ShowLoadingState());

    DataState dataState = await _myOrderCancelUseCase(
        OrderCancelRequest(requestId: event.order.id, statusId: 5));

    if (dataState is DataSuccess) {
      emit(CancelOrderSuccessState(message: dataState.message ?? ""));
    } else {
      emit(CancelOrderErrorState(errorMessage: dataState.message ?? ""));
    }

    emit(HideLoadingState());
  }

  FutureOr<void> _onRateOrderEvent(
      RateOrderEvent event, Emitter<OrdersState> emit) async {
    emit(ShowLoadingState());

    DataState dataState = await _sendOrderRatingUseCase(OrderRatingRequest(
      id: event.order.id,
      ratingValue: event.rate.toInt(),
      ratingComment: event.comment,
    ));
    if (dataState is DataSuccess) {
      emit(RateOrderSuccessState(message: dataState.message ?? ""));
    } else {
      emit(RateOrderErrorState(errorMessage: dataState.message ?? ""));
    }

    emit(HideLoadingState());
  }

  FutureOr<void> _onScrollToItemEvent(ScrollToItemEvent event, Emitter<OrdersState> emit) {
    emit(ScrollToItemState(key: event.key));
  }
}
