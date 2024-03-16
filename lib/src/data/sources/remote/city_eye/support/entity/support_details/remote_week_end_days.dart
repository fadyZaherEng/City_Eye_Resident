
import 'package:city_eye/src/domain/entities/support_details/week_end_days.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_week_end_days.g.dart';

@JsonSerializable()
class RemoteWeekEndDays {
  final int? id;
  final String? name;
  final String? code;

  const RemoteWeekEndDays({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  factory RemoteWeekEndDays.fromJson(Map<String, dynamic> json) =>
      _$RemoteWeekEndDaysFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteWeekEndDaysToJson(this);
}

extension RemoteWeekEndDaysExtension on RemoteWeekEndDays {
  WeekEndDays mapToDomain() {
    return WeekEndDays(
      id: id ?? 0,
      name: name ?? "",
      code: code ?? "",
    );
  }
}

extension RemoteWeekEndDaysListExtension on List<RemoteWeekEndDays>? {
  List<WeekEndDays> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
