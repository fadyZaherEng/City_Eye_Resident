import 'package:city_eye/src/domain/entities/profile/family_member_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class QRTime extends Equatable {
  final int id;
  final String name;
  final int from;
  final int to;
  final bool isSelected;
  final bool isRequired;
  final GlobalKey? key;
  final bool notAnswered;

  const QRTime({
    this.id = 0,
    this.name = "",
    this.from = 0,
    this.to = 0,
    this.isSelected = false,
    this.isRequired = true,
    this.notAnswered = false,
    this.key,
  });

  copyWith({
    int? id,
    String? name,
    int? from,
    int? to,
    String? code,
    String? image,
    int? parentId,
    bool? isSelected,
    bool? isRequired,
    bool? notAnswered,
    GlobalKey? key,
  }) {
    return QRTime(
      id: id ?? this.id,
      name: name ?? this.name,
      from: from ?? this.from,
      to: to ?? this.to,
      isSelected: isSelected ?? this.isSelected,
      isRequired: isRequired ?? this.isRequired,
      notAnswered: notAnswered ?? this.notAnswered,
      key: key ?? this.key,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        from,
        to,
        isSelected,
        isRequired,
        notAnswered,
        key,
      ];
}
