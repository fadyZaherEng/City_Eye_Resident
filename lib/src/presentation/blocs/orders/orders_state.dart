part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class OrdersInitial extends OrdersState {}

class ShowSkeletonState extends OrdersState {}

class ShowLoadingState extends OrdersState {}

class HideLoadingState extends OrdersState {}

class GetOrdersSuccessState extends OrdersState {
  final List<Orders> orders;

  GetOrdersSuccessState({
    required this.orders,
  });
}

class GetOrdersErrorState extends OrdersState {
  final String message;

  GetOrdersErrorState({
    required this.message,
  });
}

class SelectOrderTypeState extends OrdersState {
  final bool isCurrent;

  SelectOrderTypeState({
    required this.isCurrent,
  });
}

class OrdersSearchState extends OrdersState {
  final List<Orders> orders;

  OrdersSearchState({
    required this.orders,
  });
}

class PayOrderSuccessState extends OrdersState {
  final String paymentUrl;

  PayOrderSuccessState({
    required this.paymentUrl,
  });
}

class PayOrderErrorState extends OrdersState {
  final String errorMessage;

  PayOrderErrorState({
    required this.errorMessage,
  });
}

class OpenRateBottomSheetState extends OrdersState {
  final Orders order;

  OpenRateBottomSheetState({
    required this.order,
  });
}

class RateOrderSuccessState extends OrdersState {
  final String message;

  RateOrderSuccessState({
    required this.message,
  });
}

class RateOrderErrorState extends OrdersState {
  final String errorMessage;

  RateOrderErrorState({
    required this.errorMessage,
  });
}

class OpenCancelBottomSheetState extends OrdersState {
  final Orders order;

  OpenCancelBottomSheetState({
    required this.order,
  });
}

class NavigateToCommentScreenState extends OrdersState {
  final Orders order;

  NavigateToCommentScreenState({
    required this.order,
  });
}

class CancelOrderSuccessState extends OrdersState {
  final String message;

  CancelOrderSuccessState({
    required this.message,
  });
}

class CancelOrderErrorState extends OrdersState {
  final String errorMessage;

  CancelOrderErrorState({
    required this.errorMessage,
  });
}

class NavigateBackState extends OrdersState {}

class ScrollToItemState extends OrdersState {
  final GlobalKey key;

  ScrollToItemState({required this.key});
}


class NavigateToPaymentDetailsState extends OrdersState {
  final int paymentId;

  NavigateToPaymentDetailsState({
    required this.paymentId,
  });
}