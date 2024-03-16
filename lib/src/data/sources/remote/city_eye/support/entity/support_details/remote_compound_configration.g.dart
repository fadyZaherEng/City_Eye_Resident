// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_compound_configration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCompoundConfiguration _$RemoteCompoundConfigurationFromJson(
        Map<String, dynamic> json) =>
    RemoteCompoundConfiguration(
      compoundName: json['compoundName'] as String? ?? "",
      holidays: (json['holidays'] as List<dynamic>?)
              ?.map((e) => RemoteHolidays.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      weekEndDays: (json['weekEndDays'] as List<dynamic>?)
              ?.map(
                  (e) => RemoteWeekEndDays.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteCompoundConfigurationToJson(
        RemoteCompoundConfiguration instance) =>
    <String, dynamic>{
      'compoundName': instance.compoundName,
      'holidays': instance.holidays,
      'weekEndDays': instance.weekEndDays,
    };
