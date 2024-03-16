import 'package:city_eye/src/domain/entities/register/compound.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_compound.g.dart';

@JsonSerializable()
class RemoteCompound  {
  @JsonKey(name: 'cityid')
  final int? cityid;
  @JsonKey(name: 'compoundId')
  final int? compoundId;
  @JsonKey(name: 'cityname')
  final String? cityname;
  @JsonKey(name: 'compoubdName')
  final String? compoubdName;
  @JsonKey(name: 'compoundLogo')
  final String? compoundLogo;

  const RemoteCompound({
    this.cityid = 0,
    this.compoundId = 0,
    this.cityname = "",
    this.compoubdName = "",
    this.compoundLogo = "",
  });

  factory RemoteCompound.fromJson(Map<String, dynamic> json) =>
      _$RemoteCompoundFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCompoundToJson(this);
}



extension RemoteCompoundUnitExtension on RemoteCompound {
  Compound mapToDomain() {
    return Compound(
      id: compoundId ?? 0,
      name: compoubdName ?? "",
      logo: compoundLogo ?? "",
      cityId: cityid ?? 0,
      cityName: cityname ?? "",
    );
  }
}

extension RemoteUnitsExtension on List<RemoteCompound>? {
  List<Compound> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}

