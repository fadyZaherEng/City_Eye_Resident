
import 'package:city_eye/src/domain/entities/qr_history/day_time_qr_history.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_day_time_qr_history.g.dart';

@JsonSerializable()
class RemoteDayTimeQrHistory {
  final int? id;
  final String? fromTime;
  final String? toTime;

  const RemoteDayTimeQrHistory({
    this.id = 0,
    this.fromTime = "",
    this.toTime = "",
  });

  factory RemoteDayTimeQrHistory.fromJson(Map<String, dynamic> json) =>
      _$RemoteDayTimeQrHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteDayTimeQrHistoryToJson(this);

}

extension RemoteDayTimeQrHistoryExtension on RemoteDayTimeQrHistory {
  DayTimeQrHistory mapToDomain() {
    return DayTimeQrHistory(
      id: id ?? 0,
      fromTime: fromTime ?? "",
      toTime: toTime ?? "",
    );
  }
}
