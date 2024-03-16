// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_event_rules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteEventRules _$RemoteEventRulesFromJson(Map<String, dynamic> json) =>
    RemoteEventRules(
      id: json['id'] as int? ?? 0,
      description: json['description'] as String? ?? "",
      eventId: json['eventId'] as int? ?? 0,
    );

Map<String, dynamic> _$RemoteEventRulesToJson(RemoteEventRules instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'eventId': instance.eventId,
    };
