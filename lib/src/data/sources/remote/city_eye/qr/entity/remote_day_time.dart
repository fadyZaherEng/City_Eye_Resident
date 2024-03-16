import 'package:city_eye/src/domain/entities/qr/day_time.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_day_time.g.dart';

@JsonSerializable()
class RemoteDayTime {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'time')
  final String? time;

  const RemoteDayTime({
    this.id = 0,
    this.time = "",
  });

  factory RemoteDayTime.fromJson(Map<String, dynamic> json) =>
      _$RemoteDayTimeFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteDayTimeToJson(this);
}

extension RemoteDayTimeExtension on RemoteDayTime? {
  DayTime mapToDomain() {
    return DayTime(
      id: this?.id ?? 0,
      time: this?.time ?? "",
    );
  }
}

extension RemoteDayTimesExtension on List<RemoteDayTime>? {
  List<DayTime> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
