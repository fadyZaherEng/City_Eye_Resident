import 'package:city_eye/src/domain/entities/support_details/holiday.dart';
import 'package:equatable/equatable.dart';

class Holidays extends Equatable {
  final int id;
  final String date;
  final String remark;
  final bool isExcluded;
  final Holiday holiday;

  const Holidays({
    this.id = 0,
    this.date = "",
    this.remark = "",
    this.isExcluded = false,
    this.holiday = const Holiday(),
  });


  @override
  List<Object?> get props => [id, date, remark, isExcluded, holiday];
}