// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_qr_question_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitQrQuestionAnswer _$UnitQrQuestionAnswerFromJson(
        Map<String, dynamic> json) =>
    UnitQrQuestionAnswer(
      controlTypeCode: json['controlTypeCode'] as String,
      id: json['id'] as int,
      lable: json['lable'] as String,
      value: json['value'] as String,
      answerId: json['answerId'] as String,
      isChanged: json['isChanged'] as bool? ?? false,
    );

Map<String, dynamic> _$UnitQrQuestionAnswerToJson(
        UnitQrQuestionAnswer instance) =>
    <String, dynamic>{
      'controlTypeCode': instance.controlTypeCode,
      'id': instance.id,
      'lable': instance.lable,
      'value': instance.value,
      'answerId': instance.answerId,
      'isChanged': instance.isChanged,
    };
