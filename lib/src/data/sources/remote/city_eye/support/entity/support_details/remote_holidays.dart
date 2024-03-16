import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/support_details/remote_holiday.dart';
import 'package:city_eye/src/domain/entities/support_details/holidays.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_holidays.g.dart';

@JsonSerializable()
class RemoteHolidays {
  final int? id;
  final String? date;
  final String? remark;
  final bool? isExcluded;
  final RemoteHoliday? holiday;

  const RemoteHolidays({
    this.id = 0,
    this.date = "",
    this.remark = "",
    this.isExcluded = false,
    this.holiday = const RemoteHoliday(),
  });

  factory RemoteHolidays.fromJson(Map<String, dynamic> json) =>
      _$RemoteHolidaysFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteHolidaysToJson(this);
}

extension RemoteHolidaysExtension on RemoteHolidays {
  Holidays mapToDomain() {
    return Holidays(
      id: id ?? 0,
      date: date ?? "",
      remark: remark ?? "",
      isExcluded: isExcluded ?? false,
      holiday: (holiday ?? const RemoteHoliday()).mapToDomain(),
    );
  }
}

extension RemoteHolidaysListExtension on List<RemoteHolidays>? {
  List<Holidays> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
