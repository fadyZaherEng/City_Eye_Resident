import 'package:city_eye/src/domain/entities/qr/qrs_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_qrs_type.g.dart';

@JsonSerializable()
class RemoteQrsType {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'code')
  final String? code;

  const RemoteQrsType({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  factory RemoteQrsType.fromJson(Map<String, dynamic> json) =>
      _$RemoteQrsTypeFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteQrsTypeToJson(this);
}

extension RemoteQrsTypeExtension on RemoteQrsType? {
  QrsType mapToDomain() {
    return QrsType(
      id: this?.id ?? 0,
      name: this?.name ?? "",
      code: this?.code ?? "",
    );
  }
}

extension RemoteQrsTypesExtension on List<RemoteQrsType>? {
  List<QrsType  > mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
