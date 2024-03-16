// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_validation_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteValidationRule _$RemoteValidationRuleFromJson(
        Map<String, dynamic> json) =>
    RemoteValidationRule(
      id: json['id'] as int? ?? 0,
      code: json['code'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteValidationRuleToJson(
        RemoteValidationRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
    };
