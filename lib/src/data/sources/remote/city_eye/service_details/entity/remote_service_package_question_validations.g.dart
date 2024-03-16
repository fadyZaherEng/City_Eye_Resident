// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_service_package_question_validations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteServicePackageQuestionValidations
    _$RemoteServicePackageQuestionValidationsFromJson(
            Map<String, dynamic> json) =>
        RemoteServicePackageQuestionValidations(
          id: json['id'] as int? ?? 0,
          servicePackageQuestionId:
              json['servicePackageQuestionId'] as int? ?? 0,
          questionTypeRules: json['questionTypeRules'] == null
              ? const RemoteQuestionTypeRules()
              : RemoteQuestionTypeRules.fromJson(
                  json['questionTypeRules'] as Map<String, dynamic>),
          value1: json['value1'] as String?,
          value2: json['value2'] as String?,
        );

Map<String, dynamic> _$RemoteServicePackageQuestionValidationsToJson(
        RemoteServicePackageQuestionValidations instance) =>
    <String, dynamic>{
      'id': instance.id,
      'servicePackageQuestionId': instance.servicePackageQuestionId,
      'questionTypeRules': instance.questionTypeRules,
      'value1': instance.value1,
      'value2': instance.value2,
    };
