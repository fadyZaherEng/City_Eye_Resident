// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_submit_service_details_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteSubmitServiceDetailsCart _$RemoteSubmitServiceDetailsCartFromJson(
        Map<String, dynamic> json) =>
    RemoteSubmitServiceDetailsCart(
      id: json['id'] as int? ?? 0,
      paymentUrl: json['paymentUrl'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteSubmitServiceDetailsCartToJson(
        RemoteSubmitServiceDetailsCart instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paymentUrl': instance.paymentUrl,
    };
