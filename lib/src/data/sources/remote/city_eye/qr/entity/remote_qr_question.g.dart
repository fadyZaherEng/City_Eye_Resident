// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_qr_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteQrQuestion _$RemoteQrQuestionFromJson(Map<String, dynamic> json) =>
    RemoteQrQuestion(
      id: json['id'] as int? ?? 0,
      controlTypeId: json['controlTypeId'] as int? ?? 0,
      maxCount: json['maxCount'] as int? ?? 0,
      minCount: json['minCount'] as int? ?? 0,
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
      validations: (json['formControlsValidation'] as List<dynamic>?)
              ?.map((e) => RemoteValidation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteQrQuestionToJson(RemoteQrQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'controlTypeId': instance.controlTypeId,
      'maxCount': instance.maxCount,
      'minCount': instance.minCount,
      'controlTypeCode': instance.controlTypeCode,
      'lable': instance.lable,
      'isRequired': instance.isRequired,
      'value': instance.value,
      'answerId': instance.answerId,
      'description': instance.description,
      'choice': instance.choice,
      'formControlsValidation': instance.validations,
    };
