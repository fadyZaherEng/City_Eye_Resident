import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_type.dart';
import 'package:city_eye/src/domain/entities/profile/profile_unit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_profile_unit.g.dart';

@JsonSerializable()
class RemoteProfileUnit {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'unitId')
  final int? unitId;
  @JsonKey(name: 'userType')
  final RemoteType? userType;
  @JsonKey(name: 'compoundId')
  final int? compoundId;
  @JsonKey(name: 'compoundName')
  final String? compoundName;
  @JsonKey(name: 'unitNO')
  final String? unitNO;
  @JsonKey(name: 'unitName')
  final String? unitName;
  @JsonKey(name: 'gasNO')
  final String? gazNo;
  @JsonKey(name: 'telephone')
  final String? telephone;

  const RemoteProfileUnit({
    this.id = 0,
    this.unitId = 0,
    this.userType = const RemoteType(),
    this.compoundId = 0,
    this.compoundName = "",
    this.unitNO = "",
    this.unitName = "",
    this.gazNo = "",
    this.telephone = "",
  });

  factory RemoteProfileUnit.fromJson(Map<String, dynamic> json) =>
      _$RemoteProfileUnitFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteProfileUnitToJson(this);
}


extension RemoteProfileUnitExtension on RemoteProfileUnit {
  ProfileUnit mapToDomain() {
    return ProfileUnit(
      userUnitId: id ?? 0,
      unitId: unitId ?? 0,
      userType: (userType ?? RemoteType()).mapToDomain(),
      compoundId: compoundId ?? 0,
      compoundName: compoundName ?? "",
      unitNumber: unitNO ?? "",
      unitName: unitName ?? "",
      gasNumber: gazNo ?? "",
      telephone: telephone ?? "",
    );
  }
}