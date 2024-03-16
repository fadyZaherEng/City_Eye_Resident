import 'package:equatable/equatable.dart';

class ValidationRule extends Equatable {
  final int id;
  final String code;

  const ValidationRule({
    this.id = 0,
    this.code = "",
  });

  @override
  List<Object?> get props => [
        id,
        code,
      ];
}
