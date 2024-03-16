import 'package:city_eye/src/domain/entities/profile/type_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_type.g.dart';

@JsonSerializable()
class RemoteType {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'code')
  final String? code;

  const RemoteType({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  factory RemoteType.fromJson(Map<String, dynamic> json) =>
      _$RemoteTypeFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteTypeToJson(this);
}

extension RemoteTypeExtension on RemoteType {
  TypeModel mapToDomain() {
    return TypeModel(
      id: id ?? 0,
      name: name ?? "",
      code: code ?? "",
      isSelected: false,
    );
  }
}