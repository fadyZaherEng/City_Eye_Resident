import 'package:city_eye/src/domain/entities/support_details/holidays.dart';
import 'package:city_eye/src/domain/entities/support_details/week_end_days.dart';
import 'package:equatable/equatable.dart';

class CompoundConfiguration extends Equatable {
  final String compoundName;
  final List<Holidays> holidays;
  final List<WeekEndDays> weekEndDays;

  const CompoundConfiguration({
    this.compoundName = "",
    this.holidays = const [],
    this.weekEndDays = const [],
  });

  @override
  List<Object?> get props => [compoundName, holidays, weekEndDays];
}
