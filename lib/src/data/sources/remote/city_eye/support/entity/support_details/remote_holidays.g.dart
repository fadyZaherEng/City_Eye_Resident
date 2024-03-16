// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_holidays.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteHolidays _$RemoteHolidaysFromJson(Map<String, dynamic> json) =>
    RemoteHolidays(
      id: json['id'] as int? ?? 0,
      date: json['date'] as String? ?? "",
      remark: json['remark'] as String? ?? "",
      isExcluded: json['isExcluded'] as bool? ?? false,
      holiday: json['holiday'] == null
          ? const RemoteHoliday()
          : RemoteHoliday.fromJson(json['holiday'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteHolidaysToJson(RemoteHolidays instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'remark': instance.remark,
      'isExcluded': instance.isExcluded,
      'holiday': instance.holiday,
    };
