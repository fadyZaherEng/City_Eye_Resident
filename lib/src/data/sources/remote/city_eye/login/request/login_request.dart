import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  @JsonKey(name: 'mobileNumber')
  final String mobile;
  @JsonKey(name: 'password')
  final String password;

  const LoginRequest({
    required this.mobile,
    required this.password,
  });


  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

}
