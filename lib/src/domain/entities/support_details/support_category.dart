import 'package:city_eye/src/domain/entities/support_details/rules.dart';
import 'package:city_eye/src/domain/entities/support_details/supplier.dart';
import 'package:equatable/equatable.dart';

class SupportCategory extends Equatable {
  final int id;
  final String name;
  final String code;
  final bool isSupplier;
  final Supplier supplier;
  final Rules rules;

  const SupportCategory({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.isSupplier = false,
    this.supplier = const Supplier(),
    this.rules = const Rules(),
  });

  @override
  List<Object?> get props => [id, name, code, isSupplier, supplier, rules];
}
