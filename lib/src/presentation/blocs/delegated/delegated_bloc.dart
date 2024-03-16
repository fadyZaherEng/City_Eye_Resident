import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/delegated/request/delete_delegated_request.dart';
import 'package:city_eye/src/domain/entities/delegated/delegated.dart';
import 'package:city_eye/src/domain/usecase/delegated/delete_delegated_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/get_delegated_data_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delegated_event.dart';

part 'delegated_state.dart';

class DelegatedBloc extends Bloc<DelegatedEvent, DelegatedState> {
  final GetDelegatedDataUseCase _getEventsUseCase;
  final DeleteDelegatedUseCase _deleteDelegatedUseCase;

  DelegatedBloc(
    this._getEventsUseCase,
    this._deleteDelegatedUseCase,
  ) : super(DelegatedInitialState()) {
    on<BackDelegatedEvent>(_onBackDelegatedEvent);
    on<AddDelegatedEvent>(_onAddDelegatedEvent);
    on<DeactivateEvent>(_onDeactivateEvent);
    on<EditDelegatedEvent>(_onEditDelegatedEvent);
    on<DelegatedCallPhoneNumberEvent>(_onDelegatedCallPhoneNumberEvent);
    on<GetDelegatedDataEvent>(_onGetDelegatedDataEvent);
  }

  bool isReloadList = false;

  FutureOr<void> _onGetDelegatedDataEvent(
      GetDelegatedDataEvent event, Emitter<DelegatedState> emit) async {
    emit(ShowSkeletonState());
    DataState dataState = await _getEventsUseCase();
    if (dataState is DataSuccess) {
      emit(GetDelegatedDataSuccessState(
          delegatedList: dataState.data as List<Delegated>));
    } else {
      emit(GetDelegatedDataErrorState(errorMessage: dataState.message ?? ""));
    }
  }

  FutureOr<void> _onBackDelegatedEvent(
      BackDelegatedEvent event, Emitter<DelegatedState> emit) {
    emit(BackDelegatedState());
  }

  FutureOr<void> _onAddDelegatedEvent(
      AddDelegatedEvent event, Emitter<DelegatedState> emit) {
    emit(AddDelegatedState());
  }

  FutureOr<void> _onDeactivateEvent(
      DeactivateEvent event, Emitter<DelegatedState> emit) async {
    emit(ShowLoadingState());
    DataState dataState = await _deleteDelegatedUseCase(DeleteDelegatedRequest(
        id: event.delegated.id, isEnabled: !event.delegated.isEnabled));
    if (dataState is DataSuccess) {
      for (int i = 0; i < event.delegations.length; i++) {
        if (event.delegations[i].id == event.delegated.id) {
          event.delegations[i] = event.delegated.copyWith(
            isEnabled: !event.delegated.isEnabled,
          );
          break;
        }
      }
      emit(DeactivateSuccessState(
        delegated: event.delegated,
        message: dataState.message ?? "",
      ));
    } else {
      emit(DeactivateErrorState(errorMessage: dataState.message ?? ""));
    }
    emit(HideLoadingState());
  }

  FutureOr<void> _onEditDelegatedEvent(
      EditDelegatedEvent event, Emitter<DelegatedState> emit) {
    emit(EditDelegatedState(
      delegated: event.delegated,
    ));
  }

  FutureOr<void> _onDelegatedCallPhoneNumberEvent(
      DelegatedCallPhoneNumberEvent event, Emitter<DelegatedState> emit) {
    emit(DelegatedCallPhoneNumberState(
      delegated: event.delegated,
    ));
  }
}
