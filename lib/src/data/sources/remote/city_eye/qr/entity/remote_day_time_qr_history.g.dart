// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_day_time_qr_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteDayTimeQrHistory _$RemoteDayTimeQrHistoryFromJson(
        Map<String, dynamic> json) =>
    RemoteDayTimeQrHistory(
      id: json['id'] as int? ?? 0,
      fromTime: json['fromTime'] as String? ?? "",
      toTime: json['toTime'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteDayTimeQrHistoryToJson(
        RemoteDayTimeQrHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromTime': instance.fromTime,
      'toTime': instance.toTime,
    };
