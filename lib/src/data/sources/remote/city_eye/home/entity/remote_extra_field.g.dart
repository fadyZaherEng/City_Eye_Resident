// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_extra_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteExtraField _$RemoteExtraFieldFromJson(Map<String, dynamic> json) =>
    RemoteExtraField(
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
      validations: (json['eventsOptionQuestionValidations'] as List<dynamic>?)
              ?.map((e) => RemoteValidation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      eventOptionId: json['eventOptionId'] as int? ?? 0,
    );

Map<String, dynamic> _$RemoteExtraFieldToJson(RemoteExtraField instance) =>
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
      'eventsOptionQuestionValidations': instance.validations,
      'eventOptionId': instance.eventOptionId,
    };
