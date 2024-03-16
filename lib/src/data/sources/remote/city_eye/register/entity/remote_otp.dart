import 'package:city_eye/src/data/sources/remote/city_eye/login/entity/remote_user_unit.dart';
import 'package:city_eye/src/domain/entities/register/otp.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_otp.g.dart';

@JsonSerializable()
class RemoteOTP {
  @JsonKey(name: 'userId')
  final int? userId;
  @JsonKey(name: 'newOTPnumber')
  final String? newOTPnumber;
  @JsonKey(name: 'expireDate')
  final String? expireDate;
  @JsonKey(name: 'unit')
  final RemoteUserUnit? unit;

  const RemoteOTP({
    this.userId = 0,
    this.newOTPnumber = "",
    this.expireDate = "",
    this.unit = const RemoteUserUnit(),
  });

  factory RemoteOTP.fromJson(Map<String, dynamic> json) =>
      _$RemoteOTPFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteOTPToJson(this);
}

extension RemoteOTPExtension on RemoteOTP {
  OTP mapToDomain() {
    return OTP(
      userId: userId ?? 0,
      number: newOTPnumber ?? "",
      expireDate: expireDate ?? "",
      userUnit: (unit ?? RemoteUserUnit()).mapToDomain(),
    );
  }
}
