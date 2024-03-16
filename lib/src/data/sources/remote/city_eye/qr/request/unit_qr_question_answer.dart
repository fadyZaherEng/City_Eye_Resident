import 'package:json_annotation/json_annotation.dart';

part 'unit_qr_question_answer.g.dart';

@JsonSerializable()
class UnitQrQuestionAnswer {
  final String controlTypeCode;
  final int id;
  final String lable;
  final String value;
  final String answerId;
  final bool isChanged;

  UnitQrQuestionAnswer({
    required this.controlTypeCode,
    required this.id,
    required this.lable,
    required this.value,
    required this.answerId,
    this.isChanged = false,
  });

  factory UnitQrQuestionAnswer.fromJson(Map<String, dynamic> json) => _$UnitQrQuestionAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$UnitQrQuestionAnswerToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'controlTypeCode': controlTypeCode,
      'id': id,
      'lable': lable,
      'value': value,
      'answerId': answerId,
    };
  }

  factory UnitQrQuestionAnswer.fromMap(Map<String, dynamic> map) {
    return UnitQrQuestionAnswer(
      controlTypeCode: map['controlTypeCode'] as String,
      id: map['id'] as int,
      lable: map['lable'] as String,
      value: map['value'] as String,
      answerId: map['answerId'] as String,
    );
  }
}
