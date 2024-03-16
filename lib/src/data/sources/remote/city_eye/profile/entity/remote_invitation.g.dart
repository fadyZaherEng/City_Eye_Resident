// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteInvitation _$RemoteInvitationFromJson(Map<String, dynamic> json) =>
    RemoteInvitation(
      id: json['id'] as int? ?? 0,
      otpNumber: json['otpNumber'] as String? ?? "",
      invitationUrl: json['invitationUrl'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteInvitationToJson(RemoteInvitation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'otpNumber': instance.otpNumber,
      'invitationUrl': instance.invitationUrl,
    };
