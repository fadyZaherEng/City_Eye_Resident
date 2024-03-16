import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_day_time.dart';
import 'package:city_eye/src/domain/entities/qr/day.dart';
import 'package:city_eye/src/domain/entities/qr/week_day.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_week_day.g.dart';

@JsonSerializable()
class RemoteWeekDay {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'code')
  final String? code;

  const RemoteWeekDay({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  factory RemoteWeekDay.fromJson(Map<String, dynamic> json) =>
      _$RemoteWeekDayFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteWeekDayToJson(this);
}

extension RemoteWeekDayExtension on RemoteWeekDay? {
  WeekDay mapToDomain() {
    return WeekDay(
      id: this?.id ?? 0,
      name: this?.name ?? "",
      code: this?.code ?? "",
    );
  }
}

extension RemoteDaysExtension on List<RemoteWeekDay>? {
  List<WeekDay> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
