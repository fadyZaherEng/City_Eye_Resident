import 'package:city_eye/src/data/sources/remote/city_eye/payment/entity/remote_discount_type.dart';
import 'package:city_eye/src/domain/entities/payment/payment_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_payment_details.g.dart';

@JsonSerializable()
class RemotePaymentDetails {
  final int? id;
  final int? itemId;
  final String? itemName;
  final String? itemDescription;
  final double? unitPrice;
  final int? quantity;
  final double? tax;
  final double? vat;
  final double? subTotal;
  final double? totalPrice;
  final RemoteDiscountType? discountType;
  final double? discountValue;

  const RemotePaymentDetails({
    this.id = 0,
    this.itemId = 0,
    this.itemName = "",
    this.itemDescription = "",
    this.unitPrice = 0,
    this.quantity = 0,
    this.tax = 0,
    this.vat = 0,
    this.subTotal = 0,
    this.totalPrice = 0,
    this.discountType = const RemoteDiscountType(),
    this.discountValue = 0,
  });

  factory RemotePaymentDetails.fromJson(Map<String, dynamic> json) =>
      _$RemotePaymentDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$RemotePaymentDetailsToJson(this);
}

extension RemotePaymentDetailsExtension on RemotePaymentDetails {
  PaymentDetails get mapToDomain {
    return PaymentDetails(
      id: id ?? 0,
      itemId: itemId ?? 0,
      itemName: itemName ?? "",
      itemDescription: itemDescription ?? "",
      unitPrice: unitPrice ?? 0.0,
      quantity: quantity ?? 0,
      tax: tax ?? 0.0,
      vat: vat ?? 0.0,
      subTotal: subTotal ?? 0.0,
      totalPrice: totalPrice ?? 0.0,
      discountType: (discountType ?? const RemoteDiscountType()).mapToDomain,
      discountValue: discountValue ?? 0.0,
    );
  }
}

extension PaymentDetailsExtensionList on List<RemotePaymentDetails> {
  List<PaymentDetails> get mapToDomain {
    return map((e) => e.mapToDomain).toList();
  }
}
