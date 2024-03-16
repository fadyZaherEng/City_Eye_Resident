// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOTPRequest _$VerifyOTPRequestFromJson(Map<String, dynamic> json) =>
    VerifyOTPRequest(
      otpNumber: json['otpNumber'] as String,
      invitationID: json['invitationID'] as int,
      isInvitation: json['isInvitation'] as bool,
    );

Map<String, dynamic> _$VerifyOTPRequestToJson(VerifyOTPRequest instance) =>
    <String, dynamic>{
      'otpNumber': instance.otpNumber,
      'invitationID': instance.invitationID,
      'isInvitation': instance.isInvitation,
    };
