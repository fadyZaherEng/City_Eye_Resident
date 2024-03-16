import 'package:city_eye/src/domain/entities/qr_history/day_time_qr_history.dart';
import 'package:city_eye/src/domain/entities/qr_history/week_day_qr_history.dart';
import 'package:equatable/equatable.dart';

class UnitsQrCodeDay extends Equatable {
  final int id;
  final int unitsQrCodeId;
  final WeekDayQrHistory weekDays;
  final DayTimeQrHistory dayTime;

  const UnitsQrCodeDay({
    this.id = 0,
    this.unitsQrCodeId = 0,
    this.weekDays = const WeekDayQrHistory(),
    this.dayTime = const DayTimeQrHistory(),
  });

  UnitsQrCodeDay copyWith({
    int? id,
    int? unitsQrCodeId,
    WeekDayQrHistory? weekDays,
    DayTimeQrHistory? dayTime,
  }) =>
      UnitsQrCodeDay(
        id: id ?? this.id,
        unitsQrCodeId: unitsQrCodeId ?? this.unitsQrCodeId,
        weekDays: weekDays ?? this.weekDays,
        dayTime: dayTime ?? this.dayTime,
      );

  @override
  List<Object> get props => [
        id,
        unitsQrCodeId,
        weekDays,
        dayTime,
      ];
}
