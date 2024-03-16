// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_unit_qr_code_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteUnitsQrCodeDay _$RemoteUnitsQrCodeDayFromJson(
        Map<String, dynamic> json) =>
    RemoteUnitsQrCodeDay(
      id: json['id'] as int? ?? 0,
      unitsQRCodeId: json['unitsQRCodeId'] as int? ?? 0,
      weekDays: json['weekDays'] == null
          ? const RemoteWeekDayQrHistory()
          : RemoteWeekDayQrHistory.fromJson(
              json['weekDays'] as Map<String, dynamic>),
      dayTime: json['dayTime'] == null
          ? const RemoteDayTimeQrHistory()
          : RemoteDayTimeQrHistory.fromJson(
              json['dayTime'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteUnitsQrCodeDayToJson(
        RemoteUnitsQrCodeDay instance) =>
    <String, dynamic>{
      'id': instance.id,
      'unitsQRCodeId': instance.unitsQRCodeId,
      'weekDays': instance.weekDays?.toJson(),
      'dayTime': instance.dayTime?.toJson(),
    };
