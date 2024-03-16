import 'package:city_eye/src/domain/entities/settings/compound_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_compound_type.g.dart';

@JsonSerializable()
final class RemoteCompoundType {
 final int? id;
 final  String? name;
 final String? code;

  const RemoteCompoundType({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  factory RemoteCompoundType.fromJson(Map<String, dynamic> json) =>
      _$RemoteCompoundTypeFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCompoundTypeToJson(this);
}

extension RemoteCompoundTypeExtension on RemoteCompoundType? {
  CompoundType get mapToDomain => CompoundType(
        id: this?.id ?? 0,
        code: this?.code ?? "",
        name: this?.name ?? "",
      );
}
