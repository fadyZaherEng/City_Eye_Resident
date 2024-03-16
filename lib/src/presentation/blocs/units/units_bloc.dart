import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/compound_units_request.dart';
import 'package:city_eye/src/domain/entities/register/compound_unit.dart';
import 'package:city_eye/src/domain/usecase/get_compound_units_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'units_event.dart';

part 'units_state.dart';

class UnitsBloc extends Bloc<UnitsEvent, UnitsState> {
  final GetCompoundUnitsUseCase _getCompoundUnitsUseCase;
  List<CompoundUnit> _units = [];
  List<List<CompoundUnit>> unitsStack = [];

  UnitsBloc(
    this._getCompoundUnitsUseCase,
  ) : super(ShowSkeletonState()) {
    on<GetUnitsEvent>(_onGetUnitsEvent);
    on<SelectUnitEvent>(_onSelectUnitEvent);
    on<OnTapNextEvent>(_onTapNextEvent);
    on<OnTapBackEvent>(_onTapBackEvent);
    on<UnitSearchEvent>(_onUnitSearchEvent);
    on<ApplyButtonPressedEvent>(_onApplyButtonPressedEvent);
  }

  FutureOr<void> _onGetUnitsEvent(
      GetUnitsEvent event, Emitter<UnitsState> emit) async {
    emit(ShowSkeletonState());
    final DataState dataState = await _getCompoundUnitsUseCase(event.request,event.userId);
    if (dataState is DataSuccess) {
      _units = dataState.data;
      emit(GetUnitsSuccessState(units: _units));
    } else {
      emit(GetUnitsErrorStateState(errorMessage: dataState.message ?? ""));
    }
    emit(HideLoadingState());
  }

  FutureOr<void> _onSelectUnitEvent(
      SelectUnitEvent event, Emitter<UnitsState> emit) {
    for (int i = 0; i < event.units.length; i++) {
      if (event.units[i].id == event.unit.id) {
        event.units[i] = event.units[i].copyWith(isSelected: true);
      } else {
        event.units[i] = event.units[i].copyWith(isSelected: false);
      }
    }
    emit(SelectUnitState(unit: event.unit, units: event.units));
  }

  FutureOr<void> _onTapNextEvent(
      OnTapNextEvent event, Emitter<UnitsState> emit) {
    unitsStack.insert(0, event.units);
    for (int i = 0; i < event.units.length; i++) {
      if (event.units[i].id == event.unit.id) {
        emit(OnTapNextState(units: event.units[i].units));
        break;
      }
    }
  }

  FutureOr<void> _onTapBackEvent(
      OnTapBackEvent event, Emitter<UnitsState> emit) {
    if (unitsStack.isNotEmpty) {
      emit(OnTapBackState(units: unitsStack[0]));
      unitsStack.removeAt(0);
    } else {
      emit(NavigateBackState());
    }
  }

  FutureOr<void> _onUnitSearchEvent(
      UnitSearchEvent event, Emitter<UnitsState> emit) {
    List<CompoundUnit> units = [];
    for (int i = 0; i < event.units.length; i++) {
      if (event.units[i].name
          .toLowerCase()
          .contains(event.value.trim().toLowerCase())) {
        units.add(event.units[i]);
      }
    }
    emit(UnitSearchState(units: units));
  }

  FutureOr<void> _onApplyButtonPressedEvent(
      ApplyButtonPressedEvent event, Emitter<UnitsState> emit) {
    String unitName = "";
    for (int i = unitsStack.length - 1; i >= 0; i--) {
      for (int j = 0; j < unitsStack[i].length; j++) {
        if (unitsStack[i][j].isSelected) {
          unitName += "${unitsStack[i][j].name} - ";
          break;
        }
      }
    }

    unitName += event.selectedUnit.name;
    unitsStack.clear();
    emit(ApplyButtonPressedState(
      unit: event.selectedUnit,
      unitName: unitName,
    ));
  }
}
