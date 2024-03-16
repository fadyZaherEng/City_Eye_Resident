// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterFile _$RegisterFileFromJson(Map<String, dynamic> json) => RegisterFile(
      controlTypeId: json['controlTypeId'] as int,
      controlTypeCode: json['controlTypeCode'] as String,
      label: json['lable'] as String,
      id: json['id'] as int,
      isRequired: json['isRequired'] as bool,
      value: json['value'] as String,
      expireDate: json['expireDate'] as String,
    );

Map<String, dynamic> _$RegisterFileToJson(RegisterFile instance) =>
    <String, dynamic>{
      'controlTypeId': instance.controlTypeId,
      'controlTypeCode': instance.controlTypeCode,
      'lable': instance.label,
      'id': instance.id,
      'isRequired': instance.isRequired,
      'value': instance.value,
      'expireDate': instance.expireDate,
    };
