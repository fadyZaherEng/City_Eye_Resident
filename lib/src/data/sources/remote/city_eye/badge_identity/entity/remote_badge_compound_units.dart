import 'package:city_eye/src/domain/entities/badge_identity/badge_compound_units.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_badge_compound_units.g.dart';

@JsonSerializable()
class RemoteBadgeCompoundUnits {
  final int? id;
  final String? name;
  final String? unitNO;

  const RemoteBadgeCompoundUnits({
    this.id = 0,
    this.name = "",
    this.unitNO = "",
  });

  factory RemoteBadgeCompoundUnits.fromJson(Map<String, dynamic> json) => _$RemoteBadgeCompoundUnitsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteBadgeCompoundUnitsToJson(this);
}

extension BadgeCompoundUnitsExtension on RemoteBadgeCompoundUnits {
  BadgeCompoundUnits mapToDomain() {
    return BadgeCompoundUnits(
      id: id ?? 0,
      name: name ?? "",
      unitNO: unitNO ?? "",
    );
  }
}
