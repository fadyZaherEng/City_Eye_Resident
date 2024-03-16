import 'package:equatable/equatable.dart';

class DiscountType extends Equatable {
  final int id;
  final String type;
  final String code;

  const DiscountType({
    this.id = 0,
    this.type = "",
    this.code = "",
  });

  @override
  List<Object> get props => [id, type, code];
}