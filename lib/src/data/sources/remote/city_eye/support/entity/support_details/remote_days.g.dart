// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_days.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteDays _$RemoteDaysFromJson(Map<String, dynamic> json) => RemoteDays(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
      dayTimes: (json['dayTimes'] as List<dynamic>?)
              ?.map((e) => RemoteDayTimes.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteDaysToJson(RemoteDays instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'dayTimes': instance.dayTimes,
    };
