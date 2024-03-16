import 'package:city_eye/src/domain/entities/support_details/day_times.dart';
import 'package:equatable/equatable.dart';

class Days extends Equatable {
  final int id;
  final String name;
  final String code;
  final List<DayTimes> dayTimes;

  const Days({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.dayTimes = const [],
  });

  @override
  List<Object?> get props => [id, name, code, dayTimes];

  Days copyWith({
    int? id,
    String? name,
    String? code,
    List<DayTimes>? dayTimes,
    bool? isSelected,
  }) {
    return Days(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      dayTimes: dayTimes ?? this.dayTimes,
    );
  }
}
