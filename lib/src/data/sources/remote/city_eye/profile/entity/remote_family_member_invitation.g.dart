// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_family_member_invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteFamilyMemberInvitation _$RemoteFamilyMemberInvitationFromJson(
        Map<String, dynamic> json) =>
    RemoteFamilyMemberInvitation(
      invitation: json['invitation'] == null
          ? const RemoteInvitation()
          : RemoteInvitation.fromJson(
              json['invitation'] as Map<String, dynamic>),
      familyMembers: (json['familyMembers'] as List<dynamic>?)
              ?.map(
                  (e) => RemoteFamilyMember.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteFamilyMemberInvitationToJson(
        RemoteFamilyMemberInvitation instance) =>
    <String, dynamic>{
      'invitation': instance.invitation,
      'familyMembers': instance.familyMembers,
    };
