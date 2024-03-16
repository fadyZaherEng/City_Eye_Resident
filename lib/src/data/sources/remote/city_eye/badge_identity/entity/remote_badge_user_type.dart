
import 'package:city_eye/src/domain/entities/badge_identity/badge_user_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_badge_user_type.g.dart';

@JsonSerializable()
class RemoteBadgeUserType {
  final int? id;
  final String? name;
  final String? code;

  const RemoteBadgeUserType({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  factory RemoteBadgeUserType.fromJson(Map<String, dynamic> json) => _$RemoteBadgeUserTypeFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteBadgeUserTypeToJson(this);

}

extension RemoteBadgeUserTypeExtension on RemoteBadgeUserType {
  BadgeUserType mapToDomain() {
    return BadgeUserType(
      id: id ?? 0,
      name: name ?? "",
      code: code ?? "",
    );
  }
}