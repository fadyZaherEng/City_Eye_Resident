import 'package:equatable/equatable.dart';

class PaymentUrl extends Equatable{
  final String paymentUrl;

  const PaymentUrl({
    this.paymentUrl = "",
  });

  @override
  List<Object?> get props => [
    paymentUrl,
  ];
}