part of 'compound_bloc.dart';

@immutable
abstract class CompoundState extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class CompoundInitialState extends CompoundState {}

class ShowSkeletonState extends CompoundState {}

class GetCityCompoundsSuccessState extends CompoundState {
  final List<CityCompound> regions;

  GetCityCompoundsSuccessState({
    required this.regions,
  });
}

class GetCityCompoundsErrorState extends CompoundState {
  final String errorMessage;

  GetCityCompoundsErrorState({
    required this.errorMessage,
  });
}

class SelectRegionState extends CompoundState {
  final CityCompound region;
  final List<CityCompound> regions;
  final List<CityCompound> regionsFilter;

  SelectRegionState({
    required this.region,
    required this.regions,
    required this.regionsFilter,
  });
}

class SelectCompoundState extends CompoundState {
  final Compound compound;

  SelectCompoundState({
    required this.compound,
  });
}

class CompoundSearchState extends CompoundState {
  final List<CityCompound> regions;

  CompoundSearchState({
    required this.regions,
  });
}

class CloseRegionState extends CompoundState {
  final CityCompound region;
  final List<CityCompound> regions;
  final List<CityCompound> regionsFilter;

  CloseRegionState({
    required this.region,
    required this.regions,
    required this.regionsFilter,
  });
}
