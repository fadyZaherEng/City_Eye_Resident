// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_delegated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteDelegated _$RemoteDelegatedFromJson(Map<String, dynamic> json) =>
    RemoteDelegated(
      id: json['id'] as int? ?? 0,
      notes: json['notes'] as String? ?? "",
      name: json['name'] as String? ?? "",
      personalID: json['personalID'] as String? ?? "",
      ownerIDAttachment: json['ownerIDAttachment'] as String? ?? "",
      fromDate: json['fromDate'] as String? ?? "",
      toDate: json['toDate'] as String? ?? "",
      authName: json['authName'] as String? ?? "",
      authPersonalID: json['authPersonalID'] as String? ?? "",
      authMobile: json['authMobile'] as String? ?? "",
      authIDAttachment: json['authIDAttachment'] as String? ?? "",
      statusId: json['statusId'] as int? ?? 0,
      ownerSignatureAttachment:
          json['ownerSignatureAttachment'] as String? ?? "",
      authSignatureAttachment: json['authSignatureAttachment'] as String? ?? "",
      authCountryCode: json['authCountryCode'] as String? ?? "EG",
      isEnabled: json['isEnabled'] as bool? ?? false,
      ownerExtraField: (json['ownerExtraField'] as List<dynamic>?)
              ?.map((e) => RemotePageField.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      authExtraField: (json['authExtraField'] as List<dynamic>?)
              ?.map((e) => RemotePageField.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      qrImage: json['qrImage'] as String? ?? "",
      documentDelegation: json['documentDelegation'] as String? ?? "",
      pinCode: json['pinCode'] as int? ?? 0,
    );

Map<String, dynamic> _$RemoteDelegatedToJson(RemoteDelegated instance) =>
    <String, dynamic>{
      'id': instance.id,
      'notes': instance.notes,
      'name': instance.name,
      'personalID': instance.personalID,
      'ownerIDAttachment': instance.ownerIDAttachment,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'authName': instance.authName,
      'authPersonalID': instance.authPersonalID,
      'authMobile': instance.authMobile,
      'authIDAttachment': instance.authIDAttachment,
      'statusId': instance.statusId,
      'ownerSignatureAttachment': instance.ownerSignatureAttachment,
      'authSignatureAttachment': instance.authSignatureAttachment,
      'authCountryCode': instance.authCountryCode,
      'qrImage': instance.qrImage,
      'documentDelegation': instance.documentDelegation,
      'pinCode': instance.pinCode,
      'ownerExtraField': instance.ownerExtraField,
      'authExtraField': instance.authExtraField,
      'isEnabled': instance.isEnabled,
    };
