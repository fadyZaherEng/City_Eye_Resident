import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_family_member.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/entity/remote_invitation.dart';
import 'package:city_eye/src/domain/entities/profile/family_member_invitation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_family_member_invitation.g.dart';

@JsonSerializable()
class RemoteFamilyMemberInvitation {
  final RemoteInvitation? invitation;
  final List<RemoteFamilyMember>? familyMembers;

  const RemoteFamilyMemberInvitation({
    this.invitation = const RemoteInvitation(),
    this.familyMembers = const [],
  });

  factory RemoteFamilyMemberInvitation.fromJson(Map<String, dynamic> json) =>
      _$RemoteFamilyMemberInvitationFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteFamilyMemberInvitationToJson(this);
}

extension RemoteExtensionFamilyMemberInvitation on RemoteFamilyMemberInvitation {
  FamilyMemberInvitation mapToDomain() => FamilyMemberInvitation(
        invitation: (invitation ?? const RemoteInvitation()).mapToDomain(),
        familyMembers: familyMembers.mapToDomain(),
      );
}