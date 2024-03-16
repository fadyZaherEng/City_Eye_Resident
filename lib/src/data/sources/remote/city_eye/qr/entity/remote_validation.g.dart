// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_validation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteValidation _$RemoteValidationFromJson(Map<String, dynamic> json) =>
    RemoteValidation(
      id: json['id'] as int? ?? 0,
      remoteValidationRule: json['questionTypeRules'] == null
          ? const RemoteValidationRule()
          : RemoteValidationRule.fromJson(
              json['questionTypeRules'] as Map<String, dynamic>),
      value1: json['value1'] as String? ?? "",
      value2: json['value2'] as String? ?? "",
      validationMessage: json['validationMessage'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteValidationToJson(RemoteValidation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionTypeRules': instance.remoteValidationRule,
      'value1': instance.value1,
      'value2': instance.value2,
      'validationMessage': instance.validationMessage,
    };
