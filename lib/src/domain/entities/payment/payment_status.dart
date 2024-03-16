import 'package:equatable/equatable.dart';

class PaymentStatus extends Equatable {
  final int id;
  final String name;
  final String code;
  final String extraValue1;

  const PaymentStatus({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.extraValue1 = "",
  });

  @override
  List<Object> get props => [id, name, code, extraValue1];
}