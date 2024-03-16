import 'package:city_eye/src/domain/entities/profile/family_member_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LookupFile extends Equatable {
  final int id;
  final String name;
  final String code;
  final String image;
  final int parentId;
  final bool isSelected;
  final bool isRequired;
  final GlobalKey? key;
  final bool notAnswered;

  const LookupFile({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.image = "",
    this.parentId = 0,
    this.isSelected = false,
    this.isRequired = true,
    this.notAnswered = false,
    this.key,
  });

  copyWith({
    int? id,
    String? name,
    String? code,
    String? image,
    int? parentId,
    bool? isSelected,
    bool? isRequired,
    bool? notAnswered,
    GlobalKey? key,
  }) {
    return LookupFile(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      image: image ?? this.image,
      parentId: parentId ?? this.parentId,
      isSelected: isSelected ?? this.isSelected,
      isRequired: isRequired ?? this.isRequired,
      notAnswered: notAnswered ?? this.notAnswered,
      key: key ?? this.key,
    );
  }

  @override
  List<Object?> get props => [
        id,
        code,
        name,
        image,
        parentId,
        isSelected,
        isRequired,
        notAnswered,
        key,
      ];
}

extension MapToFamilyMemberTypeExtension on LookupFile {
  FamilyMemberType toFamilyMemberType() {
    return FamilyMemberType(
      id: id,
      name: name,
      isSelected: isSelected,
    );
  }
}

extension MapToFamilyMemberTypesExtension on List<LookupFile>? {
  List<FamilyMemberType> toFamilyMemberTypes() {
    return this?.map((e) => e.toFamilyMemberType()).toList() ?? [];
  }
}
