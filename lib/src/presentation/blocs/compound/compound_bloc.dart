import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/register/compound.dart';
import 'package:city_eye/src/domain/entities/register/city_compound.dart';
import 'package:city_eye/src/domain/usecase/get_city_compounds_use_case.dart';
import 'package:city_eye/src/domain/usecase/search_compounds_use_case.dart';
import 'package:city_eye/src/domain/usecase/select_region_filters_use_case.dart';
import 'package:city_eye/src/domain/usecase/select_region_use_case.dart';
import 'package:city_eye/src/domain/usecase/un_select_region_filters_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'compound_event.dart';

part 'compound_state.dart';

class CompoundBloc extends Bloc<CompoundEvent, CompoundState> {
  final SelectRegionFiltersUseCase _selectRegionFiltersUseCase;
  final SelectRegionUseCase _selectRegionUseCase;
  final UnSelectRegionFiltersUseCase _unSelectRegionFiltersUseCase;
  final SearchCompoundsUseCase _searchCompoundsUseCase;
  final GetCityCompoundsUseCase _getCityCompoundsUseCase;
  List<CityCompound> _regions = [];
  List<CityCompound> _tempRegions = [];

  CompoundBloc(
    this._selectRegionFiltersUseCase,
    this._selectRegionUseCase,
    this._unSelectRegionFiltersUseCase,
    this._searchCompoundsUseCase,
    this._getCityCompoundsUseCase,
  ) : super(CompoundInitialState()) {
    on<GetCityCompoundEvent>(_onGetCityCompoundEvent);
    on<SelectRegionEvent>(_onSelectRegionEvent);
    on<SelectCompoundEvent>(_onSelectCompoundEvent);
    on<CompoundSearchEvent>(_onCompoundSearchEvent);
    on<CloseRegionEvent>(_onCloseRegionEvent);
  }

  List<Compound> _compounds = [];
  void _getCompoundsInCity(int id) {
    for (int i = 0; i < _tempRegions.length; i++) {
      if (id == _tempRegions[i].parentId) {
        _compounds.addAll(_tempRegions[i].compounds);
        _getCompoundsInCity(_tempRegions[i].id);
      }
    }
  }

  FutureOr<void> _onGetCityCompoundEvent(
      GetCityCompoundEvent event, Emitter<CompoundState> emit) async {
    emit(ShowSkeletonState());
    final DataState dataState = await _getCityCompoundsUseCase();
    if (dataState is DataSuccess) {
      _tempRegions = dataState.data ?? [];
      _regions = _tempRegions.toList();
      for(int i = 0 ; i < _tempRegions.length; i++) {
        _compounds.clear();
        _compounds.addAll(_tempRegions[i].compounds);
        _getCompoundsInCity(_tempRegions[i].id);
        _regions[i] = _regions[i].copyWith(compounds: _compounds.toList());
      }
      _regions.insert(0, CityCompound(
        id: -1,
        name: S.current.all,
        parentId: 0,
        compounds: [],
      ));
      emit(GetCityCompoundsSuccessState(regions: _regions));
    } else {
      emit(GetCityCompoundsErrorState(
        errorMessage: dataState.message ?? "",
      ));
    }
  }

  FutureOr<void> _onSelectRegionEvent(
      SelectRegionEvent event, Emitter<CompoundState> emit) {
    emit(SelectRegionState(
      region: event.region,
      regionsFilter: _selectRegionFiltersUseCase(_regions, event.region),
      regions: _selectRegionUseCase(_regions, event.region),
    ));
  }

  FutureOr<void> _onSelectCompoundEvent(
      SelectCompoundEvent event, Emitter<CompoundState> emit) {
    emit(SelectCompoundState(
      compound: event.compound,
    ));
  }

  FutureOr<void> _onCompoundSearchEvent(
      CompoundSearchEvent event, Emitter<CompoundState> emit) {
    emit(CompoundSearchState(
      regions: _searchCompoundsUseCase(
          _regions, event.selectedRegion, event.value.trim()),
    ));
  }

  FutureOr<void> _onCloseRegionEvent(
      CloseRegionEvent event, Emitter<CompoundState> emit) {
    CityCompound region = _unSelectRegionFiltersUseCase(_regions, event.region)[
        _unSelectRegionFiltersUseCase(_regions, event.region).indexWhere(
                    (element) => element.id == event.region.parentId) ==
                -1
            ? 0
            : _unSelectRegionFiltersUseCase(_regions, event.region)
                .indexWhere((element) => element.id == event.region.parentId)];
    emit(CloseRegionState(
      region: region,
      regionsFilter: _unSelectRegionFiltersUseCase(_regions, event.region),
      regions: _selectRegionUseCase(_regions, region),
    ));
  }

}
