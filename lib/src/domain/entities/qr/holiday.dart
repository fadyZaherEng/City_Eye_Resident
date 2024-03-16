import 'package:city_eye/src/domain/entities/qr/holiday_type.dart';
import 'package:equatable/equatable.dart';

class Holiday extends Equatable {
  final int id;
  final String date;
  final String remark;
  final bool isExcluded;
  final HolidayType holidayType;

  const Holiday({
    this.id = 0,
    this.date = "",
    this.remark = "",
    this.isExcluded = false,
    this.holidayType = const HolidayType(),
  });

  Holiday deepClone() {
    return Holiday(
      id: id,
      date: date,
      remark: remark,
      isExcluded: isExcluded,
      holidayType: holidayType.deepClone(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        date,
        remark,
        isExcluded,
        holidayType,
      ];
}
