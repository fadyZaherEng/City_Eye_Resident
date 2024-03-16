// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_support_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteSupportDate _$RemoteSupportDateFromJson(Map<String, dynamic> json) =>
    RemoteSupportDate(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      date: json['time'] as String? ?? '',
    );

Map<String, dynamic> _$RemoteSupportDateToJson(RemoteSupportDate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'time': instance.date,
    };
