part of 'my_subscriptions_bloc.dart';

@immutable
abstract class MySubscriptionsState {}

class MySubscriptionsInitial extends MySubscriptionsState {}

class ShowMySubscriptionsSkeletonState extends MySubscriptionsState {}

class MySubscriptionsFloatingActionButtonState extends MySubscriptionsState {}

class GetMySubscriptionsDataState extends MySubscriptionsState {
  final List<MySubscription> mySubscription;
  final CompoundConfiguration compoundConfiguration;

  GetMySubscriptionsDataState({
    required this.mySubscription,
    required this.compoundConfiguration,
  });
}

class GetMySubscriptionsDataErrorState extends MySubscriptionsState {
  final String message;

  GetMySubscriptionsDataErrorState({required this.message});
}

class ScrollToItemState extends MySubscriptionsState {
  final GlobalKey key;

  ScrollToItemState({required this.key});
}
