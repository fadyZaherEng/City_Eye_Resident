import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/service_details/service_details_cart.dart';
import 'package:city_eye/src/domain/entities/service_details/submit_service_details_cart.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/usecase/get_local_compound_configuration_use_case.dart';
import 'package:city_eye/src/domain/usecase/submit_service_details_cart_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_cart_event.dart';

part 'my_cart_state.dart';

class MyCartBloc extends Bloc<MyCartEvent, MyCartState> {
  final SubmitServiceDetailsCartUseCase _submitServiceDetailsCartUseCase;
  final GetLocalCompoundConfigurationUseCase _getLocalCompoundConfigurationUseCase;

  MyCartBloc(
    this._submitServiceDetailsCartUseCase,
    this._getLocalCompoundConfigurationUseCase,
  ) : super(MyCartInitial()) {
    on<GetCompoundConfigurationEvent>(_onGetCompoundConfigurationEvent);
    on<ApplyCouponClickEvent>(_onApplyCouponClickEvent);
    on<CheckNowClickEvent>(_onCheckNowClickEvent);
  }

  FutureOr<void> _onGetCompoundConfigurationEvent(
      GetCompoundConfigurationEvent event, Emitter<MyCartState> emit) async {
    emit(MyCartSkeletonState());
    CompoundConfiguration compoundConfiguration = await _getLocalCompoundConfigurationUseCase();
    emit(CompoundConfigurationSuccessState(
        compoundConfiguration: compoundConfiguration));
  }

  FutureOr<void> _onApplyCouponClickEvent(
      ApplyCouponClickEvent event, Emitter<MyCartState> emit) async {
    emit(ShowLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(MyCartApplyCouponSuccessState(message: 'Coupon applied successfully'));

    emit(HideLoadingState());
  }

  FutureOr<void> _onCheckNowClickEvent(
      CheckNowClickEvent event, Emitter<MyCartState> emit) async {
    emit(ShowLoadingState());
    final submitServiceDetailsCartState =
        await _submitServiceDetailsCartUseCase(
            event.servicesDetailsCart.mapToSubmitServiceDetailsCartRequests());
    if (submitServiceDetailsCartState
        is DataSuccess<SubmitServiceDetailsCart>) {
      emit(MyCartCheckNowSuccessState(
          message: submitServiceDetailsCartState.message ?? ""));
    } else if (submitServiceDetailsCartState is DataFailed) {
      emit(
        MyCartCheckNowFailedState(
            errorMessage: submitServiceDetailsCartState.message ?? ""),
      );
    }

    emit(HideLoadingState());
  }
}
