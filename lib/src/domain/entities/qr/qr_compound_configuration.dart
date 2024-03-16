import 'package:city_eye/src/domain/entities/qr/holiday.dart';
import 'package:city_eye/src/domain/entities/qr/week_day.dart';
import 'package:equatable/equatable.dart';

class QrCompoundConfiguration extends Equatable {
  final String compoundName;
  final List<Holiday> holidays;
  final List<WeekDay> weekEndDays;

  const QrCompoundConfiguration({
    this.compoundName = "",
    this.holidays = const [],
    this.weekEndDays = const [],
  });

  @override
  List<Object?> get props => [
        compoundName,
        holidays,
    weekEndDays,
      ];
}
