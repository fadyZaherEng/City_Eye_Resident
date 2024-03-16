import 'package:equatable/equatable.dart';
import 'package:city_eye/src/domain/entities/profile/type_model.dart';

class ProfileUnit extends Equatable {
  final int unitId;
  final int userUnitId;
  final TypeModel userType;
  final int compoundId;
  final String compoundName;
  final String unitNumber;
  final String unitName;
  final String gasNumber;
  final String telephone;

  const ProfileUnit({
    this.unitId = 0,
    this.userUnitId = 0,
    this.userType = const TypeModel(),
    this.compoundId = 0,
    this.compoundName = "",
    this.unitNumber = "",
    this.unitName = "",
    this.gasNumber = "",
    this.telephone = "",
  });

  ProfileUnit copyWith({
    int? unitId,
    int? userUnitId,
    TypeModel? userType,
    int? compoundId,
    String? compoundName,
    String? unitNumber,
    String? unitName,
    String? gasNumber,
    String? telephone,
  }) {
    return ProfileUnit(
      unitId: unitId ?? this.unitId,
      userUnitId: userUnitId ?? this.userUnitId,
      userType: userType ?? this.userType,
      compoundId: compoundId ?? this.compoundId,
      compoundName: compoundName ?? this.compoundName,
      unitNumber: unitNumber ?? this.unitNumber,
      unitName: unitName ?? this.unitName,
      gasNumber: gasNumber ?? this.gasNumber,
      telephone: telephone ?? this.telephone,
    );
  }

  @override
  List<Object?> get props => [
        unitId,
        userUnitId,
        userType,
        compoundId,
        compoundName,
        unitNumber,
        unitName,
        gasNumber,
        telephone,
      ];
}
