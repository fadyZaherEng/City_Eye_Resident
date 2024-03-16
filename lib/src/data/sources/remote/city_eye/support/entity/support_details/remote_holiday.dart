import 'package:city_eye/src/domain/entities/support_details/holiday.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_holiday.g.dart';

@JsonSerializable()
class RemoteHoliday {
  final int? id;
  final String? name;

  const RemoteHoliday({
    this.id,
    this.name,
  });

  factory RemoteHoliday.fromJson(Map<String, dynamic> json) =>
      _$RemoteHolidayFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteHolidayToJson(this);
}

extension RemoteHolidayExtension on RemoteHoliday {
  Holiday mapToDomain() {
    return Holiday(
      id: id ?? 0,
      name: name ?? "",
    );
  }
}
