import 'package:equatable/equatable.dart';

final class PaymentMethod extends Equatable {
  final int id;
  final String name;
  final String code;

  const PaymentMethod({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  @override
  List<Object> get props => [id, name, code];
}
