import 'package:equatable/equatable.dart';

final class MultiMediaTypes extends Equatable {
  final int id;
  final bool isVisible;
  final String code;

  const MultiMediaTypes({
    this.id = 0,
    this.isVisible = false,
    this.code = "",
  });

  @override
  List<Object> get props => [
        id,
        isVisible,
        code,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isVisible': isVisible,
      'code': code,
    };
  }

  factory MultiMediaTypes.fromMap(Map<String, dynamic> map) {
    return MultiMediaTypes(
      id: map['id'] as int,
      isVisible: map['isVisible'] as bool,
      code: map['code'] as String,
    );
  }
}
