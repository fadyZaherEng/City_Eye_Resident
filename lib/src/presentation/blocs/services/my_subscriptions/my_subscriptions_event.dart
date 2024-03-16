part of 'my_subscriptions_bloc.dart';

@immutable
abstract class MySubscriptionsEvent {}

class GetMySubscriptionsDataEvent extends MySubscriptionsEvent {}

class MySubscriptionsFloatingActionButtonEvent extends MySubscriptionsEvent {}

class ScrollToItemEvent extends MySubscriptionsEvent {
  final GlobalKey key;

  ScrollToItemEvent({required this.key});
}
