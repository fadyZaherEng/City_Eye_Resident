import 'package:city_eye/src/domain/entities/payment/payment_method.dart';
import 'package:equatable/equatable.dart';

class PaymentRequestPaymentMethods extends Equatable {
  final int id;
  final PaymentMethod paymentMethod;
  final bool isSelected;

  const PaymentRequestPaymentMethods({
    this.id = 0,
    this.paymentMethod = const PaymentMethod(),
    this.isSelected = false,
  });

  PaymentRequestPaymentMethods copyWith({
    int? id,
    PaymentMethod? paymentMethod,
    bool? isSelected,
  }) {
    return PaymentRequestPaymentMethods(
      id: id ?? this.id,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object> get props => [id, paymentMethod, isSelected];
}
