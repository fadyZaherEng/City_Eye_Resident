import 'package:city_eye/src/domain/entities/qr/holiday.dart';
import 'package:city_eye/src/domain/entities/qr/holiday_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_holiday_type.g.dart';

@JsonSerializable()
class RemoteHolidayType {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;

  const RemoteHolidayType({
    this.id = 0,
    this.name = "",
  });

  factory RemoteHolidayType.fromJson(Map<String, dynamic> json) =>
      _$RemoteHolidayTypeFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteHolidayTypeToJson(this);
}

extension RemoteHolidayTypeExtension on RemoteHolidayType? {
  HolidayType mapToDomain() {
    return HolidayType(
      id: this?.id ?? 0,
      name: this?.name ?? "",
    );
  }
}
