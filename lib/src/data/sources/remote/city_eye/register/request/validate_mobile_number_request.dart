import 'package:json_annotation/json_annotation.dart';

part 'validate_mobile_number_request.g.dart';

@JsonSerializable()
class ValidateMobileNumberRequest {
  @JsonKey(name: 'mobileNumber')
  final String mobileNumber;

  @JsonKey(name: 'email')
  final String email;

  const ValidateMobileNumberRequest({
    required this.mobileNumber,
    required this.email,
  });

  factory ValidateMobileNumberRequest.fromJson(Map<String, dynamic> json) =>
      _$ValidateMobileNumberRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateMobileNumberRequestToJson(this);

  @override
  String toString() {
    return 'ValidateMobileNumberRequest{mobileNumber: $mobileNumber, email: $email}';
  }
}
