import 'package:city_eye/src/domain/entities/reset_password/reset_password.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_reset_password.g.dart';

@JsonSerializable()
class RemoteResetPassword {
  final String? mobile;

  const RemoteResetPassword({
    this.mobile = "",
  });

  factory RemoteResetPassword.fromJson(Map<String, dynamic> json) =>
      _$RemoteResetPasswordFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteResetPasswordToJson(this);
}

extension ResetPasswordExtension on RemoteResetPassword {
  ResetPassword mapToDomain() => ResetPassword(
        mobile: mobile ?? "",
      );
}
