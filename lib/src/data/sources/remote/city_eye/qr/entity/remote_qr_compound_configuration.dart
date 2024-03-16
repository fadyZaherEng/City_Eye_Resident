import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_holiday.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_week_day.dart';
import 'package:city_eye/src/domain/entities/qr/qr_compound_configuration.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_qr_compound_configuration.g.dart';

@JsonSerializable()
class RemoteQrCompoundConfiguration {
  @JsonKey(name: 'compoundName')
  final String? compoundName;
  @JsonKey(name: 'holidays')
  final List<RemoteHoliday>? holidays;
  @JsonKey(name: 'weekEndDays')
  final List<RemoteWeekDay>? weekEndDays;

  const RemoteQrCompoundConfiguration({
    this.compoundName = "",
    this.holidays = const [],
    this.weekEndDays = const [],
  });

  factory RemoteQrCompoundConfiguration.fromJson(Map<String, dynamic> json) =>
      _$RemoteQrCompoundConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteQrCompoundConfigurationToJson(this);
}

extension RemoteQrCompoundConfigurationExtension
    on RemoteQrCompoundConfiguration? {
  QrCompoundConfiguration mapToDomain() {
    return QrCompoundConfiguration(
      compoundName: this?.compoundName ?? "",
      holidays: this?.holidays.mapToDomain() ?? [],
      weekEndDays: this?.weekEndDays.mapToDomain() ?? [],
    );
  }
}
