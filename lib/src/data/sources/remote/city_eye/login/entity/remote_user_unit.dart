import 'package:city_eye/src/data/sources/remote/city_eye/login/entity/remote_user_unit_parent.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_user_unit.g.dart';

@JsonSerializable()
class RemoteUserUnit  {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'compoundId')
  final int? compoundId;
  @JsonKey(name: 'compoundName')
  final String? compoundName;
  @JsonKey(name: 'unitId')
  final int? unitId;
  @JsonKey(name: 'unitNo')
  final String? unitNo;
  @JsonKey(name: 'unitName')
  final String? unitName;
  @JsonKey(name: 'compoundLogo')
  final String? compoundLogo;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'userTypeId')
  final int? userTypeId;
  @JsonKey(name: 'userTypeName')
  final String? userTypeName;
  @JsonKey(name: 'userUnitContractEndDate')
  final String? userUnitContractEndDate;
  @JsonKey(name: 'isCompoundVerified')
  final bool? isCompoundVerified;
  @JsonKey(name: 'lastMassage')
  final String? lastMassage;
  @JsonKey(name: 'parents')
  final List<RemoteUserUnitParent>? parents;

  const RemoteUserUnit({
    this.id = 0,
    this.compoundId = 0,
    this.compoundName = "",
    this.unitId = 0,
    this.unitNo = "" ,
    this.unitName = "",
    this.compoundLogo = "",
    this.address = "",
    this.isActive = false,
    this.userTypeId = 0,
    this.userTypeName = "",
    this.userUnitContractEndDate = "",
    this.isCompoundVerified = false,
    this.lastMassage = "",
    this.parents = const [],
  });

  factory RemoteUserUnit.fromJson(Map<String, dynamic> json) =>
      _$RemoteUserUnitFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteUserUnitToJson(this);
}



extension RemoteUnitExtension on RemoteUserUnit {
  UserUnit mapToDomain() {
    return UserUnit(
      compoundId: compoundId ?? 0,
      compoundName: compoundName ?? "",
      unitId: unitId ?? 0,
      unitNo: unitNo ?? "",
      unitName: unitName ?? "",
      compoundLogo: compoundLogo ?? "",
      address: address ?? "",
      isActive: isActive ?? false,
      userTypeId: userTypeId ?? 0,
      userTypeName: userTypeName ?? "",
      userUnitContractEndDate: userUnitContractEndDate ?? "",
      isSelected: false,
      message: lastMassage ?? "",
      isCompoundVerified: isCompoundVerified ?? false,
      parents: parents?.map((e) => e.mapToDomain()).toList() ?? [],
    );
  }
}

extension RemoteUnitSwitchLanguageExtension on RemoteUserUnit {
  UserUnit mapUnitSwitchLanguageToDomain() {
    return UserUnit(
      compoundId: compoundId ?? 0,
      compoundName: compoundName ?? "",
      unitId: unitId ?? 0,
      unitNo: unitNo ?? "",
      unitName: unitName ?? "",
      compoundLogo: compoundLogo ?? "",
      address: address ?? "",
      isActive: isActive ?? false,
      userTypeId: userTypeId ?? 0,
      userTypeName: userTypeName ?? "",
      userUnitContractEndDate: userUnitContractEndDate ?? "",
      isSelected: true,
      message: lastMassage ?? "",
      isCompoundVerified: isCompoundVerified ?? false,
      parents: parents?.map((e) => e.mapToDomain()).toList() ?? [],
    );
  }
}

extension RemoteUnitsExtension on List<RemoteUserUnit>? {
  List<UserUnit> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}