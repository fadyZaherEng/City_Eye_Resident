part of 'compound_bloc.dart';

@immutable
abstract class CompoundEvent extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class GetCityCompoundEvent extends CompoundEvent {}

class SelectRegionEvent extends CompoundEvent {
  final CityCompound region;

  SelectRegionEvent({
    required this.region,
  });
}

class SelectCompoundEvent extends CompoundEvent {
  final Compound compound;
  SelectCompoundEvent({
    required this.compound,
  });
}

class CompoundSearchEvent extends CompoundEvent {
  final String value;
  final CityCompound selectedRegion;

  CompoundSearchEvent({
    required this.value,
    required this.selectedRegion,
  });
}

class CloseRegionEvent extends CompoundEvent {
  final CityCompound region;

  CloseRegionEvent({
    required this.region,
  });
}
