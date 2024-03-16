import 'package:equatable/equatable.dart';

class QrQuestionTypeRules extends Equatable {
  final int id;
  final String code;

  const QrQuestionTypeRules({
    this.id = 0,
    this.code = "",
  });

  @override
  List<Object?> get props => [id, code];

}
