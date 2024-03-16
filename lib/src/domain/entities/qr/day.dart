import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/units_qr_code_day.dart';
import 'package:city_eye/src/domain/entities/qr/day_time.dart';
import 'package:equatable/equatable.dart';

class Day extends Equatable {
  final int id;
  final String code;
  final String name;
  final List<DayTime> times;
  final bool isSelected;

  const Day({
    this.id = 0,
    this.code = "",
    this.name = "",
    this.times = const [],
    this.isSelected = false,
  });

  Day copyWith({
    int? id,
    String? code,
    String? name,
    List<DayTime>? times,
    bool? isSelected,
  }) {
    return Day(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      times: times ?? this.times,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Day deepClone() {
    return Day(
      id: id,
      code: code,
      name: name,
      times: times.map((e) => e.deepClone()).toList(),
      isSelected: isSelected,
    );
  }


  @override
  List<Object?> get props => [
        id,
        code,
        name,
        times,
        isSelected,
      ];
}

extension DayExtension on Day {
  UnitsQrCodeDay toUnitsQrCodeDay() {
    return UnitsQrCodeDay(
      id: id,
      name: name,
      code: code,
      timeId: times.where((element) {
        if(element.isSelected) {
          return true;
        } else {
          return false;
        }
      }).toList().first.id,
    );
  }
}

extension DaysExtension on List<Day> {
  List<UnitsQrCodeDay> toUnitsQrCodeDays() {
    return map((e) => e.toUnitsQrCodeDay()).toList();
  }
}