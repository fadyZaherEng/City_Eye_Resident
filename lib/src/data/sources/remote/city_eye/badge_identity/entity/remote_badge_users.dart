import 'package:city_eye/src/domain/entities/badge_identity/badge_users.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_badge_users.g.dart';

@JsonSerializable()
class RemoteBadgeUsers {
  final int? id;
  final String? fullName;
  final String? userName;
  final String? mobile;
  final String? email;
  final int? subscriberId;
  final String? image;

  const RemoteBadgeUsers({
    this.id = 0,
    this.fullName = "",
    this.userName = "",
    this.mobile = "",
    this.email = "",
    this.subscriberId = 0,
    this.image = "",
  });

  factory RemoteBadgeUsers.fromJson(Map<String, dynamic> json) =>
      _$RemoteBadgeUsersFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteBadgeUsersToJson(this);
}

extension RemoteBadgeUsersExtension on RemoteBadgeUsers {
  BadgeUsers mapToDomain() {
    return BadgeUsers(
      id: id ?? 0,
      fullName: fullName ?? "",
      userName: userName ?? "",
      mobile: mobile ?? "",
      email: email ?? "",
      subscriberId: subscriberId ?? 0,
      image: image ?? "",
    );
  }
}
