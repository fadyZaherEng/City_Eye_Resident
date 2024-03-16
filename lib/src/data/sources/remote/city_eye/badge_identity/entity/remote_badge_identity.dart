import 'package:city_eye/src/data/sources/remote/city_eye/badge_identity/entity/remote_badge_compound_units.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/badge_identity/entity/remote_badge_qr_code_status.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/badge_identity/entity/remote_badge_user_type.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/badge_identity/entity/remote_badge_users.dart';
import 'package:city_eye/src/domain/entities/badge_identity/badge_identity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_badge_identity.g.dart';

@JsonSerializable()
class RemoteBadgeIdentity {
  final int? id;
  final String? qrImage;
  final int? pinCode;
  final String? expiredDate;
  final RemoteBadgeUsers? users;
  final RemoteBadgeCompoundUnits? compoundUnits;
  final RemoteBadgeUserType? userType;
  final RemoteBadgeQrCodeStatus? qrCodeStatus;

  const RemoteBadgeIdentity({
    this.id = 0,
    this.qrImage = "",
    this.pinCode = 0,
    this.expiredDate = "",
    this.users = const RemoteBadgeUsers(),
    this.compoundUnits = const RemoteBadgeCompoundUnits(),
    this.userType = const RemoteBadgeUserType(),
    this.qrCodeStatus = const RemoteBadgeQrCodeStatus(),
  });

  factory RemoteBadgeIdentity.fromJson(Map<String, dynamic> json) =>
      _$RemoteBadgeIdentityFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteBadgeIdentityToJson(this);
}

extension RemoteBadgeIdentityExtension on RemoteBadgeIdentity {
  BadgeIdentity mapToDomain() {
    return BadgeIdentity(
      id: id ?? 0,
      qrImage: qrImage ?? "",
      pinCode: pinCode ?? 0,
      expiredDate: expiredDate ?? "",
      users: (users ?? const RemoteBadgeUsers()).mapToDomain(),
      compoundUnits:
          (compoundUnits ?? const RemoteBadgeCompoundUnits()).mapToDomain(),
      userType: (userType ?? const RemoteBadgeUserType()).mapToDomain(),
      qrCodeStatus:
          (qrCodeStatus ?? const RemoteBadgeQrCodeStatus()).mapToDomain(),
    );
  }
}
