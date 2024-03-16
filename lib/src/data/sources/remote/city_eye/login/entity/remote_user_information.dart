import 'package:city_eye/src/domain/entities/sign_in/user_information.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_user_information.g.dart';

@JsonSerializable()
class RemoteUserInformation {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'userName')
  final String? userName;
  @JsonKey(name: 'fullName')
  final String? fullName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'mobile')
  final String? mobile;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey(name: 'otpStatus')
  final bool? otpStatus;
  @JsonKey(name: 'subscriberId')
  final int? subscriberId;
  @JsonKey(name: 'contractDate')
  final String? contractDate;

  const RemoteUserInformation({
    this.id = -1,
    this.userName = '',
    this.fullName = '',
    this.email = '',
    this.mobile = '',
    this.image = '',
    this.status = false,
    this.otpStatus = false,
    this.subscriberId = 0,
    this.contractDate = "",
  });

  factory RemoteUserInformation.fromJson(Map<String, dynamic> json) =>
      _$RemoteUserInformationFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteUserInformationToJson(this);
}

extension RemoteUserInformationExtension on RemoteUserInformation {
  UserInformation mapToDomain() {
    return UserInformation(
      id: id ?? -1,
      name: userName ?? '',
      fullName: fullName ?? '',
      email: email ?? '',
      mobile: mobile ?? '',
      image: image ?? '',
      status: status ?? false,
      otpStatus: otpStatus ?? false,
      subscriberId: subscriberId ?? 0,
      contractDate: contractDate ?? "",
    );
  }
}
