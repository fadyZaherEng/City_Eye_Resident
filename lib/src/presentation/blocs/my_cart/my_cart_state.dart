part of 'my_cart_bloc.dart';

abstract class MyCartState {}

class MyCartInitial extends MyCartState {}

class ShowLoadingState extends MyCartState {}

class HideLoadingState extends MyCartState {}

class MyCartSkeletonState extends MyCartState {}

class CompoundConfigurationSuccessState extends MyCartState {
  final CompoundConfiguration compoundConfiguration;

  CompoundConfigurationSuccessState({required this.compoundConfiguration});
}

class CompoundConfigurationFailedState extends MyCartState {
  final String errorMessage;

  CompoundConfigurationFailedState({required this.errorMessage});
}

class MyCartApplyCouponSuccessState extends MyCartState {
  final String message;

  MyCartApplyCouponSuccessState({required this.message});
}

class MyCartApplyCouponFailedState extends MyCartState {
  final String errorMessage;

  MyCartApplyCouponFailedState({required this.errorMessage});
}

class MyCartCheckNowSuccessState extends MyCartState {
  final String message;

  MyCartCheckNowSuccessState({required this.message});
}

class MyCartCheckNowFailedState extends MyCartState {
  final String errorMessage;

  MyCartCheckNowFailedState({required this.errorMessage});
}