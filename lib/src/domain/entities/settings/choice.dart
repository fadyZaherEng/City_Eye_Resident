import 'dart:io';

import 'package:city_eye/src/data/sources/remote/city_eye/register/request/register_file.dart';
import 'package:city_eye/src/domain/entities/qr/qr_radio_button_answer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Choice extends Equatable {
  final int id;
  final String value;
  bool isSelected;
  bool isNeedMoreInformation;
  final double percentage;
  bool showPercentage;
  final int total;

  Choice({
    this.id = 0,
    this.value = "",
    this.isSelected = false,
    this.isNeedMoreInformation = false,
    this.percentage = 0,
    this.showPercentage = false,
    this.total = 0,
  });

  Choice copyWith({
    int? id,
    String? value,
    bool? isSelected,
  }) {
    return Choice(
      id: id ?? this.id,
      value: value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [
        id,
        value,
        isSelected,
      ];

  Choice deepClone() {
    return Choice(
      id: this.id,
      value: this.value,
      isSelected: this.isSelected,
      isNeedMoreInformation: this.isNeedMoreInformation,
      percentage: this.percentage,
      showPercentage: this.showPercentage,
      total: this.total,
    );
  }
}

extension ChoiceExtention on Choice {
  QrRadioButtonAnswer mapToRadioButtonAnswer() => QrRadioButtonAnswer(
        answerId: id ?? 0,
        questionId: 0,
        isSelected: isSelected ?? false,
        answerTitle: value ?? "",
      );
}

extension ChoiceListExtention on List<Choice>? {
  List<QrRadioButtonAnswer> mapToRadioButtonAnswer() =>
      this!.map((event) => event.mapToRadioButtonAnswer()).toList();
}
