import 'package:city_eye/src/domain/entities/sign_in/user_device_info.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_information.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final UserInformation userInformation;
  final List<UserUnit> userUnits;
  final String token;
  final UserDeviceInfo userDeviceInfo;

  const User({
    this.userInformation = const UserInformation(),
    this.userUnits = const [],
    this.token = '',
    this.userDeviceInfo = const UserDeviceInfo(),
  });


  User copyWith({
    UserInformation? userInformation,
    List<UserUnit>? userUnits,
    String? token,
    UserDeviceInfo? userDeviceInfo,
  }) {
    return User(
      userInformation: userInformation ?? this.userInformation,
      userUnits: userUnits ?? this.userUnits,
      token: token ?? this.token,
      userDeviceInfo: userDeviceInfo ?? this.userDeviceInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userInformation': userInformation.toMap(),
      'userUnits': userUnits.map((element) => element.toMap()).toList(),
      'token': token,
      'userDeviceInfo': userDeviceInfo.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userInformation: UserInformation.fromMap(map['userInformation']),
      userUnits: List<UserUnit>.from(map['userUnits']?.map((x) => UserUnit.fromMap(x))),
      token: map['token'],
      userDeviceInfo: UserDeviceInfo.fromMap(map['userDeviceInfo']),
    );
  }

  @override
  List<Object?> get props => [
        userInformation,
        userUnits,
        token,
        userDeviceInfo,
      ];
}
