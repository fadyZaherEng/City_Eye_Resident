// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_event_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteEventData _$RemoteEventDataFromJson(Map<String, dynamic> json) =>
    RemoteEventData(
      events: (json['events'] as List<dynamic>?)
              ?.map((e) => RemoteEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      extraFieldEvents: (json['extraFieldEvents'] as List<dynamic>?)
              ?.map((e) => RemoteExtraField.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteEventDataToJson(RemoteEventData instance) =>
    <String, dynamic>{
      'events': instance.events,
      'extraFieldEvents': instance.extraFieldEvents,
    };
