import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/support_details/remote_day_times.dart';
import 'package:city_eye/src/domain/entities/support_details/days.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_days.g.dart';

@JsonSerializable()
class RemoteDays {
  final int? id;
  final String? name;
  final String? code;
  final List<RemoteDayTimes>? dayTimes;

  const RemoteDays({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.dayTimes = const [],
  });

  factory RemoteDays.fromJson(Map<String, dynamic> json) =>
      _$RemoteDaysFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteDaysToJson(this);
}

extension DaysExtension on RemoteDays {
  Days mapToDomain() {
    return Days(
      id: id ?? 0,
      name: name ?? "",
      code: code ?? "",
      dayTimes: (dayTimes ?? []).mapToDomain()
    );
  }
}

extension DaysListExtension on List<RemoteDays>? {
  List<Days> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}