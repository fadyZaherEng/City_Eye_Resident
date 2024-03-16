import 'package:city_eye/src/domain/entities/settings/lookup_file.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_lookup_file.g.dart';

@JsonSerializable()
class RemoteLookupFile {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'extraValue1')
  final String? extraValueOne;
  @JsonKey(name: 'extraValue2')
  final String? extraValueTwo;
  @JsonKey(name: 'parentId')
  final int? parentId;
  @JsonKey(name: 'logo')
  final String? logo;
  @JsonKey(name: 'sortNo')
  final int? sortNo;

  const RemoteLookupFile({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.extraValueOne = "",
    this.extraValueTwo = "",
    this.parentId = 0,
    this.logo = "",
    this.sortNo = 0,
  });

  factory RemoteLookupFile.fromJson(Map<String, dynamic> json) =>
      _$RemoteLookupFileFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteLookupFileToJson(this);
}

extension RemoteLookupFileExtension on RemoteLookupFile {
  LookupFile mapToDomain() {
    return LookupFile(
      id: id ?? 0,
      name: name ?? "",
      code: code ?? "",
      parentId: parentId ?? 0,
      image: logo ?? "",
      isSelected: false,
    );
  }
}

extension RemoteLookupFilesExtension on List<RemoteLookupFile>? {
  List<LookupFile> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
