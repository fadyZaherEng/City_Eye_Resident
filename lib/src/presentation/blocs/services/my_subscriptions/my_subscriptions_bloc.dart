import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/services/my_subscription.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/usecase/get_local_compound_configuration_use_case.dart';
import 'package:city_eye/src/domain/usecase/my_subscription/get_my_subscription_data_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_subscriptions_event.dart';

part 'my_subscriptions_state.dart';

class MySubscriptionsBloc
    extends Bloc<MySubscriptionsEvent, MySubscriptionsState> {
  final GetMySubscriptionDataUseCase _getMySubscriptionDataUseCase;
  final GetLocalCompoundConfigurationUseCase
      _getLocalCompoundConfigurationUseCase;

  MySubscriptionsBloc(
    this._getMySubscriptionDataUseCase,
    this._getLocalCompoundConfigurationUseCase,
  ) : super(ShowMySubscriptionsSkeletonState()) {
    on<GetMySubscriptionsDataEvent>(_onGetMySubscriptionsDataEvent);
    on<MySubscriptionsFloatingActionButtonEvent>(
        _onGMySubscriptionsFloatingActionButtonEvent);
    on<ScrollToItemEvent>(_onScrollToItemEvent);
  }

  FutureOr<void> _onGetMySubscriptionsDataEvent(
      GetMySubscriptionsDataEvent event,
      Emitter<MySubscriptionsState> emit) async {
    emit(ShowMySubscriptionsSkeletonState());
    final mySubscriptionState = await _getMySubscriptionDataUseCase();
    if (mySubscriptionState is DataSuccess<List<MySubscription>>) {
      var mySubscription = mySubscriptionState.data ?? [];

      for (var i = 0; i < mySubscription.length; i++) {
        GlobalKey key = GlobalKey();
        mySubscription[i] = mySubscription[i].copyWith(key: key);
      }

      emit(GetMySubscriptionsDataState(
          mySubscription: (mySubscription).reversed.toList(),
          compoundConfiguration: _getLocalCompoundConfigurationUseCase()));
    } else if (mySubscriptionState is DataFailed) {
      emit(GetMySubscriptionsDataErrorState(
          message: mySubscriptionState.message ?? ""));
    }
  }

  FutureOr<void> _onScrollToItemEvent(ScrollToItemEvent event, Emitter<MySubscriptionsState> emit) {
    emit(ScrollToItemState(key: event.key));
  }
}

FutureOr<void> _onGMySubscriptionsFloatingActionButtonEvent(
    MySubscriptionsFloatingActionButtonEvent event,
    Emitter<MySubscriptionsState> emit) {
  emit(MySubscriptionsFloatingActionButtonState());
}
