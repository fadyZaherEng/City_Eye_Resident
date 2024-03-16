import 'package:equatable/equatable.dart';

final class QuestionTypeRules extends Equatable {
  final int id;
  final String code;

  const QuestionTypeRules({
    this.id = 0,
    this.code = "",
  });

  QuestionTypeRules copyWith({
    int? id,
    String? code,
  }) =>
      QuestionTypeRules(
        id: id ?? this.id,
        code: code ?? this.code,
      );

  @override
  List<Object> get props => [id, code];

  QuestionTypeRules deepClone() {
    return QuestionTypeRules(
      id: this.id,
      code: this.code,
    );
  }
}
