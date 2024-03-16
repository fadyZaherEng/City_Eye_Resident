import 'package:city_eye/src/domain/entities/settings/lookup_file.dart';
import 'package:equatable/equatable.dart';

class CarConfiguration extends Equatable {
  final List<LookupFile> colors;
  final List<LookupFile> types;
  final List<LookupFile> models;

  const CarConfiguration({
    this.colors = const [],
    this.types = const [],
    this.models = const [],
  });

  CarConfiguration copyWith({
    List<LookupFile>? colors,
    List<LookupFile>? types,
    List<LookupFile>? models,
  }) {
    return CarConfiguration(
      colors: colors ?? this.colors,
      types: types ?? this.types,
      models: models ?? this.models,
    );
  }

  @override
  List<Object?> get props => [
        colors,
        types,
        models,
      ];
}
