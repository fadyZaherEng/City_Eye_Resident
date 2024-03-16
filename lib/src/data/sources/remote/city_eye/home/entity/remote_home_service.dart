import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_home_service.g.dart';

@JsonSerializable()
class RemoteHomeService {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'extraValue1')
  final String? extraValue1;
  @JsonKey(name: 'extraValue2')
  final String? extraValue2;
  @JsonKey(name: 'parentId')
  final int? parentId;
  @JsonKey(name: 'logo')
  final String? logo;
  @JsonKey(name: 'sortNo')
  final int? sortNo;

  const RemoteHomeService({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.extraValue1 = "",
    this.extraValue2 = "",
    this.parentId = 0,
    this.logo = "",
    this.sortNo = 0,
  });

  factory RemoteHomeService.fromJson(Map<String, dynamic> json) =>
      _$RemoteHomeServiceFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteHomeServiceToJson(this);
}

extension RemoteFeatureExtension on RemoteHomeService {
  HomeService mapToDomain() {
    return HomeService(
      id: id ?? 0,
      name: name ?? "",
      logo: logo ?? "",
      code: code ?? "",
      extraValue1: extraValue1 ?? "",
      extraValue2: extraValue2 ?? "",
      parentId: parentId ?? 0,
      sortNo: sortNo ?? 0,
    );
  }
}

extension RemoteFeatureListExtension on List<RemoteHomeService>? {
  List<HomeService> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
