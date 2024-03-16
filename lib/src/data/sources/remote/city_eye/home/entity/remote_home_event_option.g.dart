// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_home_event_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteHomeEventOption _$RemoteHomeEventOptionFromJson(
        Map<String, dynamic> json) =>
    RemoteHomeEventOption(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      eventId: json['eventId'] as int? ?? 0,
      isCalendar: json['isCalendar'] as bool? ?? false,
      isJoin: json['isJoin'] as bool? ?? false,
      isSelectedByUser: json['isSelectedByUser'] as bool? ?? false,
    );

Map<String, dynamic> _$RemoteHomeEventOptionToJson(
        RemoteHomeEventOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'eventId': instance.eventId,
      'isCalendar': instance.isCalendar,
      'isJoin': instance.isJoin,
      'isSelectedByUser': instance.isSelectedByUser,
    };
