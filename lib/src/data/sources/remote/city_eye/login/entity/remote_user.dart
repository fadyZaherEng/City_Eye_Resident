import 'package:city_eye/src/data/sources/remote/city_eye/login/entity/remote_user_device_info.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/entity/remote_user_unit.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/entity/remote_user_information.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_user.g.dart';

@JsonSerializable()
class RemoteUser  {
  @JsonKey(name: 'userInfo')
  final RemoteUserInformation? userInformation;
  @JsonKey(name: 'unitLists')
  final List<RemoteUserUnit>? units;
  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: 'userDeviceInfo')
  final RemoteUserDeviceInfo? userDeviceInfo;


  const RemoteUser({
    this.userInformation = const RemoteUserInformation(),
    this.units = const [],
    this.token = '',
    this.userDeviceInfo = const RemoteUserDeviceInfo(),
  });

  factory RemoteUser.fromJson(Map<String, dynamic> json) =>
      _$RemoteUserFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteUserToJson(this);
}


extension RemoteUserExtension on RemoteUser {
  User mapToDomain() {
    return User(
      userInformation: (userInformation ?? const RemoteUserInformation()).mapToDomain(),
      token: token ?? "",
      userUnits: units.mapToDomain(),
      userDeviceInfo: (userDeviceInfo ?? const RemoteUserDeviceInfo()).mapToDomain(),
    );
  }
}
