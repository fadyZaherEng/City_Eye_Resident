import 'package:city_eye/src/domain/entities/settings/validation_rule.dart';
import 'package:equatable/equatable.dart';

class Validation extends Equatable {
  final int id;
  final ValidationRule validationRule;
  final String valueOne;
  final String valueTwo;
  final String validationMessage;

  const Validation({
    this.id = 0,
    this.validationRule = const ValidationRule(),
    this.valueOne = "",
    this.valueTwo = "",
    this.validationMessage = "",
  });

  @override
  List<Object?> get props => [
        id,
        validationRule,
        valueOne,
        valueTwo,
        valueTwo,
        validationMessage,
      ];
}
