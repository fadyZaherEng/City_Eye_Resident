import 'package:city_eye/src/domain/entities/badge_identity/badge_compound_units.dart';
import 'package:city_eye/src/domain/entities/badge_identity/badge_qr_code_status.dart';
import 'package:city_eye/src/domain/entities/badge_identity/badge_user_type.dart';
import 'package:city_eye/src/domain/entities/badge_identity/badge_users.dart';
import 'package:equatable/equatable.dart';

class BadgeIdentity extends Equatable {
  final int id;
  final String qrImage;
  final int pinCode;
  final String expiredDate;
  final BadgeUsers users;
  final BadgeCompoundUnits compoundUnits;
  final BadgeUserType userType;
  final BadgeQrCodeStatus qrCodeStatus;

  const BadgeIdentity({
    this.id = 0,
    this.qrImage = "",
    this.pinCode = 0,
    this.expiredDate = "",
    this.users = const BadgeUsers(),
    this.compoundUnits = const BadgeCompoundUnits(),
    this.userType = const BadgeUserType(),
    this.qrCodeStatus = const BadgeQrCodeStatus(),
  });

  @override
  List<Object> get props => [
        id,
        qrImage,
        pinCode,
        expiredDate,
        users,
        compoundUnits,
        userType,
        qrCodeStatus,
      ];
}
