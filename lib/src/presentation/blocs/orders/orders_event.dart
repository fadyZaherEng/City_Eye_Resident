part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class GetOrdersEvent extends OrdersEvent {
  final MyOrdersRequest myOrdersRequest;

  GetOrdersEvent({
    required this.myOrdersRequest,
  });
}

class OrdersSearchEvent extends OrdersEvent {
  final String value;

  OrdersSearchEvent({
    required this.value,
  });
}

class SelectOrderTypeEvent extends OrdersEvent {
  final bool isCurrent;

  SelectOrderTypeEvent({
    required this.isCurrent,
  });
}

class NavigateToPaymentDetailsEvent extends OrdersEvent {
  final int paymentId;

  NavigateToPaymentDetailsEvent({
    required this.paymentId,
  });
}

class RateOrderPressedEvent extends OrdersEvent {
  final Orders order;

  RateOrderPressedEvent({
    required this.order,
  });
}

class RateOrderEvent extends OrdersEvent {
  final Orders order;
  final double rate;
  final String comment;

  RateOrderEvent({
    required this.order,
    required this.rate,
    required this.comment,
  });
}

class CancelOrderPressedEvent extends OrdersEvent {
  final Orders order;

  CancelOrderPressedEvent({
    required this.order,
  });
}

class CancelOrderEvent extends OrdersEvent {
  final Orders order;
  final String reason;

  CancelOrderEvent({
    required this.order,
    required this.reason,
  });
}

class CommentOrderEvent extends OrdersEvent {
  final Orders order;

  CommentOrderEvent({
    required this.order,
  });
}

class NavigateBackEvent extends OrdersEvent {}

class ScrollToItemEvent extends OrdersEvent {
  final GlobalKey key;

  ScrollToItemEvent({required this.key});
}
