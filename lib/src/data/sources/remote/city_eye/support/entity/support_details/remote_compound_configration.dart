import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/support_details/remote_holidays.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/support_details/remote_week_end_days.dart';
import 'package:city_eye/src/domain/entities/support_details/compound_configuration.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_compound_configration.g.dart';

@JsonSerializable()
class RemoteCompoundConfiguration {
  final String? compoundName;
  final List<RemoteHolidays>? holidays;
  final List<RemoteWeekEndDays>? weekEndDays;

  const RemoteCompoundConfiguration({
    this.compoundName = "",
    this.holidays = const [],
    this.weekEndDays = const [],
  });

  factory RemoteCompoundConfiguration.fromJson(Map<String, dynamic> json) =>
      _$RemoteCompoundConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCompoundConfigurationToJson(this);
}

extension CompoundConfigurationExtension on RemoteCompoundConfiguration {
  CompoundConfiguration mapToDomain() {
    return CompoundConfiguration(
      compoundName: compoundName ?? "",
      holidays: (holidays ?? []).mapToDomain(),
      weekEndDays: (weekEndDays ?? []).mapToDomain()
    );
  }
}

extension CompoundConfigurationListExtension on List<RemoteCompoundConfiguration>? {
  List<CompoundConfiguration> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
