import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:equatable/equatable.dart';

final class UnitQrQuestionAnswer extends Equatable {
  final int id;
  final int controlTypeId;
  final String controlTypeCode;
  final String lable;
  final bool isRequired;
  final String value;
  final String answerId;
  final String description;
  final List<Choice> choice;

  const UnitQrQuestionAnswer({
    this.id = 0,
    this.controlTypeId = 0,
    this.controlTypeCode = "",
    this.lable = "",
    this.isRequired = false,
    this.value = "",
    this.answerId = "",
    this.description = "",
    this.choice = const [],
  });

  UnitQrQuestionAnswer copyWith({
    int? id,
    int? controlTypeId,
    String? controlTypeCode,
    String? lable,
    bool? isRequired,
    String? value,
    String? answerId,
    String? description,
    List<Choice>? choice,
  }) =>
      UnitQrQuestionAnswer(
        id: id ?? this.id,
        controlTypeId: controlTypeId ?? this.controlTypeId,
        controlTypeCode: controlTypeCode ?? this.controlTypeCode,
        lable: lable ?? this.lable,
        isRequired: isRequired ?? this.isRequired,
        value: value ?? this.value,
        answerId: answerId ?? this.answerId,
        description: description ?? this.description,
        choice: choice ?? this.choice,
      );

  @override
  List<Object> get props => [
        id,
        controlTypeId,
        controlTypeCode,
        lable,
        isRequired,
        value,
        answerId,
        description,
        choice,
      ];
}
