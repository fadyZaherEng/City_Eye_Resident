import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_day_time.dart';
import 'package:city_eye/src/domain/entities/qr/day.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_day.g.dart';

@JsonSerializable()
class RemoteDay {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'guestTypeDayTimes')
  final List<RemoteDayTime>? times;

  const RemoteDay({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.times = const [],
  });

  factory RemoteDay.fromJson(Map<String, dynamic> json) =>
      _$RemoteDayFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteDayToJson(this);
}

extension RemoteDayExtension on RemoteDay? {
  Day mapToDomain() {
    return Day(
      id: this?.id ?? 0,
      name: this?.name ?? "",
      code: this?.code ?? "",
      times: this?.times?.mapToDomain() ?? [],
    );
  }
}

extension RemoteDaysExtension on List<RemoteDay>? {
  List<Day> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
