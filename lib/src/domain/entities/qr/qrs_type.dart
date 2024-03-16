import 'package:city_eye/src/domain/entities/qr/day_time.dart';
import 'package:equatable/equatable.dart';

class QrsType extends Equatable {
  final int id;
  final String code;
  final String name;
  final bool isSelected;

  const QrsType({
    this.id = 0,
    this.code = "",
    this.name = "",
    this.isSelected = false,
  });

  QrsType copyWith({
    int? id,
    String? code,
    String? name,
    bool? isSelected,
  }) {
    return QrsType(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  QrsType deepClone() {
    return QrsType(
      id: id,
      code: code,
      name: name,
      isSelected: isSelected,
    );
  }

  @override
  List<Object?> get props => [
        id,
        code,
        name,
        isSelected,
      ];
}
