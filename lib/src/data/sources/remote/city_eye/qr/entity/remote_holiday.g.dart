// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_holiday.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteHoliday _$RemoteHolidayFromJson(Map<String, dynamic> json) =>
    RemoteHoliday(
      id: json['id'] as int? ?? 0,
      date: json['date'] as String? ?? "",
      remark: json['remark'] as String? ?? "",
      isExcluded: json['isExcluded'] as bool? ?? false,
      holidayType: json['holiday'] == null
          ? const RemoteHolidayType()
          : RemoteHolidayType.fromJson(json['holiday'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteHolidayToJson(RemoteHoliday instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'remark': instance.remark,
      'isExcluded': instance.isExcluded,
      'holiday': instance.holidayType,
    };
