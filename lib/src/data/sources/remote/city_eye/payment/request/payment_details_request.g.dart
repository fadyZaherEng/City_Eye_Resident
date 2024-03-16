// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_details_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDetailsRequest _$PaymentDetailsRequestFromJson(
        Map<String, dynamic> json) =>
    PaymentDetailsRequest(
      invoiceId: json['invoiceId'] as int,
    );

Map<String, dynamic> _$PaymentDetailsRequestToJson(
        PaymentDetailsRequest instance) =>
    <String, dynamic>{
      'invoiceId': instance.invoiceId,
    };
