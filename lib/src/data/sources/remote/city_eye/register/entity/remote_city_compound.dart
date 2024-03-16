import 'package:city_eye/src/data/sources/remote/city_eye/register/entity/remote_compound.dart';
import 'package:city_eye/src/domain/entities/register/city_compound.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_city_compound.g.dart';

@JsonSerializable()
class RemoteCityCompound {
  @JsonKey(name: 'cityid')
  final int? cityid;
  @JsonKey(name: 'parentId')
  final int? parentId;
  @JsonKey(name: 'cityname')
  final String? cityname;
  @JsonKey(name: 'compounds')
  final List<RemoteCompound>? compounds;

  const RemoteCityCompound({
    this.cityid = 0,
    this.parentId = 0,
    this.cityname = "",
    this.compounds = const [],
  });

  factory RemoteCityCompound.fromJson(Map<String, dynamic> json) =>
      _$RemoteCityCompoundFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCityCompoundToJson(this);
}


extension RemoteCompoundUnitExtension on RemoteCityCompound {
  CityCompound mapToDomain() {
    return CityCompound(
      id: cityid ?? 0,
      name: cityname ?? "",
      compounds: compounds?.map((e) => e.mapToDomain()).toList() ?? [],
      parentId: parentId ?? 0,
    );
  }
}

extension RemoteUnitsExtension on List<RemoteCityCompound>? {
  List<CityCompound> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}