// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_payment_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemotePaymentStatus _$RemotePaymentStatusFromJson(Map<String, dynamic> json) =>
    RemotePaymentStatus(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
      extraValue1: json['extraValue1'] as String? ?? "",
    );

Map<String, dynamic> _$RemotePaymentStatusToJson(
        RemotePaymentStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'extraValue1': instance.extraValue1,
    };
