// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_service_packages_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteServicePackagesQuestion _$RemoteServicePackagesQuestionFromJson(
        Map<String, dynamic> json) =>
    RemoteServicePackagesQuestion(
      servicePackageQuestionValidations:
          (json['servicePackageQuestionValidations'] as List<dynamic>?)
                  ?.map((e) => RemoteServicePackageQuestionValidations.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              const [],
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

Map<String, dynamic> _$RemoteServicePackagesQuestionToJson(
        RemoteServicePackagesQuestion instance) =>
    <String, dynamic>{
      'servicePackageQuestionValidations':
          instance.servicePackageQuestionValidations,
      'id': instance.id,
      'controlTypeId': instance.controlTypeId,
      'controlTypeCode': instance.controlTypeCode,
      'lable': instance.lable,
      'isRequired': instance.isRequired,
      'value': instance.value,
      'answerId': instance.answerId,
      'description': instance.description,
      'choice': instance.choice,
    };
