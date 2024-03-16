// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_payment_source_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemotePaymentSourceType _$RemotePaymentSourceTypeFromJson(
        Map<String, dynamic> json) =>
    RemotePaymentSourceType(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
    );

Map<String, dynamic> _$RemotePaymentSourceTypeToJson(
        RemotePaymentSourceType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
