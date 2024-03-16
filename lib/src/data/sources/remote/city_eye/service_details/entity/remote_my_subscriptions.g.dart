// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_my_subscriptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteMySubscriptions _$RemoteMySubscriptionsFromJson(
        Map<String, dynamic> json) =>
    RemoteMySubscriptions(
      id: json['id'] as int? ?? 0,
      servicePackages: json['servicePackages'] == null
          ? const RemoteServicePackages()
          : RemoteServicePackages.fromJson(
              json['servicePackages'] as Map<String, dynamic>),
      serviceCount: json['serviceCount'] as int? ?? 0,
      price: json['price'] as int? ?? 0,
      discount: json['discount'] as int? ?? 0,
      totalPrice: json['totalPrice'] as int? ?? 0,
      sessionNo: json['sessionNo'] as int? ?? 0,
      expireDate: json['expireDate'] as String? ?? "",
      qrImage: json['qrImage'] as String? ?? "",
      pinCode: json['pinCode'] as int? ?? 0,
    );

Map<String, dynamic> _$RemoteMySubscriptionsToJson(
        RemoteMySubscriptions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'servicePackages': instance.servicePackages?.toJson(),
      'serviceCount': instance.serviceCount,
      'price': instance.price,
      'discount': instance.discount,
      'totalPrice': instance.totalPrice,
      'sessionNo': instance.sessionNo,
      'expireDate': instance.expireDate,
      'qrImage': instance.qrImage,
      'pinCode': instance.pinCode,
    };
