import 'package:json_annotation/json_annotation.dart';

part 'request_otp_request.g.dart';

@JsonSerializable()
class RequestOTPRequest {
  @JsonKey(name: 'userID')
  final int userId;

  const RequestOTPRequest({
    required this.userId,
  });

  factory RequestOTPRequest.fromJson(Map<String, dynamic> json) =>
      _$RequestOTPRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOTPRequestToJson(this);

  @override
  String toString() {
    return 'RequestOTPRequest{userId: $userId}';
  }
}
