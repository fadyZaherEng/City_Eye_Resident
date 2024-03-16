import 'package:city_eye/src/domain/entities/support_details/compound_configuration.dart';
import 'package:city_eye/src/domain/entities/support_details/support_category.dart';
import 'package:equatable/equatable.dart';

class SupportDetailsDate extends Equatable {
  final SupportCategory supportCategory;
  final CompoundConfiguration compoundConfigration;

  const SupportDetailsDate({
    this.supportCategory = const SupportCategory(),
    this.compoundConfigration = const CompoundConfiguration(),
  });

  @override
  List<Object?> get props => [supportCategory, compoundConfigration];
}
