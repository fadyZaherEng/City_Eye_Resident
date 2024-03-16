import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_holiday_type.dart';
import 'package:city_eye/src/domain/entities/qr/holiday.dart';
import 'package:city_eye/src/domain/entities/qr/holiday_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_holiday.g.dart';

@JsonSerializable()
class RemoteHoliday {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'remark')
  final String? remark;
  @JsonKey(name: 'isExcluded')
  final bool? isExcluded;
  @JsonKey(name: 'holiday')
  final RemoteHolidayType? holidayType;

  const RemoteHoliday({
    this.id = 0,
    this.date = "",
    this.remark = "",
    this.isExcluded =false,
    this.holidayType = const RemoteHolidayType(),
  });

  factory RemoteHoliday.fromJson(Map<String, dynamic> json) =>
      _$RemoteHolidayFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteHolidayToJson(this);
}

extension RemoteHolidayExtension on RemoteHoliday? {
  Holiday mapToDomain() {
    return Holiday(
      id: this?.id ?? 0,
      date: this?.date ?? "",
      remark: this?.remark ?? "",
      isExcluded: this?.isExcluded ?? false,
      holidayType: this?.holidayType?.mapToDomain() ?? const HolidayType(),
    );
  }
}

extension RemoteHolidaysExtension on List<RemoteHoliday>? {
  List<Holiday> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
