// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_payment_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemotePaymentMethod _$RemotePaymentMethodFromJson(Map<String, dynamic> json) =>
    RemotePaymentMethod(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
    );

Map<String, dynamic> _$RemotePaymentMethodToJson(
        RemotePaymentMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };