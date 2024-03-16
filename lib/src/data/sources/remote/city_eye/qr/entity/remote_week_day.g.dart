// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_week_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteWeekDay _$RemoteWeekDayFromJson(Map<String, dynamic> json) =>
    RemoteWeekDay(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteWeekDayToJson(RemoteWeekDay instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
