import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_request.g.dart';

@JsonSerializable()
class VerifyOTPRequest {
  @JsonKey(name: 'otpNumber')
  final String otpNumber;
  @JsonKey(name: 'invitationID')
  final int invitationID;
  @JsonKey(name: 'isInvitation')
  final bool isInvitation;

  const VerifyOTPRequest({
    required this.otpNumber,
    required this.invitationID,
    required this.isInvitation,
  });

  factory VerifyOTPRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOTPRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOTPRequestToJson(this);

  @override
  String toString() {
    return 'VerifyOTPRequest{otpNumber: $otpNumber, invitationID: $invitationID, isInvitation: $isInvitation}';
  }
}
