// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_day_times.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteDayTimes _$RemoteDayTimesFromJson(Map<String, dynamic> json) =>
    RemoteDayTimes(
      id: json['id'] as int? ?? 0,
      time: json['time'] as String? ?? "",
      fromTime: json['fromTime'] as String? ?? "",
      toTime: json['toTime'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteDayTimesToJson(RemoteDayTimes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time,
      'fromTime': instance.fromTime,
      'toTime': instance.toTime,
    };
