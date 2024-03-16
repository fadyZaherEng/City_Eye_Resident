// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_unit_qr_question_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteUnitQrQuestionAnswer _$RemoteUnitQrQuestionAnswerFromJson(
        Map<String, dynamic> json) =>
    RemoteUnitQrQuestionAnswer(
      id: json['id'] as int? ?? 0,
      controlTypeId: json['controlTypeId'] as int? ?? 0,
      controlTypeCode: json['controlTypeCode'] as String? ?? "",
      lable: json['lable'] as String? ?? "",
      isRequired: json['isRequired'] as bool? ?? false,
      value: json['value'] as String? ?? "",
      answerId: json['answerId'] as String? ?? "",
      description: json['description'] as String? ?? "",
      choice: (json['choice'] as List<dynamic>?)
              ?.map((e) => RemoteChoice.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteUnitQrQuestionAnswerToJson(
        RemoteUnitQrQuestionAnswer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'controlTypeId': instance.controlTypeId,
      'controlTypeCode': instance.controlTypeCode,
      'lable': instance.lable,
      'isRequired': instance.isRequired,
      'value': instance.value,
      'answerId': instance.answerId,
      'description': instance.description,
      'choice': instance.choice?.map((e) => e.toJson()).toList(),
    };
