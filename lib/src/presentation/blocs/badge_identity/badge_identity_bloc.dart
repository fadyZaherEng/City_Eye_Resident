import 'dart:async';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/badge_identity/badge_identity.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/usecase/badge_identity/get_badge_identity_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_local_compound_configuration_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'badge_identity_event.dart';

part 'badge_identity_state.dart';

class BadgeIdentityBloc extends Bloc<BadgeIdentityEvent, BadgeIdentityState> {
  final GetLocalCompoundConfigurationUseCase
      _getLocalCompoundConfigurationUseCase;
  final GetBadgeIdentityUseCase _getBadgeIdentityUseCase;

  BadgeIdentityBloc(
    this._getLocalCompoundConfigurationUseCase,
    this._getBadgeIdentityUseCase,
  ) : super(ShowSkeletonState()) {
    on<GetCompoundConfigurationEvent>(_onGetCompoundConfigurationEvent);
    on<GetBadgeIdentityEvent>(_onGetBadgeIdentityEvent);
    on<StartCounterEvent>(_onStartCounterEvent);
    on<EndCounterEvent>(_onEndCounterEvent);
  }

  FutureOr<void> _onGetCompoundConfigurationEvent(
      GetCompoundConfigurationEvent event, Emitter<BadgeIdentityState> emit) {
    emit(GetCompoundConfigurationState(
        compoundConfiguration: _getLocalCompoundConfigurationUseCase()));
  }

  FutureOr<void> _onGetBadgeIdentityEvent(
      GetBadgeIdentityEvent event, Emitter<BadgeIdentityState> emit) async {
    if (event.isShowSkeleton) {
      emit(ShowSkeletonState());
    } else {
      emit(ShowLoadingState());
    }

    final dataState = await _getBadgeIdentityUseCase();

    if (dataState is DataSuccess) {
      emit(GetBadgeIdentitySuccessState(
        badgeIdentity: dataState.data ?? const BadgeIdentity(),
      ));
    } else {
      emit(GetBadgeIdentityErrorState(
        errorMessage: dataState.message ?? "",
      ));
    }

    if (!event.isShowSkeleton) {
      emit(HideLoadingState());
    }
  }

  FutureOr<void> _onStartCounterEvent(
      StartCounterEvent event, Emitter<BadgeIdentityState> emit) {
    emit(StartCounterState());
  }

  FutureOr<void> _onEndCounterEvent(
      EndCounterEvent event, Emitter<BadgeIdentityState> emit) {
    emit(EndCounterState());
  }
}
