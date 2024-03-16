// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_cancel_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCancelRequest _$OrderCancelRequestFromJson(Map<String, dynamic> json) =>
    OrderCancelRequest(
      requestId: json['requestId'] as int,
      statusId: json['statusId'] as int? ?? 5,
    );

Map<String, dynamic> _$OrderCancelRequestToJson(OrderCancelRequest instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'statusId': instance.statusId,
    };
