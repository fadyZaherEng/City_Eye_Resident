import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/convert_string_to_date_format.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/deactivate_qr_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/qr_history_request.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history.dart';
import 'package:city_eye/src/domain/usecase/qr/change_qr_activation_state_usecase.dart';
import 'package:city_eye/src/domain/usecase/qr_history/change_enabled_status_qr_item_use_case.dart';
import 'package:city_eye/src/domain/usecase/qr/get_qr_history_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  List<QrHistory> _qrHistory = [];
  List<QrHistory> _searchedQrHistory = [];

  final GetQrHistoryUseCase _getQrHistoryUseCase;
  final ChangeQrActivationStatusUseCase _deactivateQrHistoryUseCase;
  final ChangeEnabledStatusQrItemUseCase _changeEnabledStatusQrItemUseCase;

  HistoryBloc(
    this._getQrHistoryUseCase,
    this._deactivateQrHistoryUseCase,
    this._changeEnabledStatusQrItemUseCase,
  ) : super(HistoryInitialState()) {
    on<GetCurrentHistoryEvent>(_onGetCurrentHistoryEvent);
    on<GetPreviousHistoryEvent>(_onGetPreviousHistoryEvent);
    on<QrHistorySearchEvent>(_onHistorySearchEvent);
    on<HistoryDeactivateEvent>(_onHistoryDeactivateEvent);
    on<HistoryActivateEvent>(_onHistoryActivateEvent);
    on<HistoryBackEvent>(_onHistoryBackEvent);
    on<SelectQrTypeEvent>(_onSelectQrTypeEvent);
  }

  FutureOr<void> _onGetCurrentHistoryEvent(
      GetCurrentHistoryEvent event, Emitter<HistoryState> emit) async {
    emit(CurrentQrHistoryLoadingState());
    final historyState =
        await _getQrHistoryUseCase(const QrHistoryRequest(isStatus: true));
    if (historyState is DataSuccess<List<QrHistory>>) {
      _qrHistory = historyState.data ?? [];
      emit(CurrentQrHistorySuccessState(history: historyState.data ?? []));
    } else if (historyState is DataFailed) {
      emit(
          CurrentQrHistoryErrorState(errorMessage: historyState.message ?? ""));
    }
  }

  FutureOr<void> _onGetPreviousHistoryEvent(
      GetPreviousHistoryEvent event, Emitter<HistoryState> emit) async {
    emit(PreviousQrHistoryLoadingState());
    final historyState =
        await _getQrHistoryUseCase(const QrHistoryRequest(isStatus: false));
    if (historyState is DataSuccess<List<QrHistory>>) {
      _qrHistory = historyState.data ?? [];
      emit(PreviousQrHistorySuccessState(history: historyState.data ?? []));
    } else if (historyState is DataFailed) {
      emit(PreviousQrHistoryErrorState(
          errorMessage: historyState.message ?? ""));
    }
  }

  FutureOr<void> _onHistorySearchEvent(
      QrHistorySearchEvent event, Emitter<HistoryState> emit) {
    if (_qrHistory.isNotEmpty) {
      if (event.searchValue.isNotEmpty) {
        _searchedQrHistory = _qrHistory;
        _searchedQrHistory = _searchedQrHistory
            .where((element) =>
                element.qrType.name
                    .toLowerCase()
                    .contains(event.searchValue.toLowerCase()) ||
                element.name
                    .toLowerCase()
                    .contains(event.searchValue.toLowerCase()) ||
                element.guestType.name
                    .toLowerCase()
                    .contains(event.searchValue.toLowerCase()))
            .toList();

        if (_searchedQrHistory.isNotEmpty) {
          emit(HistorySearchState(history: _searchedQrHistory));
        } else {
          emit(HistorySearchState(history: const []));
        }
      } else {
        emit(HistorySearchState(history: _qrHistory));
      }
    } else {
      emit(HistorySearchState(history: const []));
    }
  }

  FutureOr<void> _onHistoryDeactivateEvent(
      HistoryDeactivateEvent event, Emitter<HistoryState> emit) async {
    final deactivateState = await _deactivateQrHistoryUseCase(
        DeactivateQrRequest(id: event.history.id, isEnabled: false));
    if (deactivateState is DataSuccess) {
      if(deactivateState.data != null ) {
        _qrHistory[event.index] = deactivateState.data!;
      }
      for(int i = 0; i < _qrHistory.length; i++) {
        if(_qrHistory[i].id == deactivateState.data?.id) {
          _qrHistory[i] = deactivateState.data!;
        }
      }
      emit(HistoryDeactivateSuccessState(
          history: _qrHistory, successMessage: deactivateState.message ?? ""));
    } else if (deactivateState is DataFailed) {
      emit(HistoryDeactivateErrorState(
        errorMessage: deactivateState.message ?? "",
      ));
    }


  }

  FutureOr<void> _onHistoryActivateEvent(
      HistoryActivateEvent event, Emitter<HistoryState> emit) async {
    final activateState = await _deactivateQrHistoryUseCase(
        DeactivateQrRequest(id: event.history.id, isEnabled: true));
    if (activateState is DataSuccess) {
      if(activateState.data != null) {
        for(int i = 0; i < _qrHistory.length; i++) {
          if(_qrHistory[i].id == activateState.data?.id) {
            _qrHistory[i] = activateState.data!;
            _qrHistory[i] = _qrHistory[i].copyWith(isEnabled: false);
            print(_qrHistory[i].isEnabled);
          }
        }      }
      _qrHistory = _changeEnabledStatusQrItemUseCase(_qrHistory, event.history);
      emit(HistoryActivateSuccessState(
          history: _qrHistory, successMessage: activateState.message ?? ""));
    } else if (activateState is DataFailed) {
      emit(HistoryActivateErrorState(
        errorMessage: activateState.message ?? "",
      ));
    }
  }

  FutureOr<void> _onHistoryBackEvent(
      HistoryBackEvent event, Emitter<HistoryState> emit) {
    emit(HistoryBackState());
  }

  FutureOr<void> _onSelectQrTypeEvent(
      SelectQrTypeEvent event, Emitter<HistoryState> emit) {
    emit(SelectQrTypeState(qrType: event.qrType));
  }
}
