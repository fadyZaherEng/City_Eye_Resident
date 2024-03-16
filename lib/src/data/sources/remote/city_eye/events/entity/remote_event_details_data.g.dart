// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_event_details_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteEventDetailsData _$RemoteEventDetailsDataFromJson(
        Map<String, dynamic> json) =>
    RemoteEventDetailsData(
      link: json['link'] as String? ?? "",
      events: json['events'] == null
          ? const RemoteEvent()
          : RemoteEvent.fromJson(json['events'] as Map<String, dynamic>),
      extraFieldEvents: (json['extraFieldEvents'] as List<dynamic>?)
              ?.map((e) => RemoteExtraField.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteEventDetailsDataToJson(
        RemoteEventDetailsData instance) =>
    <String, dynamic>{
      'link': instance.link,
      'events': instance.events,
      'extraFieldEvents': instance.extraFieldEvents,
    };
