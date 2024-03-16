// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteDay _$RemoteDayFromJson(Map<String, dynamic> json) => RemoteDay(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
      times: (json['guestTypeDayTimes'] as List<dynamic>?)
              ?.map((e) => RemoteDayTime.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteDayToJson(RemoteDay instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'guestTypeDayTimes': instance.times,
    };
