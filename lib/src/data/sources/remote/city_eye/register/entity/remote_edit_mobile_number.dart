
import 'package:city_eye/src/domain/entities/register/edit_mobile_number.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_edit_mobile_number.g.dart';

@JsonSerializable()
class RemoteEditMobileNumber {
  final String? newOTPnumber;
  final String? expireDate;

  const RemoteEditMobileNumber({
    this.newOTPnumber = "",
    this.expireDate = "",
  });

  factory RemoteEditMobileNumber.fromJson(Map<String, dynamic> json) =>
      _$RemoteEditMobileNumberFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteEditMobileNumberToJson(this);

}

extension RemoteEditMobileNumberX on RemoteEditMobileNumber {
  EditMobileNumber mapToDomain() {
    return EditMobileNumber(
      newOTPnumber: newOTPnumber ?? "",
      expireDate: expireDate ?? "",
    );
  }
}
