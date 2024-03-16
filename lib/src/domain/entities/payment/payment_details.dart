import 'package:city_eye/src/domain/entities/payment/discount_type.dart';
import 'package:equatable/equatable.dart';

class PaymentDetails extends Equatable {
  final int id;
  final int itemId;
  final String itemName;
  final String itemDescription;
  final double unitPrice;
  final int quantity;
  final double tax;
  final double vat;
  final double subTotal;
  final double totalPrice;
  final DiscountType discountType;
  final double discountValue;

  const PaymentDetails({
    this.id = 0,
    this.itemId = 0,
    this.itemName = "",
    this.itemDescription = "",
    this.unitPrice = 0.0,
    this.quantity = 0,
    this.tax = 0.0,
    this.vat = 0.0,
    this.subTotal = 0.0,
    this.totalPrice = 0.0,
    this.discountType = const DiscountType(),
    this.discountValue = 0.0,
  });

  @override
  List<Object> get props => [
        id,
        itemId,
        itemName,
        itemDescription,
        unitPrice,
        quantity,
        tax,
        vat,
        subTotal,
        totalPrice,
        discountType,
        discountValue
      ];
}
