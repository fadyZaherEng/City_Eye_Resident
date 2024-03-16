import 'package:city_eye/src/domain/entities/badge_identity/badge_qr_code_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_badge_qr_code_status.g.dart';

@JsonSerializable()
class RemoteBadgeQrCodeStatus {
  final int? id;
  final String? code;
  final String? name;
  final String? color;

  const RemoteBadgeQrCodeStatus({
    this.id = 0,
    this.code = "",
    this.name = "",
    this.color = "",
  });

  factory RemoteBadgeQrCodeStatus.fromJson(Map<String, dynamic> json) => _$RemoteBadgeQrCodeStatusFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteBadgeQrCodeStatusToJson(this);

}

extension RemoteBadgeQrCodeStatusExtension on RemoteBadgeQrCodeStatus {
  BadgeQrCodeStatus mapToDomain() {
    return BadgeQrCodeStatus(
      id: id ?? 0,
      code: code ?? "",
      name: name ?? "",
      color: color ?? "",
    );
  }
}