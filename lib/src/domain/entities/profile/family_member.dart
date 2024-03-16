import 'package:city_eye/src/domain/entities/profile/type_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FamilyMember extends Equatable {
  final int id;
  final int userUnitId;
  final String name;
  final String mobileNumber;
  final TypeModel familyMemberType;
  final String email;
  final String attachment;
  final String countryCode;
  final GlobalKey? key;

  const FamilyMember({
    this.id = 0,
    this.userUnitId = 0,
    this.name = "",
    this.mobileNumber = "",
    this.familyMemberType = const TypeModel(),
    this.email = "",
    this.attachment = "",
    this.countryCode = "",
    this.key,
  });

  copyWith({
    int? id,
    int? userUnitId,
    String? name,
    String? mobileNumber,
    TypeModel? familyMemberTypeId,
    String? email,
    String? attachment,
    String? countryCode,
    GlobalKey? key,
  }) {
    return FamilyMember(
      id: id ?? this.id,
      userUnitId: userUnitId ?? this.userUnitId,
      name: name ?? this.name,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      familyMemberType: familyMemberTypeId ?? this.familyMemberType,
      email: email ?? this.email,
      attachment: attachment ?? this.attachment,
      countryCode: countryCode ?? this.countryCode,
      key: key ?? this.key,
    );
  }

  @override
  List<Object?> get props => [
        id,
        familyMemberType,
        userUnitId,
        name,
        mobileNumber,
        email,
        attachment,
        countryCode,
      ];
}
