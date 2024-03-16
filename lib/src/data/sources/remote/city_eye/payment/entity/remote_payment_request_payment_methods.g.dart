// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_payment_request_payment_methods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemotePaymentRequestPaymentMethods _$RemotePaymentRequestPaymentMethodsFromJson(
        Map<String, dynamic> json) =>
    RemotePaymentRequestPaymentMethods(
      id: json['id'] as int? ?? 0,
      paymentMethod: json['paymentMethod'] == null
          ? const RemotePaymentMethod()
          : RemotePaymentMethod.fromJson(
              json['paymentMethod'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemotePaymentRequestPaymentMethodsToJson(
        RemotePaymentRequestPaymentMethods instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paymentMethod': instance.paymentMethod,
    };
