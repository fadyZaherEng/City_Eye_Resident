import 'package:equatable/equatable.dart';

final class CompoundType extends Equatable {
  final int id;
  final String name;
  final String code;

  const CompoundType({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  @override
  List<Object> get props => [
        id,
        name,
        code,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
    };
  }

  factory CompoundType.fromMap(Map<String, dynamic> map) {
    return CompoundType(
      id: map['id'] as int,
      name: map['name'] as String,
      code: map['code'] as String,
    );
  }
}