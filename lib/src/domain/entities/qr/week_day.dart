import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/units_qr_code_day.dart';
import 'package:city_eye/src/domain/entities/qr/day_time.dart';
import 'package:equatable/equatable.dart';

class WeekDay extends Equatable {
  final int id;
  final String code;
  final String name;

  const WeekDay({
    this.id = 0,
    this.code = "",
    this.name = "",
  });

  WeekDay copyWith({
    int? id,
    String? code,
    String? name,
  }) {
    return WeekDay(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  WeekDay deepClone() {
    return WeekDay(
      id: id,
      code: code,
      name: name,
    );
  }


  @override
  List<Object?> get props => [
        id,
        code,
        name,
      ];
}
