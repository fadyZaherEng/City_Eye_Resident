// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_document_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDocumentRequest _$ProfileDocumentRequestFromJson(
        Map<String, dynamic> json) =>
    ProfileDocumentRequest(
      controlTypeId: json['controlTypeId'] as int,
      controlTypeCode: json['controlTypeCode'] as String,
      label: json['lable'] as String,
      id: json['id'] as int,
      isRequired: json['isRequired'] as bool,
      value: json['value'] as String,
      expireDate: json['expireDate'] as String?,
      isChanged: json['isChanged'] as bool? ?? false,
    );

Map<String, dynamic> _$ProfileDocumentRequestToJson(
        ProfileDocumentRequest instance) =>
    <String, dynamic>{
      'controlTypeId': instance.controlTypeId,
      'controlTypeCode': instance.controlTypeCode,
      'lable': instance.label,
      'id': instance.id,
      'isRequired': instance.isRequired,
      'value': instance.value,
      'expireDate': instance.expireDate,
      'isChanged': instance.isChanged,
    };
