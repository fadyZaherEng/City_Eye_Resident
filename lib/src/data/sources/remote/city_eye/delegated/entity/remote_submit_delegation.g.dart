// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_submit_delegation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteSubmitDelegation _$RemoteSubmitDelegationFromJson(
        Map<String, dynamic> json) =>
    RemoteSubmitDelegation(
      link: json['link'] as String? ?? "",
      qrImage: json['qrImage'] as String? ?? "",
      pinCode: json['pinCode'] as int? ?? 0,
    );

Map<String, dynamic> _$RemoteSubmitDelegationToJson(
        RemoteSubmitDelegation instance) =>
    <String, dynamic>{
      'link': instance.link,
      'qrImage': instance.qrImage,
      'pinCode': instance.pinCode,
    };
