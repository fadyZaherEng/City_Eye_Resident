// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_page_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemotePageField _$RemotePageFieldFromJson(Map<String, dynamic> json) =>
    RemotePageField(
      id: json['id'] as int? ?? 0,
      controlTypeId: json['controlTypeId'] as int? ?? 0,
      maxCount: json['maxCount'] as int? ?? 0,
      minCount: json['minCount'] as int? ?? 0,
      description: json['description'] as String? ?? "",
      controlTypeCode: json['controlTypeCode'] as String? ?? "",
      lable: json['lable'] as String? ?? "",
      isRequired: json['isRequired'] as bool? ?? false,
      value: json['value'] as String? ?? "",
      answerId: json['answerId'] as String? ?? "",
      choice: (json['choice'] as List<dynamic>?)
              ?.map((e) => RemoteChoice.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      expireDate: json['expireDate'] as String? ?? "",
      isEditable: json['isEditable'] as bool? ?? false,
      isDeletable: json['isDeletable'] as bool? ?? false,
      canNotDeleteReason: json['canNotDeleteReason'] as String? ?? "",
      canNotEditReason: json['canNotEditReason'] as String? ?? "",
    );

Map<String, dynamic> _$RemotePageFieldToJson(RemotePageField instance) =>
    <String, dynamic>{
      'id': instance.id,
      'controlTypeId': instance.controlTypeId,
      'maxCount': instance.maxCount,
      'minCount': instance.minCount,
      'description': instance.description,
      'controlTypeCode': instance.controlTypeCode,
      'lable': instance.lable,
      'isRequired': instance.isRequired,
      'value': instance.value,
      'answerId': instance.answerId,
      'choice': instance.choice,
      'expireDate': instance.expireDate,
      'isEditable': instance.isEditable,
      'isDeletable': instance.isDeletable,
      'canNotDeleteReason': instance.canNotDeleteReason,
      'canNotEditReason': instance.canNotEditReason,
    };
