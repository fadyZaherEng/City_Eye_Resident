import 'package:city_eye/src/domain/entities/register/compound_unit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_compound_unit.g.dart';

@JsonSerializable()
class RemoteCompoundUnit {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'units')
  final List<RemoteCompoundUnit>? units;

  const RemoteCompoundUnit({
    this.id = 0,
    this.name = "",
    this.units = const [],
  });

  factory RemoteCompoundUnit.fromJson(Map<String, dynamic> json) =>
      _$RemoteCompoundUnitFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCompoundUnitToJson(this);
}

extension RemoteCompoundUnitExtension on RemoteCompoundUnit {
  CompoundUnit mapToDomain() {
    return CompoundUnit(
      id: id ?? 0,
      name: name ?? "",
      units: units?.map((e) => e.mapToDomain()).toList() ?? [],
      isSelected: false,
    );
  }
}

extension RemoteUnitsExtension on List<RemoteCompoundUnit>? {
  List<CompoundUnit> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
