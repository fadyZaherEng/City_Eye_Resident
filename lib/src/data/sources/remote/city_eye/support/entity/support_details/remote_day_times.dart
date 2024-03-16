import 'package:city_eye/src/domain/entities/support_details/day_times.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_day_times.g.dart';

@JsonSerializable()
class RemoteDayTimes {
  final int? id;
  final String? time;
  final String? fromTime;
  final String? toTime;

  const RemoteDayTimes({
    this.id = 0,
    this.time = "",
    this.fromTime = "",
    this.toTime = "",
  });

  factory RemoteDayTimes.fromJson(Map<String, dynamic> json) =>
      _$RemoteDayTimesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteDayTimesToJson(this);
}

extension RemoteDayTimesExtension on RemoteDayTimes {
  DayTimes mapToDomain() {
    return DayTimes(
      id: id ?? 0,
      time: time ?? "",
      fromTime: fromTime ?? "",
      toTime: toTime ?? "",
    );
  }
}

extension RemoteDayTimesListExtension on List<RemoteDayTimes>? {
  List<DayTimes> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
