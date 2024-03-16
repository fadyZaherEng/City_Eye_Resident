// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_delegated_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitDelegatedRequest _$SubmitDelegatedRequestFromJson(
        Map<String, dynamic> json) =>
    SubmitDelegatedRequest(
      id: json['id'] as int,
      notes: json['notes'] as String,
      name: json['name'] as String,
      personalID: json['personalID'] as String,
      fromDate: json['fromDate'] as String,
      toDate: json['toDate'] as String,
      authName: json['authName'] as String,
      authPersonalID: json['authPersonalID'] as String,
      authMobile: json['authMobile'] as String,
      statusId: json['statusId'] as int,
      authCountryCode: json['authCountryCode'] as String,
      ownerExtraField: (json['ownerExtraField'] as List<dynamic>)
          .map((e) =>
              DelegatedExtraFieldRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      authExtraField: (json['authExtraField'] as List<dynamic>)
          .map((e) =>
              DelegatedExtraFieldRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubmitDelegatedRequestToJson(
        SubmitDelegatedRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'notes': instance.notes,
      'name': instance.name,
      'personalID': instance.personalID,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'authName': instance.authName,
      'authPersonalID': instance.authPersonalID,
      'authMobile': instance.authMobile,
      'statusId': instance.statusId,
      'authCountryCode': instance.authCountryCode,
      'ownerExtraField': instance.ownerExtraField,
      'authExtraField': instance.authExtraField,
    };
