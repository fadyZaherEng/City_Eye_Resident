// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_payment_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemotePaymentDetails _$RemotePaymentDetailsFromJson(
        Map<String, dynamic> json) =>
    RemotePaymentDetails(
      id: json['id'] as int? ?? 0,
      itemId: json['itemId'] as int? ?? 0,
      itemName: json['itemName'] as String? ?? "",
      itemDescription: json['itemDescription'] as String? ?? "",
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0,
      quantity: json['quantity'] as int? ?? 0,
      tax: (json['tax'] as num?)?.toDouble() ?? 0,
      vat: (json['vat'] as num?)?.toDouble() ?? 0,
      subTotal: (json['subTotal'] as num?)?.toDouble() ?? 0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0,
      discountType: json['discountType'] == null
          ? const RemoteDiscountType()
          : RemoteDiscountType.fromJson(
              json['discountType'] as Map<String, dynamic>),
      discountValue: (json['discountValue'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$RemotePaymentDetailsToJson(
        RemotePaymentDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'itemDescription': instance.itemDescription,
      'unitPrice': instance.unitPrice,
      'quantity': instance.quantity,
      'tax': instance.tax,
      'vat': instance.vat,
      'subTotal': instance.subTotal,
      'totalPrice': instance.totalPrice,
      'discountType': instance.discountType,
      'discountValue': instance.discountValue,
    };
