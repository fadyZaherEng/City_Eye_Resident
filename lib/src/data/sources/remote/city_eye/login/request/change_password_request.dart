import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';


@JsonSerializable()
class ChangePasswordRequest {
  @JsonKey(name: 'newPassword')
  final String newPassword;
  @JsonKey(name: 'confirmPassword')
  final String confirmPassword;
  @JsonKey(name: 'oldPassword')
  final String oldPassword;

  const ChangePasswordRequest({
    required this.newPassword,
    required this.confirmPassword,
    required this.oldPassword,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);


}
