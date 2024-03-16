import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:equatable/equatable.dart';

class OTP extends Equatable {
  final int userId;
  final String number;
  final String expireDate;
  final UserUnit userUnit;

  const OTP({
    this.userId = 0,
    this.number = "",
    this.expireDate = "",
    this.userUnit = const UserUnit(),
  });

  @override
  List<Object?> get props => [
        userId,
        number,
        expireDate,
        userUnit,
      ];
}
