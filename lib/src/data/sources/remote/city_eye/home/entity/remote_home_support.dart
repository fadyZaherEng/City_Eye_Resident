import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_home_support.g.dart';

@JsonSerializable()
class RemoteHomeSupport {
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

  const RemoteHomeSupport({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.extraValue1 = "",
    this.extraValue2 = "",
    this.parentId = 0,
    this.logo = "",
    this.sortNo = 0,
  });

  factory RemoteHomeSupport.fromJson(Map<String, dynamic> json) =>
      _$RemoteHomeSupportFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteHomeSupportToJson(this);
}

extension RemoteHomeSupportExtension on RemoteHomeSupport {
  HomeSupport mapToDomain() {
    return HomeSupport(
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

extension RemoteHomeSupportListExtension on List<RemoteHomeSupport>? {
  List<HomeSupport> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
