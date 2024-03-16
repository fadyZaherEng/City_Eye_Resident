// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_file_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoFileRequest _$InfoFileRequestFromJson(Map<String, dynamic> json) =>
    InfoFileRequest(
      controlTypeId: json['controlTypeId'] as int,
      controlTypeCode: json['controlTypeCode'] as String,
      label: json['lable'] as String,
      id: json['id'] as int,
      isRequired: json['isRequired'] as bool,
      value: json['value'] as String,
      answerId: json['answerId'] as int,
    );

Map<String, dynamic> _$InfoFileRequestToJson(InfoFileRequest instance) =>
    <String, dynamic>{
      'controlTypeId': instance.controlTypeId,
      'controlTypeCode': instance.controlTypeCode,
      'lable': instance.label,
      'id': instance.id,
      'isRequired': instance.isRequired,
      'value': instance.value,
      'answerId': instance.answerId,
    };
