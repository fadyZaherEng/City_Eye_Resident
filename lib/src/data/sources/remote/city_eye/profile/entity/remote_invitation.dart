import 'package:city_eye/src/domain/entities/profile/invitation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_invitation.g.dart';

@JsonSerializable()
class RemoteInvitation {
  final int? id;
  final String? otpNumber;
  final String? invitationUrl;

  const RemoteInvitation({
    this.id = 0,
    this.otpNumber = "",
    this.invitationUrl = "",
  });

  factory RemoteInvitation.fromJson(Map<String, dynamic> json) =>
      _$RemoteInvitationFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteInvitationToJson(this);
}

extension RemoteExtensionInvitation on RemoteInvitation {
  Invitation mapToDomain() =>
      Invitation(
        id: id ?? 0,
        otpNumber: otpNumber ?? "",
        invitationUrl: invitationUrl ?? "",
      );
}
