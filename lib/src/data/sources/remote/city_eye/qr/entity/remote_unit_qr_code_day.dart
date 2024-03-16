import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_day_time_qr_history.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_week_day_qr_history.dart';
import 'package:city_eye/src/domain/entities/qr_history/unit_qr_code_day.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_unit_qr_code_day.g.dart';

@JsonSerializable(explicitToJson: true)
class RemoteUnitsQrCodeDay {
  final int? id;
  final int? unitsQRCodeId;
  final RemoteWeekDayQrHistory? weekDays;
  final RemoteDayTimeQrHistory? dayTime;

  const RemoteUnitsQrCodeDay({
    this.id = 0,
    this.unitsQRCodeId = 0,
    this.weekDays = const RemoteWeekDayQrHistory(),
    this.dayTime = const RemoteDayTimeQrHistory(),
  });

  factory RemoteUnitsQrCodeDay.fromJson(Map<String, dynamic> json) =>
      _$RemoteUnitsQrCodeDayFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteUnitsQrCodeDayToJson(this);
}

extension RemoteUnitsQrCodeDayExtension on RemoteUnitsQrCodeDay {
  UnitsQrCodeDay mapToDomain() {
    return UnitsQrCodeDay(
      id: id ?? 0,
      unitsQrCodeId: unitsQRCodeId ?? 0,
      weekDays: (weekDays ?? const RemoteWeekDayQrHistory()).mapToDomain(),
      dayTime: (dayTime ?? const RemoteDayTimeQrHistory()).mapToDomain(),
    );
  }
}

extension RemoteUnitsQrCodeDayListExtension on List<RemoteUnitsQrCodeDay>? {
  List<UnitsQrCodeDay> mapToDomain() {
    return this!.map((e) => e.mapToDomain()).toList();
  }
}
