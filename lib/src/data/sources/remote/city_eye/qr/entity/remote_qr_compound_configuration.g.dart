// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_qr_compound_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteQrCompoundConfiguration _$RemoteQrCompoundConfigurationFromJson(
        Map<String, dynamic> json) =>
    RemoteQrCompoundConfiguration(
      compoundName: json['compoundName'] as String? ?? "",
      holidays: (json['holidays'] as List<dynamic>?)
              ?.map((e) => RemoteHoliday.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      weekEndDays: (json['weekEndDays'] as List<dynamic>?)
              ?.map((e) => RemoteWeekDay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteQrCompoundConfigurationToJson(
        RemoteQrCompoundConfiguration instance) =>
    <String, dynamic>{
      'compoundName': instance.compoundName,
      'holidays': instance.holidays,
      'weekEndDays': instance.weekEndDays,
    };
