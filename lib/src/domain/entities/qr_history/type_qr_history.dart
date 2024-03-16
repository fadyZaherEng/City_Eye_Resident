import 'package:equatable/equatable.dart';

class TypeQrHistory extends Equatable {
  final int id;
  final String code;
  final String name;

  const TypeQrHistory({
    this.id = 0,
    this.code = "",
    this.name = "",
  });

  TypeQrHistory copyWith({
    int? id,
    String? code,
    String? name,
  }) =>
      TypeQrHistory(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
      );

  @override
  List<Object> get props => [id, code, name];
}
